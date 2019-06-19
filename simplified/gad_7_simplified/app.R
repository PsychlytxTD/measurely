library(shinydashboard)
library(magrittr)
library(purrr)
library(tidyr)
library(dplyr)
library(lubridate)
library(chron)
library(shinyjs)
library(RPostgreSQL)
library(DBI)
library(pool)
library(ggplot2)
library(postGIStools)
library(DT)
library(shinyjs)
library(memor)
library(extrafont)
library(extrafontdb)
library(shinyhelper)
library(shinyWidgets)
library(shinycssloaders)
library(grid)
library(httr)


pool <- dbPool( #Set up the pool connection management
  drv = dbDriver("PostgreSQL"),
  dbname = "scaladb",
  host = "scaladb.cdanbvyi6gfm.ap-southeast-2.rds.amazonaws.com",
  user = "jameslovie",
  password = "e2534e41-bbb6-4e2b-b687-71c5be7c7d35"
)


onStop(function() { 
  #Close pool object when session ends
  poolClose(pool)
  
})



ui<- function(request) {
  
  
  dashboardPage(
    
    header<- psychlytx::make_header_UI("header", psychlytx::GAD_7$title), #Make the header
    
    sidebar <- psychlytx::make_simplified_sidebar_UI("sidebar"), #Make the sidebar
    
    dashboardBody(
      
      tags$head( 
        
        tags$link(rel = "stylesheet", type = "text/css", href = "Styling.css") #Link to the css style sheet,
        
      ),
      
      tabItems(
        
        tabItem(tabName = "Home", 
                
                fluidRow(
                  
                  tabBox(id = "tabset", width = 12,
                         
                         tabPanel(h3(tags$strong("Sign In")),
                                  
                                  psychlytx::read_holding_stats_UI("read_holding_stats")
                                  
                                  ),
                         
                       
                         tabPanel(h3(tags$strong("Complete Questionnaire")), value = "go_questionnaire",
                                  
                                  h3(textOutput("client_name_message")),
                            
                                  psychlytx::gad7_scale_UI("gad7_scale"), #Item of the specific measure
                  
                                  psychlytx::manual_data_UI("manual_data"), #Items of the specific measure are passed here as a string of numbers
                                  
                                  psychlytx::format_gad7_responses_for_email_UI("format_repsonses_for_email"),
                                  
                                  psychlytx::calculate_subscale_UI("calculate_subscales"), #Calculate all aggregate subscale scores for the measure
                                  
                                  psychlytx::collect_input_UI("collect_input_1"), #Collect all input for a subscale
                                  
                                  psychlytx::combine_all_input_UI("combine_all_input"), #Combine collected inputs from all subscales
                                  
                                  psychlytx::write_measure_data_to_db_UI("write_measure_data")
                         ),
                         
                         
                         useShinyjs(),
                         
                         tabPanel(h3(tags$strong("Client Settings", id = "hide_settings")), 
                                  
                                  fluidPage(
                                    
                                    fluidRow(
                                      
                                      tabsetPanel(type = "pills",
                                                  
                                                  tabPanel("Reliable Change Method", width = 12,
                                                           
                                                           psychlytx::simplified_method_widget_UI("method_widget") #Reliable change method widget for one subscale
                                                  ),
                                                  
                                                  tabPanel("Mean", width = 12, 
                                                           
                                                           psychlytx::generate_simplified_mean_widget_UI("mean_widget_1") #Mean widget for one subscale
                                                  ),
                                                  
                                                  tabPanel("Sd", width = 12,
                                                           
                                                           psychlytx::generate_simplified_sd_widget_UI("sd_widget_1") #Sd widget for one subscale
                                                  ),
                                                  
                                                  tabPanel("Test-Retest Reliability", width = 12,
                                                           
                                                           psychlytx::generate_simplified_reliability_widget_UI("reliability_widget_1") #Reliability widget for one subscale
                                                           
                                                           
                                                  ),
                                                  
                                                  tabPanel("Confidence Level", width = 12,
                                                           
                                                           psychlytx::simplified_confidence_level_UI("confidence_widget") #Confidence level widget for one subscale
                                                           
                                                  ),
                                                  
                                                  tabPanel("User-Defined Cut-Off Scores", width = 12,
                                                           
                                                           psychlytx::generate_simplified_cutoff_widget_UI("cutoff_widget_1") #Cutoff widgets for one subscale
                                                           
                                                  ))))))),
                
                column(span(tagList(icon("copyright", lib = "font-awesome")), "PsychlytX | 2019") , offset = 4, width = 12)),
        
        
        about_tab<- psychlytx::make_about_tab_UI("about_tab") #Make the 'About Psychlytx' tab
        
      )))
  
}






server <- function(input, output, session) {
  
  observe_helpers()#Needed for use of the shinyhelpers package
  
  callModule(psychlytx::make_simplified_sidebar, "sidebar") #Make sidebar
  
  callModule(psychlytx::make_header, "header") #Make header
  
  observe({
    
    shinyjs::hideElement(id= "hide_settings")
    
  })
  
  
  holding_data<- callModule(psychlytx::read_holding_stats, "read_holding_stats", pool, measure = psychlytx::GAD_7$measure) 
  
  
  output$client_name_message<- renderText({ paste("Name:", holding_data()$first_name, holding_data()$last_name )})
  
  
  scale_entry<- callModule(psychlytx::gad7_scale, "gad7_scale") #Return the raw responses to the online scale
  
  
  manual_entry<- callModule(psychlytx::manual_data, "manual_data", scale_entry) #Raw item responses are stored as vector manual_entry to be used downstream
  

  
  aggregate_scores<- callModule(psychlytx::calculate_subscale, "calculate_subscales",  manual_entry = manual_entry, item_index = list( psychlytx::GAD_7$items ), 
                                aggregation_method = "sum")   #Make a list of aggregate scores across subscales (in this case there is only one subscale)
  
  
  confidence<- callModule(psychlytx::simplified_confidence_level, "confidence_widget", holding_data)  #Return confidence level for intervals. Existing data passed in order to 
  #access & pull in the client's settings from db & prepopulate settings
  #widgets with these settings. Do same things for method, mean, sd, 
  #reliability and cutoffs
  
  
  method<- callModule(psychlytx::simplified_method_widget, "method_widget", holding_data) #Return reliable change method (a string)
  
  
  #_________________________________________________________________________________________________
  
  #For each subscale individually, collect the values from widgets and store them in a list 
  
  mean_input_1<- do.call(callModule, c(psychlytx::generate_simplified_mean_widget, "mean_widget_1", subscale_number = 1, statistic_type = "mean", holding_data))
  sd_input_1<- do.call(callModule, c(psychlytx::generate_simplified_sd_widget, "sd_widget_1",  subscale_number = 1, statistic_type = "sd", holding_data))
  reliability_input_1<- do.call(callModule, c(psychlytx::generate_simplified_reliability_widget, "reliability_widget_1", subscale_number = 1, statistic_type = "reliability", 
                                              holding_data))
  cutoff_input_1<- do.call(callModule, c(psychlytx::generate_simplified_cutoff_widget, "cutoff_widget_1", subscale_number = 1, holding_data))
  
  #Create list of input values for a subscale 
  
  input_list_1<- callModule(psychlytx::simplified_collect_holding_input, "collect_input_1", holding_data, manual_entry, aggregate_scores, mean_input_1, sd_input_1, reliability_input_1, 
                            confidence, method, cutoff_input_1, subscale_number = 1)
  
  
  #_______________________________________________________________________________Currently, the code in between hashes must be written for each subscale 
  
  
  
  #Have to store the list of sublists as a reactive object
  
  
  input_list<- reactive({ list( input_list_1() ) })  #Store each list of input values in a larger list object (i.e. all_input). If there were more than one 
  #subscale it would look like this: input_list<- reactive({ list( input_list_1(), input_list_2(), etc. ) })
  #After creating the list of lists, flatten each sublist and set the names of sublist elements so that they 
  #are the same across lists - this will ensure we can iterate over the lists using purrr. 
  #So pass the input_list object to the combine_all_input module.
  
  
  
  simplified_measure_data<- callModule(psychlytx::combine_all_input, "combine_all_input", input_list)  #Generate a dataframe with all necessary scale data (date, score, pts, se,
  #ci etc.). This dataframe will be sent to the db
  
  
  #Use the appropriate response formatting module (one for each measure). Returns a string representing the body text to be sent.
  formatted_response_body_for_email<- callModule(psychlytx::format_gad7_responses_for_email, "format_repsonses_for_email", pool, manual_entry, simplified_measure_data)
  
  
  callModule(psychlytx::write_measure_data_to_db, "write_measure_data", pool, simplified_measure_data, manual_entry, formatted_response_body_for_email)  #Write newly entered item responses from measure to db
  

}



shinyApp(ui, server)
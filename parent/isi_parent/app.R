library(shinydashboard)
library(magrittr)
library(purrr)
library(tidyr)
library(dplyr)
library(knitr)
library(lubridate)
library(chron)
library(grid)
library(shinyjs)
library(RPostgreSQL)
library(DBI)
library(pool)
library(ggplot2)
library(ggrepel)
library(DT)
library(memor)
library(extrafont)
library(extrafontdb)
library(shinyhelper)
library(shinyWidgets)
library(shinycssloaders)
library(httr)
library(car)
library(purrrlyr)
library(uuid)
library(shinyBS)
library(tibble)
library(aws.s3)
library(glue)


pool <- dbPool( #Set up the connection with the db
  drv = dbDriver("PostgreSQL"),
  dbname = "scaladb",
  host = "scaladb.cdanbvyi6gfm.ap-southeast-2.rds.amazonaws.com",
  user = "jameslovie",
  password = Sys.getenv("PGPASSWORD")
)


onStop(function() { 
  #Close pool object when session ends
  poolClose(pool)
  
})



global_subscale_info<- psychlytx::import_global_subscale_info() #Retrieve the global_subscale_info list from S3

subscale_info_1<- global_subscale_info[["ISI"]] #Subset the global list to retrive the subscale list(s) for this particular measure
#All of the subscale lists should be upper case acronyms with words separated by underscores


clinician_email<- "timothydeitz@gmail.com"  #Sys.getenv("SHINYPROXY_USERNAME")  ##This is how we will access the clinician username (i.e. email) to pass to the modules

#url<- "https://scala.au.auth0.com/userinfo"

#clinician_object<- httr::GET( url, httr::add_headers(Authorization = paste("Bearer", Sys.getenv("SHINYPROXY_OIDC_ACCESS_TOKEN")),
#`Content-Type` = "application/json"))

#clinician_object<- httr::content(clinician_object)

clinician_id<- "auth0|5c99f47197d7ec57ff84527e" #paste(clinician_object["sub"]) #Access the id object




ui<- function(request) {
  
  
  dashboardPage(
    
    header<- psychlytx::make_header_UI("header", subscale_info_1$title), #Make the header
    
    sidebar <- psychlytx::make_sidebar_UI("sidebar"), #Make the sidebar
    
    dashboardBody(
      
      tags$head( 
        
        tags$link(rel = "stylesheet", type = "text/css", href = "Styling.css") #Link to the css style sheet,
        
      ),
      
      tabItems(
        
        tabItem(tabName = "Landing",
                
                psychlytx::make_landing_UI("make_landing")
                
        ),
        
        
        
        
        
        tabItem(tabName = "Home", 
                
                fluidRow(
                  
                  tabBox(id = "tabset", width = 12,
                         
                         tabPanel(tags$strong("Register A New Client "),
                                  
                                  psychlytx::analytics_pretherapy_UI("analytics_pretherapy"), #Make the client registration panel
                                  
                                  psychlytx::write_pretherapy_to_db_UI("write_pretherapy_to_db")
                                  
                         ),
                         
                         
                         tabPanel(tags$strong("Select An Existing Client", id = "refresh_client_dropdown"),
                                  
                                  sidebarLayout(
                                    
                                    sidebarPanel(width = 6,
                                                 
                                                 psychlytx::render_client_dropdown_UI("client_dropdown"),
                                                 
                                                 actionButton("retrieve_client_data", "Select Client", class = "submit_button"),
                                                 
                                                 psychlytx::retrieve_client_name_UI("retrieve_client_name"),
                                                 
                                                 shinyBS::bsModal("show_population_modal", "Please indicate the stage of treatment", "retrieve_client_data", size = "large",
                                                                  
                                                                  psychlytx::apply_initial_population_UI("apply_population")
                                                                  
                                                 ),
                                                 
                                                 
                                                 br(),
                                                 br(),
                                                 
                                                 tags$a(href = "https://measurely-edit-records.psychlytx.com/", "Edit your client's records here.", style = "color:#d35400; text-decoration: underline;")
                                                 
                                    ),
                                    
                                    mainPanel(
                                      
                                      psychlytx::display_client_data_UI("display_client_data")
                                      
                                      
                                    ))),
                         
                         
                         tabPanel(tags$strong("Complete Measure"),
                                  
                                  psychlytx::show_client_name_UI("show_client_name_measure_tab"),
                                  
                                  psychlytx::extract_holding_statistics_UI("extract_holding_statistics"),
                                  
                                  psychlytx::combine_all_holding_data_UI("combine_all_holding_data"),
                                  
                                  psychlytx::write_statistics_to_holding_UI("write_holding_statistics_to_db"),
                                  
                                  psychlytx::isi_scale_UI("isi_scale"), #Item of the specific measure
                                  
                                  psychlytx::manual_data_UI("manual_data"), #Items of the specific measure are passed here as a string of numbers
                                  
                                  psychlytx::format_isi_responses_for_email_UI("format_responses_for_email"),
                                  
                                  psychlytx::calculate_subscale_UI("calculate_subscales"), #Calculate all aggregate subscale scores for the measure
                                  
                                  psychlytx::collect_input_UI("collect_input_1"), #Collect all input for a subscale
                                  
                                  psychlytx::combine_all_input_UI("combine_all_input"), #Combine collected inputs from all subscales
                                  
                                  psychlytx::write_measure_data_to_db_UI("write_measure_data")
                         ),
                         
                         tabPanel(tags$strong("Client Settings"), value = "go_custom_settings",
                                  
                                  fluidPage(
                                    
                                    psychlytx::show_client_name_UI("show_client_name_settings_tab"),
                                    
                                    psychlytx::show_population_message_UI("show_population_message"),
                                    
                                    
                                    fluidRow(
                                      
                                      tabsetPanel(type = "pills",
                                                  
                                                  tabPanel("Reliable Change Method", width = 12,
                                                           
                                                           psychlytx::method_widget_UI("method_widget") #Reliable change method widget for one subscale
                                                  ),
                                                  
                                                  tabPanel("Mean", width = 12, 
                                                           
                                                           psychlytx::generate_mean_widget_UI("mean_widget_1") #Mean widget for one subscale
                                                  ),
                                                  
                                                  tabPanel("Sd", width = 12,
                                                           
                                                           psychlytx::generate_sd_widget_UI("sd_widget_1") #Sd widget for one subscale
                                                  ),
                                                  
                                                  tabPanel("Test-Retest Reliability", width = 12,
                                                           
                                                           psychlytx::generate_reliability_widget_UI("reliability_widget_1"), #Reliability widget for one subscale
                                                           
                                                           psychlytx::reliability_calc_UI("reliability_derivation") #Derive reliability from stats (if required)
                                                           
                                                  ),
                                                  
                                                  tabPanel("Confidence Level", width = 12,
                                                           
                                                           psychlytx::confidence_level_UI("confidence_widget") #Confidence level widget for one subscale
                                                           
                                                  ),
                                                  
                                                  tabPanel("User-Defined Cut-Off Scores", width = 12,
                                                           
                                                           psychlytx::generate_cutoff_widget_UI("cutoff_widget_1") #Cutoff widgets for one subscale
                                                           
                                                  )
                                                  
                                                  
                                                  
                                      ),
                                      
                                      verbatimTextOutput("reference_sample")
                                      
                                      
                                    ))),
                         
                         useShinyjs(),
                         
                         tabPanel(tags$strong("Download Clinical Report", id = "trigger_most_recent_data"), 
                                  
                                  psychlytx::show_client_name_UI("show_client_name_report_tab"),
                                  
                                  psychlytx::download_report_UI("download_report") #Report download
                                  
                         )
                         
                  ),
                  
                  psychlytx::make_footer_UI("footer"))
                
        )
        
        
        
        
      )))
  
}






server <- function(input, output, session) {
  
  
  observe_helpers()#Needed for use of the shinyhelpers package
  
  start_button_input<- callModule(psychlytx::make_landing, "make_landing")
  
  callModule(psychlytx::make_sidebar, "sidebar", start_button_input) #Make sidebar
  
  callModule(psychlytx::make_header, "header") #Make header
  
  callModule(psychlytx::make_footer, "footer") #Make footer
  
  
  #Register a new client with pretherapy analytics data. Module 
  #creates unique client id. Need clinician id needs to be available 
  #to module so pass it in.
  
  analytics_pretherapy<- callModule(psychlytx::analytics_pretherapy, "analytics_pretherapy", clinician_id) #Return the pretherapy analytics responses
  
  
  callModule(psychlytx::write_pretherapy_to_db, "write_pretherapy_to_db", pool, analytics_pretherapy) #Write pre-therapy analytics responses data to db
  
  
  callModule(psychlytx::reliability_calc, "reliability_derivation")  #If selected, derive reliability value from statistics
  
  
  selected_client<- callModule(psychlytx::render_client_dropdown, "client_dropdown", pool, clinician_id) #Create client selection dropdown & return selection
  
  
  input_retrieve_client_data<- reactive({input$retrieve_client_data}) #Store the value of the client selection button
  
  client_name_for_display<- callModule(psychlytx::retrieve_client_name, "retrive_client_name", pool, input_retrieve_client_data, selected_client)
  
  callModule(psychlytx::show_client_name, "show_client_name_measure_tab", client_name_for_display, input_retrieve_client_data)
  callModule(psychlytx::show_client_name, "show_client_name_settings_tab", client_name_for_display, input_retrieve_client_data)
  callModule(psychlytx::show_client_name, "show_client_name_report_tab", client_name_for_display, input_retrieve_client_data)
  
  
  
  existing_data<- callModule(psychlytx::display_client_data, "display_client_data", pool, selected_client, measure = subscale_info_1$measure,
                             input_retrieve_client_data, client_name_for_display) #Return the selected client's previous scores on this measure
  
  
  observeEvent(input_retrieve_client_data(), {
    
    if(nrow(existing_data()) >= 1) {
      
      hideTab(inputId = "tabset", target = "go_custom_settings")
      
    } else {
      
      showTab(inputId = "tabset", target = "go_custom_settings")
    }
    
  })
  
  
  input_population<- do.call(callModule, c(psychlytx::apply_initial_population, "apply_population", 
                                           subscale_info_1, existing_data, pool, selected_client, clinician_id)) #Store the selected population for downstream use in other modules
  #Posttherapy questions & processing have been relocated to apply_initial_population module
  #analytics_posttherapy and write_posttherapy_to_db modules are now redundant
  #Need to pass pool, selected_client, and clinician_id to allow this to occur
  
  
  callModule(psychlytx::show_population_message, "show_population_message", input_population) #Prompt user to select a population to generate settings for this client
  
  shinyjs::useShinyjs(debug = TRUE) #Allows resetting of scale items on client change
  scale_entry<- callModule(psychlytx::isi_scale, "isi_scale", selected_client) #Return the raw responses to the online scale
  #Pass in selected_client to allow resetting
  
  manual_entry<- callModule(psychlytx::manual_data, "manual_data", scale_entry, expected_responses = 7) #Raw item responses are stored as vector manual_entry to be used downstream
  
  
  aggregate_scores<- callModule(psychlytx::calculate_subscale, "calculate_subscales",  manual_entry = manual_entry, item_index = list( subscale_info_1$items ), 
                                aggregation_method = "sum")   #Make a list of aggregate scores across subscales (in this case there is only one subscale)
  
  
  confidence<- callModule(psychlytx::confidence_level, "confidence_widget", existing_data)  #Return confidence level for intervals. Existing data passed in order to 
  #access & pull in the client's settings from db & prepopulate settings
  #widgets with these settings. Do same things for method, mean, sd, 
  #reliability and cutoffs
  
  
  method<- callModule(psychlytx::method_widget, "method_widget", existing_data) #Return reliable change method (a string)
  
  
  #_________________________________________________________________________________________________
  
  #For each subscale individually, collect the values from widgets and store them in a list 
  
  mean_input_1<- do.call(callModule, c(psychlytx::generate_mean_widget, "mean_widget_1", input_population, subscale_info_1, existing_data))
  sd_input_1<- do.call(callModule, c(psychlytx::generate_sd_widget, "sd_widget_1", input_population, subscale_info_1, existing_data))
  reliability_input_1<- do.call(callModule, c(psychlytx::generate_reliability_widget, "reliability_widget_1", input_population, subscale_info_1, existing_data))
  cutoff_input_1<- do.call(callModule, c(psychlytx::generate_cutoff_widget, "cutoff_widget_1", input_population, subscale_info_1, existing_data))
  
  #Create list of input values for a subscale 
  
  input_list_1<- callModule(psychlytx::collect_input, "collect_input_1", clinician_id, client_id = selected_client, measure = subscale_info_1$measure, 
                            subscale = subscale_info_1$subscale, manual_entry, aggregate_scores, mean_input_1, sd_input_1, reliability_input_1, confidence, 
                            method, input_population, cutoff_input_1, subscale_number = 1)
  
  
  #_______________________________________________________________________________Currently, the code in between hashes must be written for each subscale 
  
  
  
  #Have to store the list of sublists as a reactive object
  
  
  input_list<- reactive({ list( input_list_1() ) })  #Store each list of input values in a larger list object. If there were more than one 
  #subscale it would look like this: input_list<- reactive({ list( input_list_1(), input_list_2(), etc. ) })
  #After creating the list of lists, flatten each sublist and set the names of sublist elements so that they 
  #are the same across lists - this will ensure we can iterate over the lists using purrr. 
  #So pass the input_list object to the combine_all_input module.
  
  
  measure_data<- callModule(psychlytx::combine_all_input, "combine_all_input", input_list)  #Generate a dataframe with all necessary scale data (date, score, pts, se,
  #ci etc.). This dataframe will be sent to the db
  
  
  #Use the appropriate response formatting module (one for each measure). Returns a string representing the email body text to be sent.
  formatted_response_body_for_email<- callModule(psychlytx::format_isi_responses_for_email, "format_responses_for_email", pool, clinician_email, manual_entry, measure_data)
  
  
  callModule(psychlytx::write_measure_data_to_db, "write_measure_data", pool, measure_data, manual_entry, formatted_response_body_for_email)  #Write newly entered item responses from measure to db
  
  
  
  holding_statistics_list_1<- callModule(psychlytx::extract_holding_statistics, "extract_holding_statistics", clinician_id, client_id = selected_client, 
                                         measure = subscale_info_1$measure, subscale = subscale_info_1$subscale, mean_input_1, sd_input_1, reliability_input_1,
                                         confidence, method, input_population, cutoff_input_1, subscale_number = 1)
  
  holding_statistics_list<- reactive({ list( holding_statistics_list_1() ) })
  
  holding_data<- callModule(psychlytx::combine_all_holding_data, "combine_all_holding_data", holding_statistics_list)
  
  
  callModule(psychlytx::write_statistics_to_holding, "write_holding_statistics_to_db", pool, holding_data)
  
  
  most_recent_client_data<- reactiveValues()
  
  onclick("trigger_most_recent_data",  #Query database when user clicks report tab to make sure that the most recent data is pulled in before report generation
          
          observe({ 
            
            most_recent_client_sql<- "SELECT *
          FROM scale
          WHERE client_id = ?client_id;"
            
            most_recent_client_query<- sqlInterpolate(pool, most_recent_client_sql, client_id = selected_client())
            
            most_recent_client_data$value<- dbGetQuery(pool, most_recent_client_query)
            
          })
          
  )
  
  
  
  #Pull selected client's data from db, create a nested df containing all necessary info for report (plots and tables) and send to R Markdown doc.
  
  callModule( psychlytx::download_report, "download_report", pool, selected_client, global_subscale_info, most_recent_client_data )
  
  
}



shinyApp(ui, server)
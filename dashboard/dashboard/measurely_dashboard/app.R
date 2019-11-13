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
library(stringr)
library(ggrepel)
library(DT)
library(eeptools)
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
library(plotly)
library(skimr)


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



clinician_email<- "timothydeitz@gmail.com"  #Sys.getenv("SHINYPROXY_USERNAME")  ##This is how we will access the clinician username (i.e. email) to pass to the modules

#url<- "https://scala.au.auth0.com/userinfo"

#clinician_object<- httr::GET( url, httr::add_headers(Authorization = paste("Bearer", Sys.getenv("SHINYPROXY_OIDC_ACCESS_TOKEN")),
#`Content-Type` = "application/json"))

#clinician_object<- httr::content(clinician_object)

clinician_id<- "auth0|5c99f47197d7ec57ff84527e" #paste(clinician_object["sub"]) #Access the id object

#Prepare data used in dashboard
#Import the client table
#Convert birth dates to ages (numerical variable), then cut it into discrete categories

client<- tbl(pool, "client") %>% dplyr::collect() %>% as.data.frame() %>%
  dplyr::mutate(creation_date = as.Date(creation_date))

client$age<- measurelydashboard::age_cat(eeptools::age_calc(client$birth_date, units = 'years'), upper = 70)

#Import the measure table
#Extract minimum and maximum date to use in dateRangeInput
#Make the date filter

measure<- tbl(pool, "scale") %>% dplyr::collect() %>% as.data.frame() %>%
  dplyr::mutate(date = as.Date(date))

dates<- c(as.Date(min(measure$date)),
          as.Date(max(measure$date)))

#Import the posttherapy_analytics table

posttherapy_analytics<- tbl(pool, "posttherapy_analytics") %>%
  dplyr::collect() %>% as.data.frame() %>% dplyr::mutate(creation_date = as.Date(creation_date))


  header<- dashboardHeader(title ="Measurely | Clinical Outcomes Dashboard", titleWidth = 800)

  sidebar<- dashboardSidebar()

  body<- dashboardBody(
    useShinyjs(),

    tags$head(

      tags$link(rel = "stylesheet", type = "text/css", href = "Styling.css") #Link to the css style sheet,

    ),

    fluidPage(

    fluidRow(
      uiOutput("date_dropdown")
      ),

    measurelydashboard::make_nested_data_UI("make_nested_data"),

   measurelydashboard::make_outcome_valueboxes_UI("make_outcome_valueboxes"),

   measurelydashboard::plot_demographics_UI("plot_demographics"),

   measurelydashboard::plot_diagnoses_UI("plot_diagnoses"),

   measurelydashboard::plot_clinical_outcomes_UI("plot_clinical_outcomes"),

   measurelydashboard::make_posttherapy_valueboxes_UI("make_posttherapy_valueboxes"),

   measurelydashboard::plot_posttherapy_outcomes_UI("plot_posttherapy_outcomes"),

   measurelydashboard::plot_cases_by_measure_UI("plot_cases_by_measure")


  ))


ui <- dashboardPage(header = header,
                    sidebar = sidebar,
                    body = body
)

server <- shinyServer(function(input, output, session) {

  addClass(selector = "body", class = "sidebar-collapse")

  output$date_dropdown<- renderUI({
    dateRangeInput("date_selection", "Select Date Range", start = dates[1], end = dates[2], format = "yyyy-mm-dd")
  })



  #Make reactive expressions from the imported tables (we need these to be updateable if the date filter changes)

  measure_table<- reactive({
    measure %>% dplyr::filter(date >= req(input$date_selection[1]) & date <= req(input$date_selection[2]))
  })

  client_table<- reactive({
    client %>% dplyr::filter(creation_date >= req(input$date_selection[1]) & creation_date <= req(input$date_selection[2]))
  })

  posttherapy_analytics_table<- reactive({
    posttherapy_analytics %>%  dplyr::filter(creation_date >= req(input$date_selection[1]) & creation_date <= req(input$date_selection[2]))
  })


  #Join the three imported tables and make reactive expression

  joined_data<- reactive({

    measure_table() %>%
      dplyr::inner_join(client_table(), by = c("client_id" = "id")) %>%
      dplyr::left_join(posttherapy_analytics_table(), by = "client_id") %>% filter(clinician_id == clinician_id) %>%
      dplyr::select(clinician_id, client_id, first_name, last_name, birth_date, age, sex, postcode, marital_status, sexuality,
                    ethnicity, indigenous, children, workforce_status, education, entry_id, measure, subscale, date,
                    score, pts, se, ci, ci_upper, ci_lower, contains("cutoff_value"), contains("cutoff_label"),
                    principal_diagnosis, secondary_diagnosis, attendance_schedule, cancellations, non_attendances,
                    attendances, premature_dropout, therapy, funding, private_health_fund, referrer, out_of_pocket)
  })


  nested_data<- callModule(measurelydashboard::make_nested_data, "make_nested_data", joined_data)

  callModule(measurelydashboard::make_outcome_valueboxes, "make_outcome_valueboxes", nested_data, joined_data)

  callModule(measurelydashboard::plot_demographics, "plot_demographics", client, client_table, joined_data, nested_data)

  callModule(measurelydashboard::plot_diagnoses, "plot_diagnoses", posttherapy_analytics_table)

  callModule(measurelydashboard::plot_clinical_outcomes, "plot_clinical_outcomes", nested_data)

  callModule(measurelydashboard::plot_cases_by_measure, "plot_cases_by_measure", nested_data)

  callModule(measurelydashboard::make_posttherapy_valueboxes, "make_posttherapy_valueboxes", posttherapy_analytics_table)

  callModule(measurelydashboard::plot_posttherapy_outcomes, "plot_posttherapy_outcomes", posttherapy_analytics,
             posttherapy_analytics_table, joined_data, nested_data)


})


shinyApp(ui = ui, server = server)

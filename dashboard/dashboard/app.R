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
library(grDevices)



pool <- dbPool( #Set up the connection with the db
  drv = dbDriver("PostgreSQL"),
  dbname = "postgres",
  host = "measurely.cglmjkxzmdng.ap-southeast-2.rds.amazonaws.com",
  user = "timothydeitz",
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


  header<- dashboardHeader(title ="Measurely | Clinical Outcomes Dashboard", titleWidth = 800)

  sidebar<- dashboardSidebar(

    sidebarMenu(id = "tabs",

    menuItem(h4(""), tabName = "Landing"),
    br(),
    menuItem(h4("Home"),  tabName = "Home")
    )

  )

  body<- dashboardBody(

    useShinyjs(),

    tags$head(

      tags$link(rel = "stylesheet", type = "text/css", href = "Styling.css") #Link to the css style sheet,

    ),

    fluidPage(

    tabItems(

      tabItem(tabName = "Landing",

              psychlytx::make_landing_UI("make_landing")

      ),


      tabItem(tabName = "Home",


    fluidPage(


   measurelydashboard::make_nested_data_UI("make_nested_data"),

   measurelydashboard::make_outcome_valueboxes_UI("make_outcome_valueboxes"),

   fluidRow(

      uiOutput("date_dropdown")

     ),


   fluidRow(

            measurelydashboard::make_registration_plot_UI("make_registration_plot")

    ),

   br(),
   br(),


   measurelydashboard::plot_demographics_UI("plot_demographics"),

   measurelydashboard::plot_diagnoses_UI("plot_diagnoses"),

   measurelydashboard::plot_clinical_outcomes_UI("plot_clinical_outcomes"),

   measurelydashboard::make_posttherapy_valueboxes_UI("make_posttherapy_valueboxes"),

   measurelydashboard::plot_posttherapy_outcomes_UI("plot_posttherapy_outcomes"),

   measurelydashboard::plot_outcomes_by_measure_UI("plot_outcomes_by_measure")


  )))))


ui <- dashboardPage(header = header,
                    sidebar = sidebar,
                    body = body
)

server <- shinyServer(function(input, output, session) {




  start_button_input<- callModule(psychlytx::make_landing, "make_landing")

  observeEvent(start_button_input(), {

    newtab <- switch(input$tabs, "Landing" = "Home")
    updateTabItems(session, "tabs", newtab)
  })

  addClass(selector = "body", class = "sidebar-collapse")



  output$date_dropdown<- renderUI({
    dateRangeInput("date_selection", h3("Select A Date Range For Analyses", class = "dropdown_headings"), start = Sys.Date() - lubridate::years(1), Sys.Date(), format = "dd-mm-yyyy", width = '50%')
  })



 measure_table<- reactive({
         date_filter_sql<- "SELECT *
          FROM scale
          WHERE creation_date >= ?creation_date_1
          AND creation_date <= ?creation_date_2;"

 date_filter_query<- sqlInterpolate(pool, date_filter_sql, creation_date_1 = stringr::str_trim(as.POSIXct(req(input$date_selection[1]), tz = "GMT")), creation_date_2 =  stringr::str_trim(as.POSIXct(req(input$date_selection[2]), tz = "GMT")))

 measure<- dbGetQuery(pool, date_filter_query)

 tibble::as_tibble(measure)

 })



 client_table<- reactive({ date_filter_sql<- "SELECT *
          FROM client
          WHERE creation_date >= ?creation_date_1
          AND creation_date <= ?creation_date_2;"

 date_filter_query<- sqlInterpolate(pool, date_filter_sql, creation_date_1 = stringr::str_trim(as.POSIXct(req(input$date_selection[1]), tz = "GMT")), creation_date_2 =  stringr::str_trim(as.POSIXct(req(input$date_selection[2]), tz = "GMT")))

 client<- dbGetQuery(pool, date_filter_query)

 client$age<- measurelydashboard::age_cat(eeptools::age_calc(req(client$birth_date), Sys.Date(), units = 'years'), upper = 70)

 tibble::as_tibble(client)

 })



 posttherapy_analytics_table<- reactive({ date_filter_sql<- "SELECT *
          FROM posttherapy_analytics
          WHERE creation_date >= ?creation_date_1
          AND creation_date <= ?creation_date_2;"

 date_filter_query<- sqlInterpolate(pool, date_filter_sql, creation_date_1 = stringr::str_trim(as.POSIXct(req(input$date_selection[1]), tz = "GMT")), creation_date_2 = stringr::str_trim(as.POSIXct(req(input$date_selection[2]), tz = "GMT")))

 posttherapy_analytics<- dbGetQuery(pool, date_filter_query)

 tibble::as_tibble(posttherapy_analytics)

 })


  #Join the three imported tables and make reactive expression

  joined_data<- reactive({

    initial_join<- measure_table() %>%
      dplyr::inner_join(client_table(), by = c("client_id" = "id"))

  })



  callModule(measurelydashboard::make_registration_plot, "make_registration_plot", client_table)


  nested_data<- callModule(measurelydashboard::make_nested_data, "make_nested_data", joined_data)

  callModule(measurelydashboard::make_outcome_valueboxes, "make_outcome_valueboxes", nested_data)

  callModule(measurelydashboard::plot_demographics, "plot_demographics", client_table, nested_data)

  callModule(measurelydashboard::plot_diagnoses, "plot_diagnoses", posttherapy_analytics_table)

  callModule(measurelydashboard::plot_clinical_outcomes, "plot_clinical_outcomes", nested_data)

  callModule(measurelydashboard::plot_outcomes_by_measure, "plot_outcomes_by_measure", nested_data)

  callModule(measurelydashboard::make_posttherapy_valueboxes, "make_posttherapy_valueboxes", posttherapy_analytics_table)

  callModule(measurelydashboard::plot_posttherapy_outcomes, "plot_posttherapy_outcomes",
             posttherapy_analytics_table, nested_data)


})


shinyApp(ui = ui, server = server)

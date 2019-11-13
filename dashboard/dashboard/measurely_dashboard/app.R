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

   measurelydashboard::make_outcome_valueboxes_UI("make_outcome_valueboxes"),

   measurelydashboard::plot_demographics_UI("plot_demographics"),

   measurelydashboard::plot_diagnoses_UI("plot_diagnoses"),

   measurelydashboard::plot_clinical_outcomes_UI("plot_clinical_outcomes"),

    fluidRow(
      valueBoxOutput("attendances"),
      valueBoxOutput("cancellations"),
      valueBoxOutput("dnas")
    ),

    fluidRow(

      uiOutput("posttherapy_dropdown")

    ),

    fluidRow(
      box(collapsible = TRUE, title = "Attendance Characteristics", status = "primary", solidHeader = TRUE, width = 7,
          plotly::plotlyOutput("posttherapy_plot")
      ),
      box(collapsible = TRUE, title = "Clinical Outcomes By Attendance Characteristics", status = "primary", solidHeader = TRUE, width = 5,
          plotly::plotlyOutput("summary_outcomes_plot_by_posttherapy")
      )),

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
    measure %>% dplyr::filter(date >= input$date_selection[1] & date <= input$date_selection[2])
  })


  client_table<- reactive({
    client %>% dplyr::filter(creation_date >= input$date_selection[1] & creation_date <= input$date_selection[2])
  })


  posttherapy_analytics_table<- reactive({
    posttherapy_analytics %>%  dplyr::filter(creation_date >= input$date_selection[1] & creation_date <= input$date_selection[2])
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


  #Nest the joined data - required for analysis of outcomes by measure and client

  #Create a list column with scores on a specific subscale for each client

  nested_data<- reactive({

    nested<- joined_data() %>% dplyr::group_by(client_id, first_name, last_name, birth_date, measure, subscale) %>% tidyr::nest()

    #Arrange the date column within each nested dataframe, from earliest to latest

    nested$data<- purrr::map(nested$data, ~dplyr::arrange(., lubridate::dmy(.x$date)))

    #Within each nested dataframe, canculate key stats across all timepoints for that subscale

    nested<- nested %>% dplyr::mutate(data = purrr::map(data, ~ dplyr::mutate(., improve_all = .x$score < lag( .x$score ),
                                                                              sig_improve_all = .x$score < lag( .x$ci_lower ),
                                                                              remained_same_all = .x$score == lag( .x$score ),
                                                                              deteriorated_all = .x$score > lag( .x$score ),
                                                                              change_all = .x$score - lag(.x$score)
    )))

    #Use the nested dataframes to add new variables of key stats between first and last timepoint for each client per subscale


    nested<- nested %>% dplyr::mutate(change = purrr::map_dbl( data, ~.x$score[1] - .x$score[length(.x$score)] ), #Specify non-sig improvement
                                      improve = purrr::map_lgl( data, ~ .x$score[length(.x$score)] < .x$score[1] & .x$score[length(.x$score)] >= .x$ci_lower[1]  ),
                                      sig_improve = purrr::map_lgl( data, ~.x$score[length(.x$score)] < .x$ci_lower[1] ),
                                      remained_same = purrr::map_lgl( data, ~ (length(.x$score) > 1) & (.x$score[length(.x$score)] == .x$score[1]) ),
                                      deteriorated = purrr::map_lgl(data, ~.x$score[length(.x$score)] > .x$score[1] )
    )

  })



  callModule(measurelydashboard::make_outcome_valueboxes, "make_outcome_valueboxes", nested_data, joined_data)

  callModule(measurelydashboard::plot_demographics, "plot_demographics", client, client_table, joined_data, nested_data)

  callModule(measurelydashboard::plot_diagnoses, "plot_diagnoses", posttherapy_analytics_table)

  callModule(measurelydashboard::plot_clinical_outcomes, "plot_clinical_outcomes", nested_data)

  callModule(measurelydashboard::plot_cases_by_measure, "plot_cases_by_measure", nested_data)


value_box_posttherapy<- reactive({

  posttherapy_analytics_table() %>% dplyr::summarise(

    avg_attendances<- round(mean(attendances, na.rm = TRUE), 1),

    avg_cancellations<- round(mean(cancellations, na.rm = TRUE), 1),

    avg_dnas<- round(mean(non_attendances, na.rm = TRUE), 1)

  )


})


output$attendances <- renderValueBox({
  valueBox(
    value = paste0(req(value_box_posttherapy()) %>% dplyr::pull(1)),
    subtitle = "Average Sessions Per Client"
  )
})

output$cancellations <- renderValueBox({
  valueBox(
    value = paste0(req(value_box_posttherapy()) %>% dplyr::pull(2)),
    subtitle = "Average Cancellations Per Client"
  )
})

output$dnas <- renderValueBox({
  valueBox(
    value = paste0(req(value_box_posttherapy()) %>% dplyr::pull(3)),
    subtitle = "Average DNAs Per Client"
  )

})


output$posttherapy_dropdown<- renderUI({

  #Make named list to pass to dropdown, to avoid underscores between words

  posttherapy_vars<- names(req(joined_data()[, 38:49])) %>%
    purrr::set_names(stringr::str_replace_all(names(joined_data()[, 38:49]), "_", " "))

  selectInput("posttherapy_variable", "Select Therapy Outcome",
              choices = posttherapy_vars)
})


current_category_posttherapy<- reactiveVal()

output$posttherapy_plot <- plotly::renderPlotly({

  posttherapy<- tibble::tibble(req(posttherapy_analytics_table()[, req(input$posttherapy_variable)])) %>%
    dplyr::count(.[[1]]) %>% purrr::set_names(c("labels", "values")) %>% dplyr::mutate_if(is.factor, as.character)

  posttherapy$labels[posttherapy$labels == "" | is.na(posttherapy$labels)]<- "Missing"


  plot_ly(posttherapy) %>%
    add_pie(
      labels = ~labels,
      values = ~values,
      hole = 0.6,
      customdata = ~labels
    ) %>%
    layout(legend = list(orientation = 'h'))

})



observe({

  cd <- event_data("plotly_click")$customdata[[1]]

  if (isTRUE(cd %in% posttherapy_analytics[,paste(input$posttherapy_variable)])) current_category_posttherapy(cd)

})


outcomes_by_posttherapy<- reactive({

  if(length(current_category_posttherapy())) {

    outcomes_df<- posttherapy_analytics_table() %>% dplyr::inner_join(nested_data(), by = c("client_id" = "client_id"))

    outcomes_df<- outcomes_df[, c(input$posttherapy_variable, "improve", "sig_improve", "remained_same", "deteriorated")]

    names(outcomes_df)<- c("selected", "Improved", "Reliably Improved", "No Change", "Deteriorated")

    outcomes_df<- outcomes_df %>% dplyr::filter(selected %in% current_category_posttherapy())

    outcomes_df_gathered<- outcomes_df %>% tidyr::gather("outcome", "status", -selected) %>% dplyr::filter(status == TRUE)

    outcomes_summary<- forcats::fct_count(outcomes_df_gathered$outcome, sort = TRUE, prop = TRUE) %>% dplyr::mutate(p = p * 100) %>%
      dplyr::select(Variable = f, Count = n, Percent = p)

  }

})


output$summary_outcomes_plot_by_posttherapy<- renderPlotly({


  p<- ggplot(req(outcomes_by_posttherapy()), aes(x = paste(current_category_posttherapy()[1]),
                                                 y = Percent,
                                                 fill = forcats::fct_reorder(Variable, Percent),
                                                 text = paste(Variable, "<br>","Count: ", Count))) +
    geom_col() + geom_text(aes(label = paste0(round(Percent, 1), "%")), size = 3,
                           position = position_stack(vjust = 0.5)) +
    theme(legend.title = element_blank(), legend.justification=c(0,0), legend.position=c(0,0), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line = element_blank()) + xlab("")


  plotly::ggplotly(p, tooltip = "text")

})


})


shinyApp(ui = ui, server = server)

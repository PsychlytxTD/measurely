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

    fluidRow(
      box(width = 12, collapsible = TRUE, title = "Client Diagnoses", status = "primary", solidHeader = TRUE,
          plotly::plotlyOutput("diagnosis_plot")
          )
    ),

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

    plotly::plotlyOutput("plot_all_cases_by_measure", height = "2000px")


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

  callModule(measurelydashboard::plot_clinical_outcomes, "plot_clinical_outcomes", nested_data)


  #Create plot of diagnoses

  output$diagnosis_plot<- plotly::renderPlotly({

    df_dsm<- req(posttherapy_analytics_table()) %>% count(principal_diagnosis, secondary_diagnosis) %>% select(principal_diagnosis, secondary_diagnosis, number = n)

    df_dsm<- df_dsm %>% mutate('relative'=unlist(by(data = number, INDICES = principal_diagnosis,
                                                    FUN = function(x) round(x/sum(x)*100, digits = 1))))

    df_dsm<- df_dsm %>% group_by(principal_diagnosis) %>% mutate(diagnosis_count = sum(number))

    df_dsm<- df_dsm %>% mutate_if(is.factor, as.character)

    df_dsm$principal_diagnosis[df_dsm$principal_diagnosis == "" | is.na(df_dsm$principal_diagnosis)]<- "Missing"

    df_dsm$secondary_diagnosis[df_dsm$secondary_diagnosis == "" | is.na(df_dsm$secondary_diagnosis)]<- "Missing"


    #create the stacked bar plot based on your data
    p<- ggplot(data = df_dsm, aes(y= number, x=principal_diagnosis, fill=secondary_diagnosis,
                                  text = paste("Primary Diagnosis: ", principal_diagnosis, "<br>",
                                               "Number of Cases:", diagnosis_count, "<br>",
                                               "Representents ", round((diagnosis_count/nrow(df_dsm) * 100), 2), "% of all primary diagnoses")

    )) +
      geom_bar(stat="identity", width = 0.5) +
      xlab('Primary Diagnosis') + ylab('Number of Cases') +
      #use JOELS great solution for the label position
      #and add percentage based on variable 'relative', otherwise use 'number'
      geom_text(aes(x = principal_diagnosis, label = paste0(relative,'%')),
                colour = 'white', position=position_stack(vjust=0.5)) +
      labs(fill='Secondary Diagnosis') + coord_flip() +
      theme(panel.grid.minor.y = element_blank(),
            panel.grid.major.y = element_blank(),
            panel.background = element_blank(),
            panel.grid.major.x = element_line("grey")
      )


    ggplotly(p, tooltip = "text")

  })



  all_cases_by_measure<- reactive({

  by_measure_nested<- nested_data() %>% dplyr::mutate(data = purrr::map(data, ~ dplyr::mutate(., timepoint = 1:length(.x$date))))

  by_measure<- tidyr::unnest(by_measure_nested)

  by_measure<- dplyr::mutate(by_measure, timepoint = paste("Time", timepoint))

  by_measure<- by_measure %>% tidyr::unite("Client", first_name, last_name, birth_date, sep = " ")

  by_measure<- by_measure %>% dplyr::group_by(subscale, timepoint) %>% dplyr::mutate(mean_score = round(mean(score, na.rm = TRUE), 2)) %>% dplyr::ungroup()

  by_measure$subscale<- gsub("_", "-", by_measure$subscale)



  by_measure %>%
    group_by(subscale) %>%
    dplyr::do(
      p = highlight_key(., ~Client, group = "Select A Client") %>%
        plot_ly(type = 'scatter', mode = 'lines', showlegend = FALSE) %>%
        add_lines(x = ~timepoint, y = ~ mean_score, text = ~paste("Mean Score:", mean_score),
                  line = list(width = 3, dash = 'dash'),
                  marker =  list(symbol ="diamond-open"),
                  mode = 'lines+markers', hoverinfo = "text") %>%
        group_by(Client) %>%
        add_trace(
          x = ~timepoint, y = ~score, text = ~paste("Client:", Client, "<br>",
                                                   "Assessment Date:", date, "<br>",
                                                   "Score:", score, "<br>",
                                                   "Change Since Previous:", sprintf("%+3.1f", change_all)
                                                   ),
          mode = 'lines+markers', hoverinfo = "text")  %>%
        layout(xaxis = list(tickangle = 45)) %>%
        add_annotations(
          text = ~unique(subscale),
          x = 0.5, y = 1,
          xref = "paper", yref = "paper",
          xanchor = "center", yanchor = "bottom",
          showarrow = FALSE
        )
    ) %>%
    subplot(
      nrows = (NROW(.)/2) + 1,
      shareY = FALSE, shareX = FALSE, titleY = FALSE
    ) %>% highlight(
      dynamic = TRUE,
      selectize = TRUE,
      color = "red"
    )


})


output$plot_all_cases_by_measure<- plotly::renderPlotly({

  req(all_cases_by_measure())

})


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

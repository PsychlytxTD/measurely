#' Plot Posttherapy Outcomes
#'
#' Make plots for posttherapy outcomes and clinical outcomes by posttherapy categories
#'
#' @param id A string to create the namespace
#'
#' @export

plot_posttherapy_outcomes_UI<- function(id) {

  ns<- NS(id)

  tagList(

  fluidRow(
    uiOutput(ns("posttherapy_dropdown"))
  ),

fluidRow(
  box(collapsible = TRUE, title = "Attendance Characteristics", status = "primary", solidHeader = TRUE, width = 7,
      plotly::plotlyOutput(ns("posttherapy_plot"))
  ),
  box(collapsible = TRUE, title = "Clinical Outcomes By Attendance Characteristics", status = "primary", solidHeader = TRUE, width = 5,
      plotly::plotlyOutput(ns("summary_outcomes_plot_by_posttherapy"))
  ))

)

}


#' Plot Posttherapy Outcomes
#'
#' Make plots for posttherapy outcomes and clinical outcomes by posttherapy categories
#'
#' @param posttherapy_analytics_table A reactive df with posttherapy outcome data.
#'
#' @param nested_data A reactive nested dataframe containing subscale scores for each individual.
#'
#'
#'
#' @export

plot_posttherapy_outcomes<- function(input, output, session, posttherapy_analytics_table, nested_data) {


output$posttherapy_dropdown<- renderUI({

  ns <- session$ns

  #Make named list to pass to dropdown, to avoid underscores between words

  posttherapy_names<- c("principal_diagnosis", "secondary_diagnosis", "attendance_schedule", "cancellations", "non_attendances",
                        "attendances", "premature_dropout", "therapy", "funding",
                        "private_health_fund", "referrer", "out_of_pocket")

  posttherapy_vars<-  posttherapy_names %>%
    purrr::set_names(stringr::str_replace_all(posttherapy_names, "_", " "))

  selectInput(ns("posttherapy_variable"), "Select Therapy Outcome",
              choices = posttherapy_vars)
})


current_category<- reactiveVal()

output$posttherapy_plot <- plotly::renderPlotly({

  posttherapy<- tibble::as_tibble(posttherapy_analytics_table()[[req(input$posttherapy_variable)]]) %>%
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

  if (isTRUE(cd %in% posttherapy_analytics_table()[[req(input$posttherapy_variable)]])) current_category(cd)

})


outcomes_by_posttherapy<- reactive({

  if(length(current_category())) {

    outcomes_df<- posttherapy_analytics_table() %>% dplyr::inner_join(nested_data(), by = c("client_id" = "client_id"))

    outcomes_df<- outcomes_df[, c(input$posttherapy_variable, "improve", "sig_improve", "remained_same", "deteriorated")]

    names(outcomes_df)<- c("selected", "Improved", "Reliably Improved", "No Change", "Deteriorated")

    outcomes_df<- outcomes_df %>% dplyr::filter(selected %in% current_category())

    outcomes_df_gathered<- outcomes_df %>% tidyr::gather("outcome", "status", -selected) %>% dplyr::filter(status == TRUE)

    outcomes_summary<- forcats::fct_count(outcomes_df_gathered$outcome, sort = TRUE, prop = TRUE) %>% dplyr::mutate(p = p * 100) %>%
      dplyr::select(Variable = f, Count = n, Percent = p)

  }

})


output$summary_outcomes_plot_by_posttherapy<- renderPlotly({

  validate(need(length(outcomes_by_posttherapy()$Percent) >= 1, "No data to show yet. Click on a category of the left plot."))


  p<- ggplot(req(outcomes_by_posttherapy()), aes(x = current_category()[[1]],
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

}

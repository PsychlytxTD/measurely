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

  h2("Attendance Characteristics", class = "headings"),

  h3("Select An Attendance Outcome", class = "dropdown_headings"),


  fluidRow(
    uiOutput(ns("posttherapy_dropdown"))
  ),

fluidRow(
      column(width = 7,
      plotly::plotlyOutput(ns("posttherapy_plot"))
      ),

      column(width = 5,
      plotly::plotlyOutput(ns("summary_outcomes_plot_by_posttherapy"))
      )
  ),

br(),
br()

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

  selectizeInput(inputId = ns("posttherapy_variable"),
                 "",
                choices = posttherapy_vars,
                options = list(
                  placeholder = 'Start typing or scroll down..',
                  onInitialize = I('function() { this.setValue(""); }')
                ))
})


current_category<- reactiveVal()

output$posttherapy_plot <- plotly::renderPlotly({

  validate(need(nrow(posttherapy_analytics_table()) >= 1, "No results to show yet"))

  posttherapy<- tibble::as_tibble(posttherapy_analytics_table()[[req(input$posttherapy_variable)]]) %>%
    dplyr::count(.[[1]]) %>% purrr::set_names(c("labels", "values")) %>% dplyr::mutate_if(is.factor, as.character)

  posttherapy$labels[posttherapy$labels == "" | is.na(posttherapy$labels)]<- "Missing"


  plot_ly(posttherapy, hoverinfo = "text") %>%
    add_pie(
      labels = ~labels,
      values = ~values,
      hovertext= ~paste0(stringr::str_to_title(stringr::str_replace_all(input$posttherapy_variable, "_", " ")), ": ", labels, "<br>",
                         "Number of Clients: ", values, "<br>",
                         "Percentage of Clients: ", (values/nrow(posttherapy_analytics_table())) * 100, "%"),
      hole = 0.6,
      customdata = ~labels,
      marker = list(colors=rev(dutchmasters::dutchmasters$milkmaid))
    ) %>%
    layout(legend = list(orientation = 'h')) %>% layout(plot_bgcolor='#e5e5e5') %>%
    layout(paper_bgcolor='#e5e5e5')

})



observe({

  cd <- event_data("plotly_click")$customdata[[1]]

  if (isTRUE(cd %in% posttherapy_analytics_table()[[req(input$posttherapy_variable)]])) current_category(cd)

})


outcomes_by_posttherapy<- reactive({

  if(length(current_category())) {

    #Joine client demographics info to the nested scale outcome data.

    outcomes_df<- posttherapy_analytics_table() %>% dplyr::left_join(nested_data(), by = c("client_id" = "client_id"))

    outcomes_df<- outcomes_df[, c("id", req(input$posttherapy_variable), "improve", "sig_improve", "remained_same", "deteriorated")]

    names(outcomes_df)[1:2]<- c("client_id", "selected")

    outcomes_df<- outcomes_df %>% dplyr::filter(selected %in% current_category())

    unique_clients<- dplyr::n_distinct(outcomes_df$client_id) #Get the number of unique clients.

    nested_outcomes_by_id<- outcomes_df %>% dplyr::group_by(client_id) %>% tidyr::nest()


    #Determine how many clients showed at least one improvement/sig_improvement etc.
    improved<- sum(nested_outcomes_by_id$data %>% purrr::map_lgl(~any(.x$improve) == TRUE), na.rm = TRUE)
    improved_percent<- round(improved / unique_clients * 100, 1)
    sig_improved<- sum(nested_outcomes_by_id$data %>% purrr::map_lgl(~any(.x$sig_improve) == TRUE), na.rm = TRUE)
    sig_improved_percent<- round(sig_improved /  unique_clients * 100, 1)
    remained_same<- sum(nested_outcomes_by_id$data %>% purrr::map_lgl(~any(.x$remained_same) == TRUE), na.rm = TRUE)
    remained_same_percent<- round(remained_same /  unique_clients * 100, 1)
    deteriorated<- sum(nested_outcomes_by_id$data %>% purrr::map_lgl(~any(.x$deteriorated) == TRUE), na.rm = TRUE)
    deteriorated_percent<- round(deteriorated /  unique_clients * 100, 1)

    outcomes<- tibble::tibble(improved, improved_percent, sig_improved, sig_improved_percent,
                              remained_same, remained_same_percent, deteriorated, deteriorated_percent)


    #First generate df with the outcome types as key and counts
    count<- dplyr::select(outcomes, -contains("percent")) %>% tidyr::gather()

    #Get percentages
    percent<- dplyr::select(outcomes, contains("percent")) %>% tidyr::gather() %>% dplyr::select(Percent = value)

    #Join counts with pecentages (i.e. % of clients that showed each type of outcome).
    outcomes_summary<- dplyr::bind_cols(count, percent) %>% dplyr::select(Variable = key, Count = value, Percent)

    #Recode outcome types
    outcomes_summary$Variable<- dplyr::recode(outcomes_summary$Variable,
                                              "improved" = "Improved",
                                              "sig_improved" = "Reliably Improved",
                                              "remained_same" = "No Change",
                                              "deteriorated" = "Deteriorated"
    )


    outcomes_summary<- dplyr::filter(outcomes_summary, Count != 0)

    return(outcomes_summary)


  }

})


output$summary_outcomes_plot_by_posttherapy<- renderPlotly({

  validate(need(nrow(outcomes_by_posttherapy()) >= 1, "No data to show yet. Click on a category of the left plot."))

  p<- ggplot(outcomes_by_posttherapy(), aes(x = forcats::fct_reorder(Variable, Count),#current_category()[[1]],
                                            y = Count,
                                            fill = Variable,#forcats::fct_reorder(Variable, Count),
                                            text = paste0("Number of Clients that ", stringr::str_to_lower(Variable), ": ", Count, "<br>", "Percentage of Clients that ", stringr::str_to_lower(Variable), ": ",  Percent, "%"))) +
    geom_col() + geom_text(aes(label = paste0(round(Percent, 1), "%")), vjust = 4, size = 3) + scale_fill_manual(values = c("Improved" = "#7fff00", "Reliably Improved" = "green", "No Change" = "#d35400", "Deteriorated" = "#cd5c5c")) +
    scale_y_continuous(breaks = scales::breaks_pretty()) + theme(legend.title = element_blank(), legend.justification=c(0,0), legend.position=c(0,0), panel.grid.major = element_blank(),
                                                                 panel.grid.minor = element_blank(),
                                                                 panel.grid.major.y = element_line("grey"),
                                                                 panel.background = element_blank(),
                                                                 axis.line = element_blank(),
                                                                 axis.text.x = element_text(angle = 45, hjust = 1)) + xlab("") + ylab("Number of Client") +
    theme(panel.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
          plot.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
          legend.position = "none") #legend.background = element_rect(fill = '#e5e5e5'))



  plotly::ggplotly(p, tooltip = "text")


})

}

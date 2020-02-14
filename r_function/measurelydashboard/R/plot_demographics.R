#' Plot Demographics
#'
#' Generate pie chart for demographics and stacked bar chart for clinical outcomes by demographic category
#'
#' @param id A string to create the namespace.
#'
#' @export


plot_demographics_UI<- function(id) {

  ns<- NS(id)

  tagList(

  fluidRow(
  h2("Practice Demographics", class = "headings"),
  h3("Select A Demographic Outcome", class = "dropdown_headings")
  ),

  fluidRow(

    uiOutput(ns("demographics_dropdown"))
  ),

  fluidRow(

        column(width = 7,
        plotly::plotlyOutput(ns("demographics_plot"))
        ),


        column(width = 5,
        plotly::plotlyOutput(ns("summary_outcomes_plot_by_demographics"))
        )
    ),

  br(),
  br()

  )


}


#' Plot Demographics
#'
#' Generate pie chart for demographics and stacked bar chart for clinical outcomes by demographic category
#'
#' @param client_table A reactive df representing the data from the client table in the database.
#'
#' @param nested_data A reactive nested dataframe containing subscale scores for each individual.
#'
#' @export


plot_demographics<- function(input, output, session, client_table, nested_data) {

#Generate the dropdown of demographics variables

output$demographics_dropdown<- renderUI({

  ns <- session$ns

  #Make named list to pass to dropdown, to avoid underscores between words

  demographic_var_names<- c("age", "sex", "postcode", "marital_status", "sexuality",
                            "ethnicity", "indigenous", "children", "workforce_status", "education")

  demographic_vars<- demographic_var_names %>%
    purrr::set_names(stringr::str_replace_all(demographic_var_names, "_", " "))

  selectizeInput(inputId = ns("demographic_variable"),
              "",
              choices = demographic_vars,
              options = list(
                placeholder = 'Start typing or scroll down..',
                onInitialize = I('function() { this.setValue(""); }')
              )
              )

})

outputOptions(output, "demographics_dropdown", suspendWhenHidden = FALSE)


#Plot the demographics pie graph

current_category<- reactiveVal()

output$demographics_plot <- plotly::renderPlotly({

  validate(need(nrow(client_table()) >= 1, "No results to show yet"))

  demographics<- tibble::as_tibble(client_table()[[req(input$demographic_variable)]]) %>%
    dplyr::count(.[[1]]) %>% purrr::set_names(c("labels", "values")) %>% dplyr::mutate_if(is.factor, as.character)

  demographics$labels[demographics$labels == "" | is.na(demographics$labels)]<- "Missing"


  plot_ly(demographics, hoverinfo = "text") %>%
    add_pie(
      labels = ~labels,
      values = ~values,
      hovertext= ~paste0(stringr::str_to_title(stringr::str_replace_all(input$demographic_variable, "_", " ")), ": ", labels, "<br>",
                         "Number of Clients: ", values, "<br>",
                         "Percentage of Clients: ", (values/nrow(client_table())) * 100, "%"),
      hole = 0.6,
      customdata = ~labels,
      marker = list(colors=rev(dutchmasters::dutchmasters$milkmaid))
    ) %>% layout(legend = list(orientation = 'h')) %>% layout(plot_bgcolor='#e5e5e5') %>%
    layout(paper_bgcolor='#e5e5e5')

})

#Add variable metadata from click to reactive values object (needed for drill-down)

observe({

  cd <- event_data("plotly_click")$customdata[[1]]

  if (isTRUE(cd %in% client_table()[[req(input$demographic_variable)]])) current_category(cd)

})

#Wrangle the drill-down data ready for plotting

outcomes_by_demographic<- reactive({

  if(length(current_category())) {

    #Joine client demographics info to the nested scale outcome data.

    outcomes_df<- client_table() %>% dplyr::left_join(nested_data(), by = c("id" = "client_id"))

    outcomes_df<- outcomes_df[, c("id", req(input$demographic_variable), "improve", "sig_improve", "remained_same", "deteriorated")]

    names(outcomes_df)[1:2]<- c("client_id", "selected")

    outcomes_df<- outcomes_df %>% dplyr::filter(selected %in% current_category())

    unique_clients<- dplyr::n_distinct(outcomes_df$client_id) #Get the number of unique clients.

    nested_outcomes_by_id<- outcomes_df %>% dplyr::group_by(client_id) %>% tidyr::nest()


    #Determine how many clients showed at least one improvement/sig_improvement etc.
    improved<- sum(nested_outcomes_by_id$data %>% purrr::map_lgl(~any(.x$improve) == TRUE), na.rm = TRUE)
    improved_percent<- round(improved /  unique_clients * 100, 1)
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


#Make the drill-down plot

output$summary_outcomes_plot_by_demographics<- renderPlotly({

  validate(need(nrow(outcomes_by_demographic()) >= 1, "No data to show yet. Click on a category of the left plot."))

  p<- ggplot(outcomes_by_demographic(), aes(x = forcats::fct_reorder(Variable, Count),#current_category()[[1]],
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

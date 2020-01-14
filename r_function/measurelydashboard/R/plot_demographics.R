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


#Plot the demographics pie graph

current_category<- reactiveVal()

output$demographics_plot <- plotly::renderPlotly({

  demographics<- tibble::as_tibble(client_table()[[req(input$demographic_variable)]]) %>%
    dplyr::count(.[[1]]) %>% purrr::set_names(c("labels", "values")) %>% dplyr::mutate_if(is.factor, as.character)

  demographics$labels[demographics$labels == "" | is.na(demographics$labels)]<- "Missing"


  plot_ly(demographics) %>%
    add_pie(
      labels = ~labels,
      values = ~values,
      hole = 0.6,
      customdata = ~labels,
      colors = "BrBG"
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

    outcomes_df<- client_table() %>% dplyr::inner_join(nested_data(), by = c("id" = "client_id"))

    outcomes_df<- outcomes_df[, c(input$demographic_variable, "improve", "sig_improve", "remained_same", "deteriorated")]

    names(outcomes_df)<- c("selected", "Improved", "Reliably Improved", "No Change", "Deteriorated")

    outcomes_df<- outcomes_df %>% dplyr::filter(selected %in% current_category())

    outcomes_df_gathered<- outcomes_df %>% tidyr::gather("outcome", "status", -selected) %>% dplyr::filter(status == TRUE)

    outcomes_summary<- forcats::fct_count(outcomes_df_gathered$outcome, sort = TRUE, prop = TRUE) %>% dplyr::mutate(p = p * 100) %>%
      dplyr::select(Variable = f, Count = n, Percent = p)

  }

})

#Make the drill-down plot

output$summary_outcomes_plot_by_demographics<- renderPlotly({

  validate(need(length(outcomes_by_demographic()$Percent) >= 1, "No data to show yet. Click on a category of the left plot."))


  p<- ggplot(outcomes_by_demographic(), aes(x = current_category()[[1]],
                                                 y = Percent,
                                                 fill = forcats::fct_reorder(Variable, Percent),
                                                 text = paste(Variable, "<br>","Count: ", Count))) +
    geom_col() + geom_text(aes(label = paste0(round(Percent, 1), "%")), size = 3,
                           position = position_stack(vjust = 0.5)) +
    theme(legend.title = element_blank(), legend.justification=c(0,0), legend.position=c(0,0), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line = element_blank()) + xlab("") +
    theme(panel.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
          plot.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
          legend.background = element_rect(fill = '#e5e5e5'))



  plotly::ggplotly(p, tooltip = "text")


})


# populate back button if category is chosen

output$back <- renderUI({

  if (length(current_category())) actionButton("clear", "Clear", icon("chevron-left"))

})


# clear the chosen category on back button press

observeEvent(input$clear, current_category(NULL))

}

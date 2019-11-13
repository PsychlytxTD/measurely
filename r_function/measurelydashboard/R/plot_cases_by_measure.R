#' Plot All Cases By Measure
#'
#' Make spaghetti plots for all cases by outcome measure.
#'
#' @param id A string to create the namespace.
#'
#' @export


plot_cases_by_measure_UI<- function(id) {

  ns<- NS(id)

  plotly::plotlyOutput(ns("plot_all_cases_by_measure"), height = "2000px")

}



#' Plot All Cases By Measure
#'
#' Make spaghetti plots for all cases by outcome measure.
#'
#' @param nested_data A reactive nested dataframe containing subscale scores for each individual.
#'
#' @export


plot_cases_by_measure<- function(input, output, session, nested_data) {


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

}
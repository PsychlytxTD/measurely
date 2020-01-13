#' Plot All Individual Outcomes By Measure
#'
#' Make spaghetti plots for all cases by outcome measure.
#'
#' @param id A string to create the namespace.
#'
#' @export



 plot_outcomes_by_measure_UI<- function(id) {

    ns<- NS(id)

    tagList(

    fluidRow(
     uiOutput(ns("client_dropdown"))
    ),

    fluidRow(
    plotly::plotlyOutput(ns("outcomes_by_measure"))
    )

    )

 }


 #' Plot Outcomes By Measure
 #'
 #' Make spaghetti plots for all cases by outcome measure.
 #'
 #' @param nested_data A reactive nested dataframe containing subscale scores for each individual.
 #'
 #' @export


 plot_outcomes_by_measure<- function(input, output, session, nested_data) {


   unnested_outcomes<- reactive({

     by_measure_nested<- nested_data() %>% dplyr::mutate(data = purrr::map(data, ~ dplyr::mutate(., timepoint = 1:length(.x$date))))

     by_measure<- tidyr::unnest(by_measure_nested)

     by_measure<- dplyr::mutate(by_measure, timepoint = paste("Time", timepoint))

     by_measure<- by_measure %>% tidyr::unite("Client", first_name, last_name, birth_date, sep = " ")

     by_measure$subscale<- gsub("_", "-", by_measure$subscale)

     return(by_measure)

   })


   observe({ print( unnested_outcomes()[["Client"]] )})

   output$client_dropdown<- renderUI({

     req( unnested_outcomes() )

     ns <- session$ns

     client_names<- unique(unnested_outcomes()[["Client"]])

     clients<- client_names %>%
       purrr::set_names(stringr::str_replace_all(client_names, "_", " "))

     selectizeInput(ns("client_selection"), "Select One or More Clients",
                 choices = clients, multiple = TRUE)


   })



   make_outcomes_plot<- reactive({

     plotting_data<- unnested_outcomes() %>% dplyr::filter(Client %in% input$client_selection)

     means_df<- unnested_outcomes() %>% dplyr::group_by(timepoint, subscale) %>% mutate(mean_score = mean(score, na.rm = TRUE)) %>%
       dplyr::select(timepoint, subscale, mean_score) %>% dplyr::distinct()


     validate(need(nrow(plotting_data) >= 1, "Please select a client."))

     p<- ggplot(plotting_data, aes(x = factor(timepoint), y = score, group = client_id,
                                   text = paste("Client:", Client, "<br>",
                                                "Assessment Date:", date, "<br>",
                                                "Score:", score, "<br>",
                                                "Change Since Previous:", sprintf("%+3.1f", change_all)
                                   ))) + geom_point(shape = 1) + geom_line() +
       facet_wrap(~subscale, ncol = 2) + xlab("") + ylab("Score")

     p<- p + geom_line(data = means_df, aes(x = timepoint, y = mean_score, group = 1, text = NULL), color = "red", shape = 0)

     plotly::ggplotly(p, tooltip = "text")

   })


   output$outcomes_by_measure<- renderPlotly({

     make_outcomes_plot()

   })

}

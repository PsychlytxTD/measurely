#' Clinical Outcomes By Measure Plot
#'
#' Make the plot for displaying clinical outcomes by individual measures
#'
#' @param id A string to create the namespace
#'
#' @export

plot_clinical_outcomes_UI<- function(id) {

ns<- NS(id)

tagList(

h2("Symptom Change Summaries For Each Outcome Measure", class = "headings"),

fluidRow(
  radioGroupButtons(ns("outcome_type"), "", choices = c("Improvement", "Statistically Reliable Improvement",
                                                                  "No Change", "Deterioration"), selected = NULL),

  plotly::plotlyOutput(ns("plot_outcomes_by_measure")),

  br(),
  br()

))

}



#' Clinical Outcomes By Measure Plot
#'
#' Make the plot for displaying clinical outcomes by individual measures
#'
#' @param nested_data A reactive nested dataframe containing subscale scores for each individual.
#'
#' @export



plot_clinical_outcomes<- function(input, output, session, nested_data) {

#Wrangle data to generate outcomes by measure (improve, sig_improve, remained_same, deterioration etc.)

outcomes_by_measure<- reactive({

  at_least_two_timepoints_cases<- nested_data() %>% dplyr::filter(at_least_two == TRUE)

  by_measure<- split(at_least_two_timepoints_cases, at_least_two_timepoints_cases$measure)

  n_at_least_two_timepoints<- dplyr::n_distinct(at_least_two_timepoints_cases$measure)


  switch(input$outcome_type,

         "Improvement" = {

           by_measure %>% purrr::map_dfr(~ {

             tibble::tibble(
               count = dplyr::n_distinct(.x[.x$improve == TRUE, "client_id"]),
               percent = round( count / dplyr::n_distinct(.x$client_id) * 100, 1),
               measure = .x$measure[1]


             )


           })

           #count<- sum(by_measure$data %>% purrr::map_lgl(~any(.x$improve) == TRUE), na.rm = TRUE)
           #percent<- round(count /  n_at_least_two_timepoints * 100, 1)

           #measurelydashboard::make_clinical_outcomes_by_measure(nested_data, improve)


         },

         "Statistically Reliable Improvement" = {


           by_measure %>% purrr::map_dfr(~ {

             tibble::tibble(
               count = dplyr::n_distinct(.x[.x$sig_improve == TRUE, "client_id"]),
               percent = round( count / dplyr::n_distinct(.x$client_id) * 100, 1),
               measure = .x$measure[1]

             )


           })


           #measurelydashboard::make_clinical_outcomes_by_measure(nested_data, sig_improve)

         },

         "No Change" = {

           by_measure %>% purrr::map_dfr(~ {

             tibble::tibble(
               count = dplyr::n_distinct(.x[.x$remained_same == TRUE, "client_id"]),
               percent = round( count / dplyr::n_distinct(.x$client_id)  * 100, 1),
               measure = .x$measure[1]

             )


           })

           #measurelydashboard::make_clinical_outcomes_by_measure(nested_data, remained_same)

         },

         "Deterioration" = {

           by_measure %>% purrr::map_dfr(~ {

             tibble::tibble(
               count = dplyr::n_distinct(.x[.x$deteriorated == TRUE, "client_id"]),
               percent = round( count / dplyr::n_distinct(.x$client_id)  * 100, 1),
               measure = .x$measure[1]

             )


           })

           #measurelydashboard::make_clinical_outcomes_by_measure(nested_data, deteriorated)

         }

  )

})


plot_colours<- grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]

#Generate a plot displaying outcomes by measure (allowing comparison of measures)

output$plot_outcomes_by_measure<- plotly::renderPlotly({

  measures_whitespace<- gsub("_", "-", req(outcomes_by_measure()$measure))

  p<- ggplot(outcomes_by_measure(), aes(x= measure, y= percent, color = measure, fill = measure,
                                        text = paste0("Percentage of ", gsub('_', '-', measure),
                                                      " respondents having completed at least two assessments who showed", " ", stringr::str_to_lower(input$outcome_type), ": ", percent, "%"))) +
    geom_col() + scale_fill_manual(values = plot_colours) +
    xlab("Outcome Measure") + ylab(paste("%")) +
    ggtitle(paste("Percentage of", gsub('_', '-', outcomes_by_measure()$measure), "respondents (having completed at least 2 assessments) showing", stringr::str_to_sentence(input$outcome_type))) +
    scale_x_discrete(labels = measures_whitespace) +
    theme(panel.grid.minor.x = element_blank(),
          panel.grid.major.x = element_blank(),
          panel.grid.minor.y = element_blank(),
          panel.grid.major.y = element_line("grey"),
          axis.text.x = element_text(angle=65, vjust=0.6),
          legend.position="none"
    ) + theme(panel.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
          plot.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
          legend.background = element_rect(fill = '#e5e5e5'))



  plotly::ggplotly(p, tooltip = "text")

})

}
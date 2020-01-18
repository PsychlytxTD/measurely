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

  switch(input$outcome_type,

         "Improvement" = {

           measurelydashboard::make_clinical_outcomes_by_measure(nested_data, improve)


         },

         "Statistically Reliable Improvement" = {

           measurelydashboard::make_clinical_outcomes_by_measure(nested_data, sig_improve)

         },

         "No Change" = {

           measurelydashboard::make_clinical_outcomes_by_measure(nested_data, remained_same)

         },

         "Deterioration" = {

           measurelydashboard::make_clinical_outcomes_by_measure(nested_data, deteriorated)

         }

  )

})


plot_colours<- grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]

#Generate a plot displaying outcomes by measure (allowing comparison of measures)

output$plot_outcomes_by_measure<- plotly::renderPlotly({

  measures_whitespace<- gsub("_", "-", req(outcomes_by_measure()$measure))

  p<- ggplot(outcomes_by_measure(), aes(x= measure, y= percent, color = measure, fill = measure,
                                        text = paste0("Percentage of ", gsub('_', '-', measure),
                                                      " respondents having completed at least two assessments who showed", " ", stringr::str_to_lower(input$outcome_type), ": ", percent, "%", "<br>",
                                                      "Average pre-to-post change in ", gsub('_', '-', measure), " scores: ", average_change))) +
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
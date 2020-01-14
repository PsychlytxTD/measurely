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




#Generate a plot displaying outcomes by measure (allowing comparison of measures)

output$plot_outcomes_by_measure<- plotly::renderPlotly({

  measures_whitespace<- gsub("_", "-", req(outcomes_by_measure()$measure))

  p<- ggplot(outcomes_by_measure(), aes(x= measure, y= percent, color = measure, fill = measure,
                                        text = paste0("Percentage of ", gsub('_', '-', measure),
                                                      " respondents that showed", " ", stringr::str_to_lower(input$outcome_type), ": ", percent, "%", "<br>",
                                                      "Mean change (pre to post) on the: ", gsub('_', '-', measure), ": ", average_change))) +
    geom_col() +
    xlab("Outcome Measure") + ylab(paste("% Of Respondents:", stringr::str_to_sentence(input$outcome_type))) +
    ggtitle(paste("", stringr::str_to_sentence(input$outcome_type))) +
    scale_x_discrete(labels = measures_whitespace) +
    theme(panel.grid.minor.y = element_blank(),
          panel.grid.major.y = element_blank(),
          panel.background = element_blank(),
          panel.grid.major.x = element_line("grey"),
          axis.text.x = element_text(angle=65, vjust=0.6),
          legend.position="none"
    ) + theme(panel.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
          plot.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
          legend.background = element_rect(fill = '#e5e5e5'))



  plotly::ggplotly(p, tooltip = "text")

})

}
#' Simplified Application Mean widget module
#'
#' Generates the widget with correct default values for the simplified application mean widget and references.
#'
#' @param id String to create a unique namespace.
#'
#' @export


generate_simplified_mean_widget_UI <- function(id) {

  ns <- NS(id) #Set namespace


  fluidRow(uiOutput(ns("simplified_mean_widget_out")))


}


#' Mean widget module
#'
#' Generates the widget with correct default values for the mean widget and references.
#'
#' @param holding_data A dataframe representing the client's existing available data for this measure.
#'
#' @param subscale_number A number identifiying the subscale (i.e. which row of mean in the holding table should be selected).
#'
#' @param statistic_type A string indicating the type of statistic displayed by widget (one of "mean", "sd", "reliability")
#'
#' @export



generate_simplified_mean_widget<- function(input, output, session, holding_data, subscale_number, statistic_type) {


  #Render the widgets

  output$simplified_mean_widget_out <- renderUI({

    ns <- session$ns

    div(                #Pull in the mean stats from holding table and use them to prepopulate the widgets. Accessing the stats via the widget output
                        #is better because it allows us to retain the workflow of the parent app, which is especially important when the measure has
                        #multiple subscales.

      numericInput(ns("mean_value_id"), paste(statistic_type), value = holding_data()$mean[subscale_number]),

      textInput(ns("mean_reference_id"), "Reference", value = holding_data()$mean_reference[subscale_number])

    )

  })


  #Make sure the values for the mean widgets are accessible even if tab is not clicked

  outputOptions(output, "simplified_mean_widget_out", suspendWhenHidden = FALSE)

  #Need to finish the module with reactive value list containing id of value widget & reference widget - so these can be accessed by another module.
  #Add req() so the input values aren't NULL initially


  reactive({ list( req(input$mean_value_id), req(input$mean_reference_id) ) })




}

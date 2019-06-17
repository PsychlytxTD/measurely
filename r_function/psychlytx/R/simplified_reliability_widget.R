#' Simplified Application reliability widget module
#'
#' Generates the widget with correct default values for the simplified application reliability widget and references.
#'
#' @param id String to create a unique namespace.
#'
#' @export


generate_simplified_reliability_widget_UI <- function(id) {

  ns <- NS(id) #Set namespace


  fluidRow(uiOutput(ns("simplified_reliability_widget_out")))


}


#' reliability widget module
#'
#' Generates the widget with correct default values for the reliability widget and references.
#'
#' @param holding_data A dataframe representing the client's existing available data for this measure.
#'
#' @param subscale_number A number identifiying the subscale (i.e. which row of reliability in the holding table should be selected).
#'
#' @param statistic_type A string indicating the type of statistic displayed by widget (one of "reliability", "sd", "reliability")
#'
#' @export



generate_simplified_reliability_widget<- function(input, output, session, holding_data, subscale_number, statistic_type) {


  #Render the widgets

  output$simplified_reliability_widget_out <- renderUI({

    ns <- session$ns

    div(             #Pull in the reliability stats from holding table and use them to prepopulate the widgets. Accessing the stats via the widget output
                     #is better because it allows us to retain the workflow of the parent app, which is especially important when the measure has
                    #multiple subscales.

      numericInput(ns("reliability_value_id"), paste(statistic_type), value = holding_data()$reliability[subscale_number]),

      textInput(ns("reliability_reference_id"), "Reference", value = holding_data()$reliability_reference[subscale_number])

    )

  })


  #Make sure the values for the reliability widgets are accessible even if tab is not clicked

  outputOptions(output, "simplified_reliability_widget_out", suspendWhenHidden = FALSE)

  #Need to finish the module with reactive value list containing id of value widget & reference widget - so these can be accessed by another module.
  #Add req() so the input values aren't NULL initially


  reactive({ list( req(input$reliability_value_id), req(input$reliability_reference_id) ) })




}

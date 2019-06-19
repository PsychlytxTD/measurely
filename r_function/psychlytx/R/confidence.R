#' Confidence Level
#'
#' Generates a confidence interval widget
#'
#' @param id String to create a unique namespace.
#'
#' @export

confidence_level_UI <- function(id) {

  ns <- NS(id) #Set the namespace

  #Create a widget allowing the user to select the level of confidence for intervals

  tagList(fluidRow(column(width = 12, offset = 4,
                          radioButtons(ns("confidence"), label = h4(tags$strong("Level of Confidence For Intervals")), choices = list("99%" = 1.645,
                          "95%" = 1.96, "90%" = 2.575), selected = 1.96, inline = T)

  )))

}



#' Confidence Level
#'
#' Generates a confidence interval widget
#'
#' @param existing_data A dataframe representing the client's existing available data for this measure.
#'
#' @export

confidence_level<- function(input, output, session, existing_data) {

 observe({

   if(length(existing_data()$confidence) >= 1 ) {

     updateRadioButtons(session, "confidence", selected = existing_data()$confidence[1], inline = TRUE)

   }

 })



  reactive({

    return( req(as.numeric(input$confidence)) )

})

}

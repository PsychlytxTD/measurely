#' Simplified Application Confidence Level
#'
#' Generates a confidence interval widget
#'
#' @param id String to create a unique namespace.
#'
#' @export

simplified_confidence_level_UI <- function(id) {

  ns <- NS(id) #Set the namespace

  #Create a widget allowing the user to select the level of confidence for intervals

  tagList(fluidRow(column(width = 12, offset = 4,
                          radioButtons(ns("confidence"), label = h4(tags$strong("Interval Confidence Level")), choices = list("99%" = 1.645,
                                                                                                                              "95%" = 1.96, "90%" = 2.575), selected = 1.96, inline = T)

  )))

}



#' Confidence Level
#'
#' Generates a confidence interval widget
#'
#' @param holding_data A dataframe representing the client's statistics in the DB holding table.
#'
#' @export

simplified_confidence_level<- function(input, output, session, holding_data) {

  observe({   #Pull statistic from correct patient row in holding table in db.

      updateRadioButtons(session, "confidence", selected = holding_data()$confidence[1], inline = TRUE)


  })



  reactive({

    return( req(as.numeric(input$confidence)) )

  })

}

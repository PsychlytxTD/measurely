#' Make Client Name For Display
#'
#' Pull name from db to display on app tabpanels
#'
#' @param id A string to create the namespace.
#'
#' @export

show_client_name_UI<- function(id) {

  ns <- NS(id)

tagList(

br(),

fluidRow(
  column(width = 12,

         "Person Completing the Outcome Measure:",

         uiOutput(ns("client_name"))

  )))

}

#' Make Client Name For Display
#'
#' Pull name from db to display on app tabpanels
#'
#' @param client_name_for_display A reactive object containing the client's first and last names.
#'
#' @export

show_client_name<- function(input, output, session, client_name_for_display) {

output$client_name<- renderUI({

  ns <- session$ns

  selectInput(ns("client_name_widget"), "", paste(client_name_for_display()[1], client_name_for_display()[2]))

})

}


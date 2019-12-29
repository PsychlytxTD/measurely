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

         h3("Person Completing Outcome Measure:"),

         selectInput(ns("client_name_widget"), "", "No client selected!! Please select a client")

  )))

}

#' Make Client Name For Display
#'
#' Pull name from db to display on app tabpanels
#'
#' @param client_name_for_display A reactive object (string) containing the client's first and last names.
#'
#' @param input_retrive_client_data A reactive value: the value of client selection button.
#'
#' @export

show_client_name<- function(input, output, session, client_name_for_display, input_retrieve_client_data) {



  observeEvent(input_retrieve_client_data(), {

  updateSelectInput(session, "client_name_widget", selected = paste(client_name_for_display()[1], client_name_for_display()[2]),
                    choices = paste(client_name_for_display()[1], client_name_for_display()[2]))

  })


}


#' Make Client Name For Display
#'
#' Pull name from db to display on app tabpanels
#'
#' @param id A string to create the namespace.
#'
#' @export

simplified_show_name_UI<- function(id) {

  ns <- NS(id)

 uiOutput(ns("simplified_client_name_widget"))



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

simplified_show_name<- function(input, output, session, holding_data) {


  output$simplified_client_name_widget<- renderUI({

    ns <- session$ns

    selectInput(ns("client_name"), "Name", choices = c(paste(holding_data()$first_name[1], holding_data()$last_name[1])),
                selected = paste(holding_data()$first_name[1], holding_data()$last_name[1]))

  })


}


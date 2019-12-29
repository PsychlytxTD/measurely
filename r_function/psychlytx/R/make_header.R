#' Make Header
#'
#' Module to make header
#'
#' @param id A string to create the namespace
#'
#' @param header_text A string indicating the name of the outcome measure.
#'
#' @export


make_header_UI<- function(id, header_text) {

  ns <- NS(id)

 dashboardHeader(title = span(tagList(tags$a(href = "http://psychlytx.com.au", "Measurely", style = "color: white; font-size: 26px; letter-spacing:
                                             7.8px;font-weight: bolder;"), tags$sup("®"), "|", paste(header_text)),
                                            style = "color: white; letter-spacing: 1.8px;"), titleWidth = 820)

}



#' Make Header
#'
#' Module to make header
#'
#' @export


make_header<- function(input, output, session) {

  return(NULL)

}


#' Make Footer
#'
#' Module to make footer
#'
#' @param id A string to create the namespace
#'
#' @export

make_footer_UI<- function(id) {

  ns <- NS(id)

  column(span(tagList("Psychlytx", icon("registered", lib = "font-awesome"))), offset = 5, width = 12)


}


#' Make Footer
#'
#' Module to make footer
#'
#' @export


make_footer<- function(input, output, session) {

  return(NULL)

}

#' Make About Tab
#'
#' Module to make 'About' tab
#'
#' @param id A string to create the namespace
#'
#' @export


make_about_tab_UI<- function(id) {

  ns<- NS(id)

  tabItem(tabName = "About", br(), br(), br(), br(),br(), br(),br(),br(), br(),
          column(12, offset = 4, h1(tags$a(href = "http://psychlytx.com.au", "Visit PsychlytX here.",  style = "color: #827717;")))
  )

}



#' Make About Tab
#'
#' Module to make 'About' tab
#'
#' @export


make_about_tab<- function(input, output, session) {

  return(NULL)

}

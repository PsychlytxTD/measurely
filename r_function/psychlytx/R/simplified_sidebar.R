#' Make Sidebar
#'
#' Module to make sidebar
#'
#' @param id A string to create the namespace
#'
#' @export


make_simplified_sidebar_UI<- function(id) {


  dashboardSidebar(  #Menu items are hyperlinks to website pages
    sidebarMenu(
      br(),
      menuItem("Home", icon = icon("line-chart"), tabName = "Home", selected = TRUE),    #Remove menu items for changing account settings etc. Clients don't need to see this.
      br(),
      div( HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;'), icon("info"), HTML('&nbsp;'), HTML('&nbsp;'),
           HTML('&nbsp;'), HTML('&nbsp;'), tags$a("About Psychlytx", href = "https:://psychlytx.com.au", style = "color:white")),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      tags$footer(tags$a(href = "http://psychlytx.com.au", target = "_blank", HTML("<br><center>"), "PsychlytX", tags$sup(icon("registered")), br(),
                         "© PsychlytX 2019"))
    )
  )

}



#' Make Sidebar
#'
#' Module to make sidebar
#'
#' @export


make_simplified_sidebar<- function(input, output, session) {

  return(NULL)

}

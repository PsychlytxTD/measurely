#' Make Sidebar
#'
#' Module to make sidebar
#'
#' @param id A string to create the namespace
#'
#' @export


make_sidebar_UI<- function(id) {


  dashboardSidebar(  #Menu items are hyperlinks to website pages
    sidebarMenu(
      br(),
      menuItem(h3("Landing"), tabName = "Landing", selected = TRUE),
      br(),
      menuItem(h3("Home"), icon = icon("line-chart", "fa-3x"), tabName = "Home"),
      br(),
      div( HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;'), icon("info", "fa-3x"), HTML('&nbsp;'), HTML('&nbsp;'),
            HTML('&nbsp;'), HTML('&nbsp;'), tags$a(h3("About Psychlytx"), href = "http://www.psychlytx.com", style = "color:white")),
      br(),
      div( HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;'), icon("user-cog", "fa-3x"), HTML('&nbsp;'),
            HTML('&nbsp;'), tags$a(h3("Update Account Details"), href = "http://www.psychlytx.com", style = "color:white")),
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
      tags$footer(tags$a(href = "http://psychlytx.com.au", target = "_blank", HTML("<br><center>"), "Psychlytx", tags$sup(icon("registered"))
                         ))
    )
  )

}



#' Make Sidebar
#'
#' Module to make sidebar
#'
#' @export


make_sidebar<- function(input, output, session) {

  return(NULL)

}

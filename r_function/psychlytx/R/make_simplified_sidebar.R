#' Make Sidebar
#'
#' Module to make sidebar
#'
#' @param id A string to create the namespace
#'
#' @export


make_simplified_sidebar_UI<- function(id) {

  ns <- NS(id)

  dashboardSidebar(  #Menu items are hyperlinks to website pages
    sidebarMenu(id = ns("tabs"),
                br(),
                menuItem(h4(""), tabName = "Landing"),
                br(),
                menuItem(h4("Home"), icon = icon("line-chart", "fa-2x"), tabName = "Home"),
                br(),
                menuItem(h4("About Psychlytx"), icon = icon("info", "fa-2x"), href = "http://www.psychlytx.com"),
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
#' @param start_button_input A reactive value containing value of start_button action button.
#'
#' @export


make_simplified_sidebar<- function(input, output, session, start_button_input) {

  observeEvent(start_button_input(), {

    newtab <- switch(input$tabs, "Landing" = "Home")
    updateTabItems(session, "tabs", newtab)
  })

}

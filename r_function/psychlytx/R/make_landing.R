#' Make Landing
#'
#' Generate landing page.
#'
#' @param id A string to create the namespace
#'
#' @export


make_landing_UI<- function(id) {

  ns <- NS(id)

  # parent container
  tags$div(class="landing-wrapper",

           # child element 1: images
           tags$div(class="landing-block background-content",

                    # images - top -> bottom, left -> right
                    tags$img(src="talking.jpg"),
                    tags$img(src="faces.jpg"),
                    tags$img(src="deckchairs.jpg"),
                    tags$img(src="headway.jpg")
           ),

           # child element 2: content
           tags$div(class="landing-block foreground-content",

                    h1("Welcome to Measurely"),

                    br(),

                    actionButton(ns("start_button"), "Get Started", class = "start_button")

           )


  )

}


#' Make Landing
#'
#' Generate landing page.
#'
#' @export

make_landing<- function(input, output, session) {

  reactive({ return(input$start_button) })

}


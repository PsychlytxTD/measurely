#' Selected Population Message
#'
#' Show a message indicating the population that was selected
#'
#' @param id String to create the namespace
#'
#' @export


show_population_message_UI<- function(id) {

  ns <- NS(id)

  tagList(

    fluidRow(

      column(width = 11, offset = 1,
             titlePanel(span(tagList(icon("calculator", lib = "font-awesome")),
                             h4(tags$b("Modify the default values that are used to assess reliable change and symptom severity.")))))),

    br(),

    fluidRow(

      column(width = 7, offset = 4, HTML('&nbsp;'), a(tags$strong("Learn more about customisation"),
                                                      href = "http://psychlytx.com", style = "color:#d35400"))),

    br(),


         fluidRow(

            column(width = 10, offset = 1,

                         htmlOutput(ns("selected_population_message")))),

    br()



         )


}




#' Selected Population Message
#'
#' Show a message indicating the population that was selected
#'
#' @param input_population String indicating selected population
#'
#' @export

show_population_message<- function(input, output, session, input_population) {

  output$selected_population_message<- renderText({           #Send message about population selection

    paste(h4("Means and standard deviations apply to the client group you selected:", tags$strong(gsub("_", " ", input_population()))))

  })

}

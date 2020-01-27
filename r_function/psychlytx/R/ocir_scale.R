#' OCI-R Scale
#'
#' Generates the OCI-R for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
ocir_scale_UI<- function(id) {

  ns<- NS(id)

  div(id = ns("reset_id"),

  tagList(

    br(),

    wellPanel(style = "background-color: #ffffff; color: black",
              fluidRow(
                column(width = 12, offset = 5, h3(tags$strong("OCI-R")))
              ),
              fluidRow(
                column(width = 12, div(h3("The following statements refer to experiences that many people have in their everyday lives. Circle the number
                                          that best describes", tags$strong("HOW MUCH"), "that experience has", tags$strong("DISTRESSED"), "or", tags$strong("BOTHERED"), "you during the", tags$strong("PAST MONTH."), "The numbers refer to the
                                          following verbal labels:")))
                ),
              hr(),
              fluidRow(
                h4(tags$strong(
                  HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "0", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),
                  HTML('&emsp;'), HTML('&emsp;'), "1", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),
                  HTML('&emsp;'), HTML('&emsp;'), "2", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),
                  HTML('&emsp;'), HTML('&emsp;'), "3", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),
                  HTML('&emsp;'), HTML('&emsp;'), "4"
                ))
              ),
              fluidRow(
                div(
                  h4(tags$strong(
                    HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "Not at all", HTML('&emsp;'),
                    HTML('&emsp;'), "|", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "A little", HTML('&emsp;'),
                    HTML('&emsp;'), "|", HTML('&emsp;'), HTML('&emsp;'), "Moderately", HTML('&emsp;'),
                    HTML('&emsp;'), "|", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),"A lot", HTML('&emsp;'),
                    HTML('&emsp;'), "|", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "Extremely"
                  )))),
              hr(),

              fluidRow(style = "background-color: #ededed",
                       column(width = 6, h4("1. I have saved up so many things that they get in the way.")),
                       column(width = 6,checkboxGroupInput(ns("item_1"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("2. I check things more often than necessary.")),
                column(width = 6, checkboxGroupInput(ns("item_2"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ededed",
                       column(width = 6, h4("3. I get upset if objects are not arranged properly.")),
                       column(width = 6, checkboxGroupInput(ns("item_3"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("4. I feel compelled to count while I am doing things.")),
                column(width = 6, checkboxGroupInput(ns("item_4"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ededed",
                       column(width = 6, h4("5. I find it difficult to touch an object when I know it has been touched by strangers or certain people.")),
                       column(width = 6, checkboxGroupInput(ns("item_5"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("6. I find it difficult to control my own thoughts.")),
                column(width = 6, checkboxGroupInput(ns("item_6"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ededed",
                       column(width = 6, h4("7. I collect things I don’t need.")),
                       column(width = 6, checkboxGroupInput(ns("item_7"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("8. I repeatedly check doors, windows, drawers, etc.")),
                column(width = 6, checkboxGroupInput(ns("item_8"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ededed",
                       column(width = 6, h4("9. I get upset if others change the way I have arranged things.")),
                       column(width = 6, checkboxGroupInput(ns("item_9"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("10. I feel I have to repeat certain numbers.")),
                column(width = 6, checkboxGroupInput(ns("item_10"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ededed",
                       column(width = 6, h4("11. I sometimes have to wash or clean myself simply because I feel contaminated.")),
                       column(width = 6, checkboxGroupInput(ns("item_11"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("12. I am upset by unpleasant thoughts that come into my mind against my will.")),
                column(width = 6, checkboxGroupInput(ns("item_12"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ededed",
                       column(width = 6, h4("13. I avoid throwing things away because I am afraid I might need them later.")),
                       column(width = 6, checkboxGroupInput(ns("item_13"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("14. I repeatedly check gas and water taps and light switches after turning them off.")),
                column(width = 6, checkboxGroupInput(ns("item_14"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ededed",
                       column(width = 6, h4("15. I need things to be arranged in a particular way.")),
                       column(width = 6, checkboxGroupInput(ns("item_15"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("16. I feel that there are good and bad numbers.")),
                column(width = 6, checkboxGroupInput(ns("item_16"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ededed",
                       column(width = 6, h4("17. I wash my hands more often and longer than necessary.")),
                       column(width = 6, checkboxGroupInput(ns("item_17"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("18. I frequently get nasty thoughts and have difficulty in getting rid of them.")),
                column(width = 6, checkboxGroupInput(ns("item_18"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),

                fluidRow(
                  column(width = 12, h5("Scale Source: Foa, E.B., Huppert, J.D., Leiberg, S., Hajcak, G., Langner, R., et al. (2002). The Obsessive Compulsive Inventory: Development and validation of a short version. Psychological Assessment,
                                        14, 485-496."))
                  )


              )


))

}

#' OCI-R Scale
#'
#' Generates the OCI-R for data entry
#'
#' @param selected_client A string indicating the unique id of the selected client.
#'
#' @param simplified A boolean value indicating whether scale is being inserted in the remote app.
#'
#' @export
#'
ocir_scale<- function(input, output, session, selected_client = NULL, simplified = FALSE) {

  if(isFALSE(simplified)) {

    observeEvent(selected_client(), {

      shinyjs::reset("reset_id")

    })

  }



  observe({
    #Make a logical vector indicating whether a scale item had more than one response endorsed.

    item_too_long<- purrr::map_lgl(list(c(input$item_1), c(input$item_2), c(input$item_3), c(input$item_4),
                                        c(input$item_5), c(input$item_6), c(input$item_7), c(input$item_8),
                                        c(input$item_9), c(input$item_10), c(input$item_11), c(input$item_12),
                                        c(input$item_13), c(input$item_14), c(input$item_15), c(input$item_16),
                                        c(input$item_17), c(input$item_18)), ~length(.x) > 1)

    #Generate a sweet alert as soon as more than one responsennisngiven for an item

    psychlytx::warn_too_many_responses(session, item_too_long)

  })

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, input$item_6, input$item_7,
                                  input$item_8, input$item_9, input$item_10, input$item_11, input$item_12, input$item_13, input$item_14,
                                  input$item_15, input$item_16, input$item_17, input$item_18, sep = ",") })

  return(scale_entry)

}

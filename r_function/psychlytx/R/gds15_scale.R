#' GDS-15 Scale
#'
#' Generates the GDS-15 for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
gds15_scale_UI<- function(id) {

  ns<- NS(id)

  div(id = ns("reset_id"),

  tagList(

    br(),

    wellPanel(style = "background-color: #ededed; color: black",
              fluidRow(
                column(width = 12, offset = 5, h3(tags$strong("GDS-15")))
              ),
              hr(),
              fluidRow(style = "background-color: #ededed",
                       column(width = 12, h4(tags$strong("Instructions: Choose the best answer for how you felt over the past week.")))
              ),
              hr(),
              fluidRow(
                column(width = 10, h4("1. Are you basically satisfed with your life?")),
                column(width = 2, checkboxGroupInput(ns("item_1"), label = NULL, choices = c("YES" = "0", "NO" = "1"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ffffff",
                       column(width = 10, h4("2.	Have you dropped many of your activities and interests?")),
                       column(width = 2, checkboxGroupInput(ns("item_2"), label = NULL, choices = c("YES" = "1", "NO" = "0"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 10, h4("3. Do you feel that your life is empty?")),
                column(width = 2, checkboxGroupInput(ns("item_3"), label = NULL, choices = c("YES" = "1", "NO" = "0"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ffffff",
                       column(width = 10, h4("4. Do you often get bored?")),
                       column(width = 2, checkboxGroupInput(ns("item_4"), label = NULL, choices = c("YES" = "1", "NO" = "0"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 10, h4("5. Are you in good spirits most of the time? ")),
                column(width = 2, checkboxGroupInput(ns("item_5"), label = NULL, choices = c("YES" = "0", "NO" = "1"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ffffff",
                       column(width = 10, h4("6.	Are you afraid that something bad is going to happen to you?")),
                       column(width = 2, checkboxGroupInput(ns("item_6"), label = NULL, choices = c("YES" = "1", "NO" = "0"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 10, h4("7. Do you feel happy most of the time?")),
                column(width = 2, checkboxGroupInput(ns("item_7"), label = NULL, choices = c("YES" = "0", "NO" = "1"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ffffff",
                       column(width = 10, h4("8. Do you often feel helpless?")),
                       column(width = 2, checkboxGroupInput(ns("item_8"), label = NULL, choices = c("YES" = "1", "NO" = "0"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 10, h4("9. Do you prefer to stay at home, rather than going out and doing new things?")),
                column(width = 2, checkboxGroupInput(ns("item_9"), label = NULL, choices = c("YES" = "1", "NO" = "0"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ffffff",
                       column(width = 10, h4("10. Do you feel you have more problems with memory than most?")),
                       column(width = 2, checkboxGroupInput(ns("item_10"), label = NULL, choices = c("YES" = "1", "NO" = "0"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 10, h4("11. Do you think it is wonderful to be alive now?")),
                column(width = 2, checkboxGroupInput(ns("item_11"), label = NULL, choices = c("YES" = "0", "NO" = "1"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ffffff",
                       column(width = 10, h4("12. Do you feel pretty worthless the way you are now? ")),
                       column(width = 2, checkboxGroupInput(ns("item_12"), label = NULL, choices = c("YES" = "1", "NO" = "0"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 10, h4("13. Do you feel full of energy?")),
                column(width = 2, checkboxGroupInput(ns("item_13"), label = NULL, choices = c("YES" = "0", "NO" = "1"), inline = TRUE, selected = NULL))
              ),
              fluidRow(style = "background-color: #ffffff",
                       column(width = 10, h4("14. Do you feel that your situation is hopeless?")),
                       column(width = 2, checkboxGroupInput(ns("item_14"), label = NULL, choices = c("YES" = "1", "NO" = "0"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 10, h4("15. Do you think that most people are better off than you are?")),
                column(width = 2, checkboxGroupInput(ns("item_15"), label = NULL, choices = c("YES" = "1", "NO" = "0"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 12, h5("Source: Sheikh, J.I., & Yesavage, J.A. (1986). Geriatric Depression Scale (GDS). Recent evidence and development of a shorter version. In T.L. Brink (Ed.), Clinical Gerontology: A Guide to Assessment and Intervention (pp. 165-173). NY: The Haworth Press, Inc."))
              )
    )

    ))

}

#' GDS-15 Scale
#'
#' Generates the GDS-15 for data entry
#'
#' @param selected_client A string indicating the unique id of the selected client.
#'
#' @param simplified A boolean value indicating whether scale is being inserted in the remote app.
#'
#' @export
#'
gds15_scale<- function(input, output, session, selected_client = NULL, simplified = FALSE) {


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
                                        c(input$item_13), c(input$item_14), c(input$item_15)), ~length(.x) > 1)

    #Generate a sweet alert as soon as more than one responsennisngiven for an item

    psychlytx::warn_too_many_responses(session, item_too_long)

  })


  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, input$item_6, input$item_7,
                                  input$item_8, input$item_9, input$item_10, input$item_11, input$item_12, input$item_13,
                                  input$item_14, input$item_15, sep = ",") })

  return(scale_entry)

}

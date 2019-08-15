#' EDPS Scale
#'
#' Generates the EDPS for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
edps_scale_UI<- function(id) {

  ns<- NS(id)

  tagList(

    wellPanel(style = "background-color: white; color: black",
              fluidRow(
                column(width = 12, offset = 5, h2(tags$strong("EDPS")))
              ),

              fluidRow(
                column(width = 12,
                       h3(tags$strong("INSTRUCTIONS:")),
                       h3(tags$strong("Please select one option for each question that is the closest to how you have felt in the PAST SEVEN DAYS."))
                )
              ),

              br(),

              fluidRow(
                column(width = 6,
                       h4(tags$strong("1. I have been able to laugh and see the funny side of things:")),
                       radioButtons(ns("item_1"), "", choices = c("As much as I always could" = "0",
                                                              "Not quite as much now" = "1",
                                                              "Definietly not so much now" = "2",
                                                              "Not at all" = "3"), inline = F, selected = character(0))
                ),
                column(width = 6, h4(tags$strong("6. Things have been getting on top of me:")),
                       radioButtons(ns("item_6"), "", choices = c("Yes, most of the time I haven't been able to cope at all" = "3",
                                                              "Yes, sometimes I haven't been coping as well as usual" = "2",
                                                              "No, most of the time I have coped quite well" = "1",
                                                              "No, I have been coping as well as ever" = "0"), inline = F, selected = character(0))
                )
              ),

              fluidRow(
                column(width = 6,
                       h4(tags$strong("2. I have looked forward with enjoyment to things:")),
                       radioButtons(ns("item_2"), "", choices = c("As much as I ever did" = "0",
                                                              "Rather less than I used to" = "1",
                                                              "Definietly less than I used to" = "2",
                                                              "Hardly at all" = "3"), inline = F, selected = character(0))
                ),
                column(width = 6, h4(tags$strong("7. I have been so unhappy that I have had difficulty sleeping:")),
                       radioButtons(ns("item_7"), "", choices = c("Yes, most of the time" = "3",
                                                              "Yes, sometimes" = "2",
                                                              "No, not very often" = "1",
                                                              "No, not at all" = "0"), inline = F, selected = character(0))
                )
              ),

              fluidRow(
                column(width = 6,
                       h4(tags$strong("3. I have blamed myself unneccesarily when things went wrong:")),
                       radioButtons(ns("item_3"), "", choices = c("Yes, most of the time" = "3",
                                                              "Yes, some of the time" = "2",
                                                              "Not very often" = "1",
                                                              "No, never" = "0"), inline = F, selected = character(0))
                ),
                column(width = 6, h4(tags$strong("8. I have felt sad or miserable:")),
                       radioButtons(ns("item_8"), "", choices = c("Yes, most of the time" = "3",
                                                              "Yes, quite often" = "2",
                                                              "Not very often" = "1",
                                                              "No, not at all" = "0"), inline = F, selected = character(0))
                )
              ),


              fluidRow(
                column(width = 6,
                       h4(tags$strong("4. I have been anxious or worried for no good reason")),
                       radioButtons(ns("item_4"), "", choices = c("No, not at all" = "0",
                                                              "Hardly ever" = "1",
                                                              "Yes, sometimes" = "2",
                                                              "Yes, very often" = "3"), inline = F, selected = character(0))
                ),
                column(width = 6, h4(tags$strong("9.I have been so unhappy that I have been crying")),
                       radioButtons(ns("item_9"), "", choices = c("Yes, most of the time" = "3",
                                                              "Yes, quite often" = "2",
                                                              "Only occasionally" = "1",
                                                              "No, never" = "0"), inline = F, selected = character(0))
                )
              ),


              fluidRow(
                column(width = 6,
                       h4(tags$strong("5. I have felt scared or panicky for no very good reason:")),
                       radioButtons(ns("item_5"), "", choices = c("Yes, quite a lot" = "3",
                                                              "Yes, sometimes" = "2",
                                                              "No, not much" = "1",
                                                              "No, not at all" = "0"), inline = F, selected = character(0))
                ),
                column(width = 6, h4(tags$strong("10. The thought of harming myself has occurred to me:")),
                       radioButtons(ns("item_10"), "", choices = c("Yes, quite often" = "3",
                                                               "Sometimes" = "2",
                                                               "Hardly ever" = "1",
                                                               "Never" = "0"), inline = F, selected = character(0))
                )
              ),

              fluidRow(
                column(width = 12, h5("Source: Cox, J.L., Holden, J.M. and Sagovsky, R. (1987). Detection of postnatal depression: development of the 10-item Edinburgh Postnatal Depression Scale, British Journal of Psychiatry, 150782-786."))
              )

    )

   )

}

#' EDPS Scale
#'
#' Generates the EDPS for data entry
#'
#'@export
#'
edps_scale<- function(input, output, session) {

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, input$item_6, input$item_7,
                                  input$item_8, input$item_9, input$item_10, sep = ",") })

  return(scale_entry)

}

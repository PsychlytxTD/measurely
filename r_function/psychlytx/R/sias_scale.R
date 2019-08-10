#' SIAS Scale
#'
#' Generates the SIAS for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
sias_scale_UI<- function(id) {

  ns<- NS(id)

  tagList(

    wellPanel(style = "background-color: #ffffff; color: black",
              fluidRow(
                column(width = 12, offset = 5, h3(tags$strong("SIAS")))
              ),
              hr(),
              fluidRow(
                column(width = 12, div(h4(tags$strong("Instructions:"), "For each item, please circle the number to indicate the degree to which you feel the statement is characteristic or true for you. The rating scale is as follows:")))
              ),
              fluidRow(
                column(width = 3),
                column(width = 9, div(h4("0 = ", tags$strong("Not at all"), "characteristic or true of me.")))
              ),
              fluidRow(
                column(width = 3),
                column(width = 9, div(h4("1 = ", tags$strong("Slightly"), "characteristic or true of me.")))
              ),
              fluidRow(
                column(width = 3),
                column(width = 9, div(h4("2 = ", tags$strong("Moderately"), "characteristic or true of me.")))
              ),
              fluidRow(
                column(width = 3),
                column(width = 9, div(h4("3 = ", tags$strong("Very"), "characteristic or true of me.")))
              ),
              fluidRow(
                column(width = 3),
                column(width = 9, div(h4("4 = ", tags$strong("Extremely"), "characteristic or true of me.")))
              ),
              br(),
              fluidRow(
                column(width = 6, h4(tags$strong("CHARACTERISTIC"))),
                column(width = 1, h5(tags$strong("NOT AT ALL"))),
                column(width = 1, h5(tags$strong("SLIGHTLY"))),
                column(width = 1, h5(tags$strong("MODERATELY"))),
                column(width = 1, h5(tags$strong(HTML('&emsp;'), "VERY"))),
                column(width = 1, h5(tags$strong("EXTREMELY")))
              ),
              fluidRow(
                column(width = 6, h4("1. I get nervous if I have to speak with someone in authority (teacher, boss etc.).")),
                column(width = 6, radioButtons(ns("item_1"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("2. I have difficulty making eye contact with others.")),
                column(width = 6, radioButtons(ns("item_2"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("3. I become tense if I have to talk about myself or my feelings.")),
                column(width = 6, radioButtons(ns("item_3"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("4. I find it difficult to mix comfortably with the people I work with.")),
                column(width = 6, radioButtons(ns("item_4"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("5. I find it easy to make friends my own age.")),
                column(width = 6, radioButtons(ns("item_5"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("6. I tense up if I meet an acquaintance in the street.")),
                column(width = 6, radioButtons(ns("item_6"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("7. When mixing socially, I am uncomfortable.")),
                column(width = 6, radioButtons(ns("item_7"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("8. I feel tense if I am alone with just one other person.")),
                column(width = 6, radioButtons(ns("item_8"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("9. I am at ease meeting people at parties, etc.")),
                column(width = 6, radioButtons(ns("item_9"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("10. I have difficulty talking with other people.")),
                column(width = 6, radioButtons(ns("item_10"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("11. I find it easy to think of things to talk about.")),
                column(width = 6, radioButtons(ns("item_11"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("12. I worry about expressing myself in case I appear awkward.")),
                column(width = 6, radioButtons(ns("item_12"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("13. I find it difficult to disagree with another's point of view.")),
                column(width = 6, radioButtons(ns("item_13"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("14. I have difficulty talking to attractive persons of the opposite sex.")),
                column(width = 6, radioButtons(ns("item_14"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("15. I find myself worrying that I won't know what to say in social situations.")),
                column(width = 6, radioButtons(ns("item_15"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("16. I am nervous mixing with people I don't know well.")),
                column(width = 6, radioButtons(ns("item_16"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("17. I feel I'll say something embarassing when talking.")),
                column(width = 6, radioButtons(ns("item_17"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("18. When mixing in a group, I find myself worrying I will be ignored.")),
                column(width = 6, radioButtons(ns("item_18"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("19. I am tense mixing in a group.")),
                column(width = 6, radioButtons(ns("item_19"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("20. I am unsure of whether to greet someone I know only slightly.")),
                column(width = 6, radioButtons(ns("item_20"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),

              fluidRow(
                column(width = 12, h5("Source: Mattick, R. P., & Clarke, J. (1998). Development and validation of measures of social phobia scrutiny fear and social interaction anxiety. Behaviour Research and Therapy, 36(4), 455–470."))
              )
    ))

}

#' SIAS Scale
#'
#' Generates the SIAS for data entry
#'
#'@export
#'
sias_scale<- function(input, output, session) {

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, input$item_6, input$item_7, input$item_8,
                                  input$item_9, input$item_10, input$item_11, input$item_12, input$item_13, input$item_14, input$item_15,
                                  input$item_16, input$item_17, input$item_18, input$item_19, input$item_20,  sep = ",") })

  return(scale_entry)

}

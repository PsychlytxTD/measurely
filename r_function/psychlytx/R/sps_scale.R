#' SPS Scale
#'
#' Generates the SPS for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
sps_scale_UI<- function(id) {

  ns<- NS(id)

  tagList(

    wellPanel(style = "background-color: #ffffff; color: black",
              fluidRow(
                column(width = 12, offset = 5, h3(tags$strong(HTML('&emsp;'), "SPS")))
              ),
              hr(),
              fluidRow(
                column(width = 12, div(h4(tags$strong("Instructions:"), "For each question, please fill in the blank with a number to indicate the degree to which you feel the statement is characteristic or true of you. The rating scale is as follows:")))
              ),
              fluidRow(
                column(width = 12, div(h4("0 = ", tags$strong("Not at all"), "characteristic or true of me.")))
              ),
              fluidRow(
                column(width = 12, div(h4("1 = ", tags$strong("Slightly"), "characteristic or true of me.")))
              ),
              fluidRow(
                column(width = 12, div(h4("2 = ", tags$strong("Moderately"), "characteristic or true of me.")))
              ),
              fluidRow(
                column(width = 12, div(h4("3 = ", tags$strong("Very"), "characteristic or true of me.")))
              ),
              fluidRow(
                column(width = 12, div(h4("4 = ", tags$strong("Extremely"), "characteristic or true of me.")))
              ),
              br(),
              fluidRow(
                column(width = 1, textInput("Item_1", label = NULL)),
                column(width = 11, h4("1. I become anxious if I have to write in front of other people."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_2", label = NULL)),
                column(width = 11, h4("2. I become self-conscious when using public toilets."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_3", label = NULL)),
                column(width = 11, h4("3. I can suddenly become aware of my own voice and of others listening to me."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_4", label = NULL)),
                column(width = 11, h4("4. I get nervous that people are staring at me as I walk down the street."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_5", label = NULL)),
                column(width = 11, h4("5. I fear I may blush when I am with others."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_6", label = NULL)),
                column(width = 11, h4("6. I feel self-conscious if I have to enter a room where others are already seated."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_7", label = NULL)),
                column(width = 11, h4("7. I worry about shaking or trembling when I’m watched by other people."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_8", label = NULL)),
                column(width = 11, h4("8. I would get tense if I had to sit facing other people on a bus or a train."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_9", label = NULL)),
                column(width = 11, h4("9. I get panicky that others might see me faint or be sick or ill."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_10", label = NULL)),
                column(width = 11, h4("10. I would find it difficult to drink something if in a group of people."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_11", label = NULL)),
                column(width = 11, h4("11. It would make me feel self-conscious to eat in front of a stranger at a restaurant."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_12", label = NULL)),
                column(width = 11, h4("12. I am worried people will think my behavior odd."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_13", label = NULL)),
                column(width = 11, h4("13. I would get tense if I had to carry a tray across a crowded cafeteria."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_14", label = NULL)),
                column(width = 11, h4("14. I worry I’ll lose control of myself in front of other people."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_15", label = NULL)),
                column(width = 11, h4("15. I worry I might do something to attract the attention of other people."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_16", label = NULL)),
                column(width = 11, h4("16. When in an elevator, I am tense if people look at me."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_17", label = NULL)),
                column(width = 11, h4("17. I can feel conspicuous standing in a line."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_18", label = NULL)),
                column(width = 11, h4("18. I can get tense when I speak in front of other people."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_19", label = NULL)),
                column(width = 11, h4("19. I worry my head will shake or nod in front of others."))
              ),
              fluidRow(
                column(width = 1, textInput("Item_20", label = NULL)),
                column(width = 11, h4("20. I feel awkward and tense if I know people are watching me."))
              ),

              fluidRow(
                column(width = 12, h5("Scale Source: Mattick, R. P., & Clarke, J. (1998). Development and validation of measures of social phobia scrutiny fear and social interaction anxiety. Behaviour Research and Therapy, 36(4), 455–470."))
              )
    ))

}

#' SPS Scale
#'
#' Generates the SPS for data entry
#'
#'@export
#'
sps_scale<- function(input, output, session) {

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, input$item_6, input$item_7, input$item_8,
                                  input$item_9, input$item_10, input$item_11, input$item_12, input$item_13, input$item_14, input$item_15,
                                  input$item_16, input$item_17, input$item_18, input$item_19, input$item_20,  sep = ",") })

  return(scale_entry)

}

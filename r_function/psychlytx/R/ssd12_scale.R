#' SSD-12 Scale
#'
#' Generates the SSD-12 for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
ssd12_scale_UI<- function(id) {

  ns<- NS(id)

  tagList(
    wellPanel(style = "background-color: #ffffff; color: black",
              fluidRow(
                column(width = 12, offset = 5, h3(tags$strong("SSD-12")))
              ),
              hr(),
              fluidRow(
                column(width = 6, h4(tags$strong(""))),
                column(width = 1, h5(tags$strong("Never"))),
                column(width = 1, h5(tags$strong("Rarely"))),
                column(width = 1, h5(tags$strong("Sometimes"))),
                column(width = 1, h5(tags$strong(HTML('&emsp;'),"Often"))),
                column(width = 2, h5(tags$strong("Very often")))
              ),

              fluidRow(
                column(width = 6, h4("1. I think that my physical symptoms are signs of a serious illness.")),
                column(width = 6, radioButtons(ns("item_1"), label = NULL, choices = c("0","1","2","3","4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("2. I am very worried about my health.")),
                column(width = 6, radioButtons(ns("item_2"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("3. My health concerns hinder me in everyday life.")),
                column(width = 6, radioButtons(ns("item_3"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("4. I am convinced that my symptoms are serious.")),
                column(width = 6, radioButtons(ns("item_4"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("5. My symptoms scare me.")),
                column(width = 6, radioButtons(ns("item_5"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("6. My physical complaints occupy me for most of the day.")),
                column(width = 6, radioButtons(ns("item_6"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("7. Others tell me that my physical problems are not serious.")),
                column(width = 6, radioButtons(ns("item_7"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("8. I'm worried that my physical complaints will never stop.")),
                column(width = 6, radioButtons(ns("item_8"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("9. My worries about my health take my energy.")),
                column(width = 6, radioButtons(ns("item_9"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("10. I think that doctors do not take my physical complaints seriously.")),
                column(width = 6, radioButtons(ns("item_10"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("11. I am worried that my physical symptoms will continue into the future.")),
                column(width = 6, radioButtons(ns("item_11"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("12. Due to my physical complaints, I have poor concentration on other things.")),
                column(width = 6, radioButtons(ns("item_12"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 12, h5("Source: Toussaint A, Murray AM, Voigt K et al. (2016). Development and validation of the Somatic Symptom Disorder–B Criteria Scale (SSD-12). Psychosomatic Medicine, 78, 5–12."))
              )
    )

    )

}

#' SSD-12 Scale
#'
#' Generates the SSD-12 for data entry
#'
#'@export
#'
ssd12_scale<- function(input, output, session) {

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, input$item_6, input$item_7,
                                  input$item_8, input$item_9, input$item_10, input$item_11, input$item_12, sep = ",") })

  return(scale_entry)

}

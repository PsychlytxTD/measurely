#' CPAQ-20 Scale
#'
#' Generates the CPAQ-20 for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
cpaq_20_scale_UI<- function(id) {

  ns<- NS(id)

  tagList(

    wellPanel(style = "background-color: #ffffff; color: black",
              fluidRow(
                column(width = 12, h3(tags$strong("Chronic Pain Acceptance Questionnaire")), br(), br(),
                       h4("Below you will find a list of statements. Please rate the truth of each statement as it applies to you.
                                                        Use the following rating scale to make your choices. For instance, if you believe a statement is ‘Always True,’
                                                        you would write a 6 in the blank next to that statement."))
              ),
              fluidRow(
                h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), "0", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),
                               "1", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),
                               "2", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),
                               "3", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),
                               "4", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),
                               "5", HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),
                               "6"))
              ),
              fluidRow(
                div(
                  h4(tags$strong(HTML('&emsp;'), "Never true", HTML('&emsp;'),
                                 "Very rarely true", HTML('&emsp;'),
                                 "Seldom true", HTML('&emsp;'),
                                 "Sometimes true", HTML('&emsp;'),
                                 "Often true", HTML('&emsp;'),
                                 "Almost always true", HTML('&emsp;'),
                                 "Always true"
                  )))),

              fluidRow(
                column(width = 1, textInput(ns("item_1"), label = NULL)),
                column(width = 11, h4("1. I am getting on with the business of living no matter what my level of pain is."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_2"), label = NULL)),
                column(width = 11, h4("2. My life is going well, even though I have chronic pain."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_3"), label = NULL)),
                column(width = 11, h4("3. It’s OK to experience pain."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_4"), label = NULL)),
                column(width = 11, h4("4. I would gladly sacrifice important things in my life to control this pain better."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_5"), label = NULL)),
                column(width = 11, h4("5. It’s not necessary for me to control my pain in order to handle my life well."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_6"), label = NULL)),
                column(width = 11, h4("6. Although things have changed, I am living a normal life despite my chronic pain."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_7"), label = NULL)),
                column(width = 11, h4("7. I need to concentrate on getting ride of my pain."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_8"), label = NULL)),
                column(width = 11, h4("8. There are many activities I do when I feel pain."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_9"), label = NULL)),
                column(width = 11, h4("9. I lead a full life even though I have chronic pain."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_10"), label = NULL)),
                column(width = 11, h4("10. Controlling my pain is less important than any other goals in my life."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_11"), label = NULL)),
                column(width = 11, h4("11. My thoughts and feelings about pain must change before I can take important steps in my life."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_12"), label = NULL)),
                column(width = 11, h4("12. Despite the pain, I am now sticking to a certain course in my life."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_13"), label = NULL)),
                column(width = 11, h4("13. Keeping my pain level under control takes first priority whenever I’m doing something."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_14"), label = NULL)),
                column(width = 11, h4("14. Before I can make any serious plans, I have to get some control over my pain."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_15"), label = NULL)),
                column(width = 11, h4("15. When my pain increases, I can still take care of my responsibilities."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_16"), label = NULL)),
                column(width = 11, h4("16. I will have better control over my life if I can control my negative thoughts about pain."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_17"), label = NULL)),
                column(width = 11, h4("17. I avoid putting myself in situations where my pain might increase."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_18"), label = NULL)),
                column(width = 11, h4("18. My worries and fears about what pain will do to me are true."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_19"), label = NULL)),
                column(width = 11, h4("19. It’s a great relief to realize that I don’t have to change my pain to get on with life."))
              ),
              fluidRow(
                column(width = 1, textInput(ns("item_20"), label = NULL)),
                column(width = 11, h4("20. I have to struggle to do things when I have pain."))
              ),
              fluidRow(
                column(width = 12, h5("Scale Source: McCraken, L. M., Vowles, K. E. & Eccleston, C. (2004). Acceptance of chronic pain: component analysis and a revised assessment method. Pain, 107, 159-166."))
              )

    )

  )

}

#' GAD-7 Scale
#'
#' Generates the GAD-7 for data entry
#'
#'@export
#'
cpaq_20_scale<- function(input, output, session) {

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, input$item_6, input$item_7,
                                  input$item_8, input$item_9, input$item_10, input$item_11, input$item_12, input$item_13, input$item_14,
                                  input$item_15, input$item_16, input$item_17, input$item_18, input$item_19, input$item_20, sep = ",") })

  return(scale_entry)

}

#' SDS Scale
#'
#' Generates the SDS for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
sds_scale_UI<- function(id) {

  ns<- NS(id)

  tagList(

    wellPanel(style = "background-color: #ffffff; color: black",
              h3(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "Severity of Dependence Scale (SDS)")),
              hr(),
              div(h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "Circle the answer that best applies to how you have felt about your use of", input$Drug_Name, "over the last month."))),
              br(),
              fluidRow(div(h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "1. Did you ever think your use of", input$Drug_Name, "was out of control?")))),
              fluidRow(
                column(width = 3),
                column(width = 4,
                       h4("Never or almost never"),
                       h4("Sometimes"),
                       h4("Often"),
                       h4("Always or nearly always")
                ),
                column(width = 4,
                       radioButtons("Item_1", label = NULL, choices = c("0", "1", "2", "3"), selected = character(0)))), br(),

              fluidRow(div(h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "2. Did the prospect of missing a", input$Drug_Term, "make you very anxious or worried?")))),
              fluidRow(
                column(width = 3),
                column(width = 4,
                       h4("Never or almost never"),
                       h4("Sometimes"),
                       h4("Often"),
                       h4("Always or nearly always")
                ),
                column(width = 4,
                       radioButtons("Item_2", label = NULL, choices = c("0", "1", "2", "3"), selected = character(0)))), br(),

              fluidRow(div(h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "3. Did you worry about your use of",input$Drug_Name,"?")))),
              fluidRow(
                column(width = 3),
                column(width = 4,
                       h4("Not at all"),
                       h4("A little"),
                       h4("Quite a lot"),
                       h4("A great deal")
                ),
                column(width = 4,
                       radioButtons("Item_3", label = NULL, choices = c("0", "1", "2", "3"), selected = character(0)))), br(),

              fluidRow(h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "4. Did you wish you could stop?"))),
              fluidRow(
                column(width = 3),
                column(width = 4,
                       h4("Never or almost never"),
                       h4("Sometimes"),
                       h4("Often"),
                       h4("Always or nearly always")
                ),
                column(width = 4,
                       radioButtons("Item_4", label = NULL, choices = c("0", "1", "2", "3"), selected = character(0)))), br(),

              fluidRow(h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "5. How difficult would you find it to stop or go without?"))),
              fluidRow(
                column(width = 3),
                column(width = 4,
                       h4("Not difficult"),
                       h4("Quite difficult"),
                       h4("Very difficult"),
                       h4("Impossible")
                ),
                column(width = 4,
                       radioButtons("Item_5", label = NULL, choices = c("0", "1", "2", "3"), selected = character(0)))),

              fluidRow(
                column(width = 12, h5("Scale Source: Gossop M, Darke S, Griffiths P, Hando J., Powis B., Hall W, Strang J (1995). The Severity of Dependence Scale (SDS): psychometric properties of the SDS in English and Australian samples of heroin, cocaine and amphetamine users. Addiction, 90(5):607-14."))
              )


    ))

}

#' SDS Scale
#'
#' Generates the SDS for data entry
#'
#'@export
#'
sds_scale<- function(input, output, session) {

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, sep = ",") })

  return(scale_entry)

}

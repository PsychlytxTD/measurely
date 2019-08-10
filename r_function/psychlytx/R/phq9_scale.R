#' PHQ-9 Scale
#'
#' Generates the PHQ-9 for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
phq9_scale_UI<- function(id) {

  ns<- NS(id)

  tagList(

    wellPanel(style = "background-color: #ffffff; color: black",
              fluidRow(
                column(width = 12, offset = 5, h3(tags$strong("PHQ-9")))
              ),
              hr(),
              fluidRow(
                column(width = 6, h4(tags$strong("Over the past 2 weeks, how often have you been bothered by any of the following problems?"))),
                column(width = 1, offset = 1, h4(tags$strong("Not at all"))),
                column(width = 1, h4(tags$strong("Several days"))),
                column(width = 1, h4(tags$strong("More than half the days"))),
                column(width = 1, h4(tags$strong("Nearly every day")))
              ),

              fluidRow(
                column(width = 7, h4("1. Little interest or pleasure in doing things")),
                column(width = 5, radioButtons(ns("item_1"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, , selected = character(0)))
              ),
              fluidRow(
                column(width = 7, h4("2. Feeling down, depressed, or hopeless")),
                column(width = 5, radioButtons(ns("item_2"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 7, h4("3. Trouble falling or staying asleep, or sleeping too much")),
                column(width = 5, radioButtons(ns("item_3"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 7, h4("4. Feeling tired or having little energy")),
                column(width = 5, radioButtons(ns("item_4"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 7, h4("5. Poor appetite or overeating")),
                column(width = 5, radioButtons(ns("item_5"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 7, h4("6. Feeling bad about yourself — or that you are a failure or have let yourself or your family down")),
                column(width = 5, radioButtons(ns("item_6"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 7, h4("7. Trouble concentrating on things, such as reading the newspaper or watching television")),
                column(width = 5, radioButtons(ns("item_7"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 7, h4("8. Moving or speaking so slowly that other people could have noticed? Or the opposite — being so fidgety or restless that you have been moving around a lot more than usual")),
                column(width = 5, radioButtons(ns("item_8"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 7, h4("9. Thoughts that you would be better off dead or of hurting yourself in some way")),
                column(width = 5, radioButtons(ns("item_9"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = character(0)))
              ),

              fluidRow(
                column(width = 12, h5("Source: Kroenke K., Spitzer R.L., & Williams J.B. (2001). The PHQ-9: validity of a brief depression severity measure. J. of Gen Intern Med, 16, 606-613"))
              )
    ))

}

#' PHQ-9 Scale
#'
#' Generates the PHQ-9 for data entry
#'
#'@export
#'
phq9_scale<- function(input, output, session) {

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, input$item_6, input$item_7,
                                  input$item_8, input$item_9, sep = ",") })

  return(scale_entry)

}

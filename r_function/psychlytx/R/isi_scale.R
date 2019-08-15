#' ISI Scale
#'
#' Generates the ISI for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
isi_scale_UI<- function(id) {

  ns<- NS(id)

  tagList(

    wellPanel(style = "background-color: #ffffff; color: black",
              fluidRow(
                column(width = 12, offset = 4, h3(tags$strong("Insomnia Severity Index")))
              ),
              fluidRow(
                column(width = 12,
                       h4(tags$strong("The Insomnia Severity Index has seven questions. The seven answers are added up to get a total score.
                                      When you have your total score, look at the 'Guidelines for Scoring/Interpretation' below to see where your sleep difficulty fits."
                       ))
                       )),
              fluidRow(
                column(width = 12,
                       h4(tags$strong("For each question, please CIRCLE the number that best describes your answer."))
                )),
              fluidRow(
                column(width = 12,
                       h4(tags$strong("Please rate the CURRENT (i.e. LAST 2 WEEKS) SEVERITY of your insomnia problem(s)."))
                )),
              br(), br(),
              fluidRow(
                column(width = 6, h4(tags$strong("Insomnia Problem"))),
                column(width = 1, h5(tags$strong("None"))),
                column(width = 1, h5(tags$strong("Mild"))),
                column(width = 1, h5(tags$strong("Moderate"))),
                column(width = 1, h5(tags$strong("Severe"))),
                column(width = 2, h5(tags$strong("Very Severe")))
              ),
              fluidRow(
                column(width = 6, h4("1. Difficulty falling asleep")),
                column(width = 6, radioButtons(ns("item_1"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("2. Difficulty staying asleep")),
                column(width = 6, radioButtons(ns("item_2"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 6, h4("3. Problems waking up too early?")),
                column(width = 6, radioButtons(ns("item_3"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = character(0)))
              ),
              hr(),
              fluidRow(
                column(width = 12,
                       h4(tags$strong("4. How SATISFIED/DISSATISFIED are you with your CURRENT sleep pattern?")),
                       radioButtons(ns("item_4"), label = NULL, choices = c("Very Satisfied"="0","Satisfied"="1","Moderately Satisfied"="2","Dissatisfied"="3","Very Dissatisfied" = "4"), inline = TRUE, selected = character(0)))
              ),
              hr(),
              fluidRow(
                column(width = 12,
                       h4(tags$strong("5. How NOTICEABLE to others do you think your sleep problem is in terms of impairing the quality of your life?")),
                       radioButtons(ns("item_5"), label = NULL, choices = c("Not at all Noticeable"="0","A Little"="1","Somewhat"="2","Much"="3","Very Much Noticeable" = "4"), inline = TRUE, selected = character(0)))
              ),
              hr(),
              fluidRow(
                column(width = 12,
                       h4(tags$strong("6. How WORRIED/DISTRESSED are you about your current sleep problem?")),
                       radioButtons(ns("item_6"), label = NULL, choices = c("Not at all Worried"="0","A Little"="1","Somewhat"="2","Much"="3","Very Much Noticeable" = "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 12,
                       h4(tags$strong("7. To what extent do you consider your sleep problem to INTERFERE with your daily functioning (e.g. daytime fatigue, mood, ability to function at work/daily chores, concentration, memory, mood, etc.) CURRENTLY?")),
                       radioButtons(ns("item_7"), label = NULL, choices = c("Not at all Interfering"="0","A Little"="1","Somewhat"="2","Much"="3","Very Much Interfering" = "4"), inline = TRUE, selected = character(0)))
              ),
              fluidRow(
                column(width = 12, h5("Source: Morin C. M. (1993). Insomnia: Psychological Assessment and Management. The Guilford Press: New York."))
              )
                ))

}

#' ISI Scale
#'
#' Generates the ISI for data entry
#'
#'@export
#'
isi_scale<- function(input, output, session) {

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, input$item_6, input$item_7, sep = ",") })

  return(scale_entry)

}

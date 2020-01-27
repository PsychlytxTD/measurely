#' GAD-7 Scale
#'
#' Generates the GAD-7 for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
gad7_scale_UI<- function(id) {

ns<- NS(id)

div(id = ns("reset_id"),

tagList(

fluidRow(
  column(width = 12, offset = 5, h3(tags$strong("GAD-7 ")))
),

fluidRow(
  column(width = 6, h4(tags$strong("Over the past 2 weeks, how often have you been bothered by the following problems?"))),
  column(width = 1, offset = 1, h5(tags$strong("Not at all"))),
  column(width = 1, h5(tags$strong("Several days"))),
  column(width = 1, h5(tags$strong("More than half the days"))),
  column(width = 1, h5(tags$strong("Nearly every day")))
),

fluidRow(
  column(width = 7, h4("1. Feeling nervous, anxious or on edge")),
  column(width = 5, checkboxGroupInput(ns("item_1"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = NULL))
),

fluidRow(
  column(width = 7, h4("2. Not being able to stop or control worrying")),
  column(width = 5, checkboxGroupInput(ns("item_2"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = NULL))
),

fluidRow(
  column(width = 7, h4("3. Worrying too much about different things")),
  column(width = 5, checkboxGroupInput(ns("item_3"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = NULL))
),

fluidRow(
  column(width = 7, h4("4. Trouble relaxing")),
  column(width = 5, checkboxGroupInput(ns("item_4"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = NULL))
),

fluidRow(
  column(width = 7, h4("5. Being so restless it is hard to sit still")),
  column(width = 5, checkboxGroupInput(ns("item_5"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = NULL))
),

fluidRow(
  column(width = 7, h4("6. Becoming easily annoyed or irritable")),
  column(width = 5, checkboxGroupInput(ns("item_6"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = NULL))
),

fluidRow(
  column(width = 7, h4("7. Feeling afraid as if something awful might happen")),
  column(width = 5, checkboxGroupInput(ns("item_7"), label = NULL, choices = c("0", "1", "2", "3"), inline = TRUE, selected = NULL))
),

fluidRow(
  column(width = 12, h5("Source: Spitzer, R. L., Kroenke, K., Williams, J. B., & Lowe, B. (2006). A brief measure for assessing Generalized Anxiety Disorder: the GAD-7. Archives of Internal Medicine, 166(10), 1092–1097."))
)


))

}

#' GAD-7 Scale
#'
#' Generates the GAD-7 for data entry
#'
#' @param selected_client A string indicating the unique id of the selected client.
#'
#' @param simplified A boolean value indicating whether scale is being inserted in the remote app.
#'
#' @export
#'
gad7_scale<- function(input, output, session, selected_client = NULL, simplified = FALSE) {

  #Need to refresh questionnaire with selection of new client from dropdown - but only for the parent app!

  if(isFALSE(simplified)) {

  observeEvent(selected_client(), {

    shinyjs::reset("reset_id")

  })

}

  observe({
             #Make a logical vector indicating whether a scale item had more than one response endorsed.

      item_too_long<- purrr::map_lgl(list(c(input$item_1), c(input$item_2), c(input$item_3), c(input$item_4),
                          c(input$item_5), c(input$item_6), c(input$item_7)), ~length(.x) > 1)

      #Generate a sweet alert as soon as more than one responsennisngiven for an item

      psychlytx::warn_too_many_responses(session, item_too_long)

  })

  #Return the values of all items in a string.

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3,
                                  input$item_4, input$item_5, input$item_6, input$item_7, sep = ",") })

  return(scale_entry)

}

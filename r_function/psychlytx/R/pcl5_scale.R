#' PCL-5 Scale
#'
#' Generates the PCL-5 for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
pcl5_scale_UI<- function(id) {

  ns<- NS(id)

  div(id = ns("reset_id"),

  tagList(

    br(),

    wellPanel(style = "background-color: #ffffff; color: black",
              fluidRow(
                column(width = 12, offset = 5, h3(tags$strong("PCL-5")))
              ),
              hr(),
              fluidRow(
                column(width = 6, h4(tags$strong("Over the past 2 weeks, how often have you been bothered by any of the following problems?"))),
                column(width = 1, h5(tags$strong("Not at all"))),
                column(width = 1, h5(tags$strong("A little bit"))),
                column(width = 1, h5(tags$strong("Moderately"))),
                column(width = 1, h5(tags$strong(HTML('&emsp;'),"Quite", HTML('&emsp;'), "a bit"))),
                column(width = 1, h5(tags$strong("Extremely")))
              ),

              fluidRow(
                column(width = 6, h4("1. Repeated, disturbing, and unwanted memories of the stressful experience?")),
                column(width = 6, checkboxGroupInput(ns("item_1"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("2. Repeated, disturbing dreams of the stressful experience?")),
                column(width = 6, checkboxGroupInput(ns("item_2"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("3. Suddenly feeling or acting as if the stressful experience were actually happening again (as if you were actually back there reliving it)?")),
                column(width = 6, checkboxGroupInput(ns("item_3"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("4. Feeling very upset when something reminded you of the stressful experience?")),
                column(width = 6, checkboxGroupInput(ns("item_4"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("5. Having strong physical reactions when something reminded you of the stressful experience (for example, heart pounding, trouble breathing, sweating)?")),
                column(width = 6, checkboxGroupInput(ns("item_5"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("6. Avoiding memories, thoughts, or feelings related to the stressful experience?")),
                column(width = 6, checkboxGroupInput(ns("item_6"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("7. Avoiding external reminders of the stressful experience (for example, people, places, conversations, activities, objects, or situations)?")),
                column(width = 6, checkboxGroupInput(ns("item_7"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("8. Trouble remembering important parts of the stressful experience?")),
                column(width = 6, checkboxGroupInput(ns("item_8"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("9. Having strong negative beliefs about yourself, other people, or the world (for example, having thoughts such as: I am bad, there is something seriously wrong with me, no one can be trusted, the world is completely dangerous)?")),
                column(width = 6, checkboxGroupInput(ns("item_9"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("10. Blaming yourself or someone else for the stressful experience or what happened after it?")),
                column(width = 6, checkboxGroupInput(ns("item_10"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("11. Having strong negative feelings such as fear, horror, anger, guilt, or shame?")),
                column(width = 6, checkboxGroupInput(ns("item_11"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("12. Loss of interest in activities that you used to enjoy?")),
                column(width = 6, checkboxGroupInput(ns("item_12"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("13. Feeling distant or cut of from other people?")),
                column(width = 6, checkboxGroupInput(ns("item_13"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("14. Trouble experiencing positive feelings (for example, being unable to feel happiness or have loving feelings for people close to you)?")),
                column(width = 6, checkboxGroupInput(ns("item_14"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("15. Irritable behavior, angry outbursts, or acting aggressively?")),
                column(width = 6, checkboxGroupInput(ns("item_15"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("16. Taking too many risks or doing things that could cause you harm?")),
                column(width = 6, checkboxGroupInput(ns("item_16"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("17. Being “superalert” or watchful or on guard?")),
                column(width = 6, checkboxGroupInput(ns("item_17"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("18. Feeling jumpy or easily startled?")),
                column(width = 6, checkboxGroupInput(ns("item_18"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("19. Having difculty concentrating?")),
                column(width = 6, checkboxGroupInput(ns("item_19"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 6, h4("20. Trouble falling or staying asleep?")),
                column(width = 6, checkboxGroupInput(ns("item_20"), label = NULL, choices = c("0", "1", "2", "3", "4"), inline = TRUE, selected = NULL))
              ),
              fluidRow(
                column(width = 12, h5("Scale Source: Weathers, Litz, Keane, Palmieri, Marx & Schnurr (2013)"))
              )
    )

  ))

}

#' PCL-5 Scale
#'
#' Generates the PCL-5 for data entry
#'
#' @param selected_client A string indicating the unique id of the selected client.
#'
#' @export
#'
pcl5_scale<- function(input, output, session, selected_client) {

  observeEvent(selected_client(), {

    shinyjs::reset("reset_id")

  })



  observe({
    #Make a logical vector indicating whether a scale item had more than one response endorsed.

    item_too_long<- purrr::map_lgl(list(c(input$item_1), c(input$item_2), c(input$item_3), c(input$item_4),
                                        c(input$item_5), c(input$item_6), c(input$item_7), c(input$item_8),
                                        c(input$item_9), c(input$item_10), c(input$item_11), c(input$item_12),
                                        c(input$item_13), c(input$item_14), c(input$item_15), c(input$item_16),
                                        c(input$item_17), c(input$item_18), c(input$item_19), c(input$item_20)), ~length(.x) > 1)

    #Generate a sweet alert as soon as more than one responsennisngiven for an item

    psychlytx::warn_too_many_responses(session, item_too_long)

  })

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5,
                                  input$item_6, input$item_7, input$item_8, input$item_8, input$item_10,
                                  input$item_11, input$item_12, input$item_13, input$item_14, input$item_15,
                                  input$item_16, input$item_17, input$item_18, input$item_19, input$item_20, sep = ",") })

  return(scale_entry)

}

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

  div(id = ns("reset_id"),

  tagList(

  wellPanel(
  fluidRow(
    column(width = 4, offset = 2, textInput(ns("drug_name"), h5(tags$strong("Drug name")), value = "alcohol", width = '400px')),
    column(width = 4, textInput(ns("drug_term"), h5(tags$strong("Word to describe use (smoke/snort/hit/etc.)")), value = "drink", width = '400px'))
  )),

 uiOutput(ns("sds_scale_out"))

  ))

}

#' SDS Scale
#'
#' Generates the SDS for data entry
#'
#' @param selected_client A string indicating the unique id of the selected client.
#'
#' @param simplified A boolean value indicating whether scale is being inserted in the remote app.
#'
#' @export
#'
sds_scale<- function(input, output, session, selected_client = NULL, simplified = FALSE) {

 output$sds_scale_out<- renderUI({

    ns <- session$ns

    div(id = ns("reset_id"),

    tagList(

    wellPanel(style = "background-color: #ffffff; color: black",
              br(),
              h3(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "Severity of Dependence Scale (SDS)")),
              hr(),
              div(h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "Circle the answer that best applies to how you have felt about your use of", input$drug_name, "over the last month."))),
              br(),
              fluidRow(div(h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "1. Did you ever think your use of", input$drug_name, "was out of control?")))),
              fluidRow(
                column(width = 3),
                column(width = 4,
                       h4("Never or almost never"),
                       h4("Sometimes"),
                       h4("Often"),
                       h4("Always or nearly always")
                ),
                column(width = 4,
                       checkboxGroupInput(ns("item_1"), label = NULL, choices = c("0", "1", "2", "3"), selected = NULL))), br(),

              fluidRow(div(h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "2. Did the prospect of missing a", input$drug_term, "make you very anxious or worried?")))),
              fluidRow(
                column(width = 3),
                column(width = 4,
                       h4("Never or almost never"),
                       h4("Sometimes"),
                       h4("Often"),
                       h4("Always or nearly always")
                ),
                column(width = 4,
                       checkboxGroupInput(ns("item_2"), label = NULL, choices = c("0", "1", "2", "3"), selected = NULL))), br(),

              fluidRow(div(h4(tags$strong(HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'),HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), HTML('&emsp;'), "3. Did you worry about your use of",input$drug_name,"?")))),
              fluidRow(
                column(width = 3),
                column(width = 4,
                       h4("Not at all"),
                       h4("A little"),
                       h4("Quite a lot"),
                       h4("A great deal")
                ),
                column(width = 4,
                       checkboxGroupInput(ns("item_3"), label = NULL, choices = c("0", "1", "2", "3"), selected = NULL))), br(),

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
                       checkboxGroupInput(ns("item_4"), label = NULL, choices = c("0", "1", "2", "3"), selected = NULL))), br(),

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
                       checkboxGroupInput(ns("item_5"), label = NULL, choices = c("0", "1", "2", "3"), selected = NULL))),

              fluidRow(
                column(width = 12, h5("Source: Gossop M, Darke S, Griffiths P, Hando J., Powis B., Hall W, Strang J (1995). The Severity of Dependence Scale (SDS): psychometric properties of the SDS in English and Australian samples of heroin, cocaine and amphetamine users. Addiction, 90(5):607-14."))
              )


    )))


  })


 if(isFALSE(simplified)) {

   observeEvent(selected_client(), {

     shinyjs::reset("reset_id")

   })

 }


 observe({
   #Make a logical vector indicating whether a scale item had more than one response endorsed.

   item_too_long<- purrr::map_lgl(list(c(input$item_1), c(input$item_2), c(input$item_3), c(input$item_4),
                                       c(input$item_5)), ~length(.x) > 1)

   #Generate a sweet alert as soon as more than one responsennisngiven for an item

   psychlytx::warn_too_many_responses(session, item_too_long)

 })




  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, sep = ",") })

  return(scale_entry)

}

#' Test-Retest Reliability Derivation
#'
#' Calculates test-retest reliability from T- or F-statistic
#'
#' @param id String to create a unique namespace.
#'
#' @export


reliability_calc_UI <- function(id) {
  ns <- NS(id)

  tagList(

    checkboxInput(ns("derive_reliability"), tags$strong("Calculate the test-retest reliability value from research statistics"), width = '100%'),

    conditionalPanel(paste0("input['", ns("derive_reliability"), "'] == 1 "), #If checkbox is selected, show widgets to drive rest-retest reliability

        tagList(

        h5("Enter values below"),
        fluidRow(
          column(width = 2,
                 numericInput(ns("calc_mean"), "Initial Mean", value = "")
          ),
          column(width = 2,
                 numericInput(ns("calc_sd"), "Initial Sd", value = "")
          ),
          column(width = 2,
                 numericInput(ns("calc_retest_mean"), "Retest Mean", value = "")
          ),
          column(width = 2,
                 numericInput(ns("calc_retest_sd"), "Retest Sd", value = "")
          ),
          column(width = 2,
                 numericInput(ns("calc_n"), "Sample Size", value = "")
          )),

        radioButtons(ns("reliability_stat"), "Choose a statistic from which to calculate test-retest reliability", choices = c("T-Value", "F-Value"), width = '100%'),

        fluidRow(
          conditionalPanel(paste0("input['", ns("reliability_stat"), "'] == 'T-Value' "),
                           column(width = 2,
                                  numericInput(ns("calc_t"), "T-Value", value = "")
                           )
          ),
          conditionalPanel(paste0("input['", ns("reliability_stat"), "'] == 'F-Value' "),
                           column(width = 2,
                                  numericInput(ns("calc_f"), "F-Value", value = "")
                           )
          )
        ),

        fluidRow(
          column(width = 3,
                 actionButton(ns("trigger_reliability_calc"), "Calculate")
          )
        ),

        fluidRow(
          column(width = 8,
                 h4(tags$strong(verbatimTextOutput(ns("derived_reliability_out")))),
                 h6("*Once calculated, enter this value in the field for test-retest reliability above.")
          )
        )
      )
  )
)

    }




#' Test-Retest Reliability Derivation
#'
#' Calculates test-retest reliability from T- or F-statistic
#'
#' @export


reliability_calc<- function(input, output, session) {


  derived_reliability_reac<- eventReactive(input$trigger_reliability_calc, {

    ns <- session$ns

  if(input$reliability_stat == "T-Value") {

    t_rel(calc_sd = input$calc_sd, calc_retest_sd = input$calc_retest_sd, calc_mean = input$calc_mean, calc_retest_mean = input$calc_retest_mean,
          calc_t = input$calc_t, calc_n = input$calc_n)

  } else if(input$reliability_stat == "F-Value") {

    t_rel(calc_sd = input$calc_sd, calc_retest_sd = input$calc_retest_sd, calc_mean = input$calc_mean, calc_retest_mean = input$calc_retest_mean,
          calc_f = input$calc_f, calc_n = input$calc_n)

  }

  })


  output$derived_reliability_out<- renderText({

    derived_reliability_reac()

  })


}

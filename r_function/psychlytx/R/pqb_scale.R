#' PQ-B Scale
#'
#' Generates the PQ-B for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
pqb_scale_UI<- function(id) {

  ns<- NS(id)

  tagList(

    wellPanel(style = "background-color: #ededed; color: black",
              h3(tags$strong("PQ-B")),
              fluidRow(
                column(width = 12, div(h4("Please indicate whether you have had the following thoughts, feelings and experiences", tags$strong("in the past month"), "by
                                          checking “yes” or “no” for each item.", tags$strong("Do not include experiences that occur only while under the influence of
                                                                                              alcohol, drugs or medications that were not prescribed to you."), "If you answer “YES” to an item, also indicate how
                                          distressing that experience has been for you.")))
                ),

              h4(tags$strong("1. Do familiar surroundings sometimes seem strange, confusing, threatening or unreal to you?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_1"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_22"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE))
              ), br(),
              h4(tags$strong("2. Have you heard unusual sounds like banging, clicking, hissing, clapping or ringing in your ears?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_2"), "", choices = c("YES" = "1", "NO" = "0"),  inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_23"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("3. Do things that you see appear different from the way they usually do (brighter or duller, larger or smaller, or changed in some other way)?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_3"), "", choices = c("YES" = "1", "NO" = "0"),  inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_24"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("4. Have you had experiences with telepathy, psychic forces, or fortune telling?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_4"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_25"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("5. Have you felt that you are not in control of your own ideas or thoughts?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_5"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_26"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("6. Do you have difficulty getting your point across, because you ramble or go off the track a lot when you talk?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_6"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_27"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("7. Do you have strong feelings or beliefs about being unusually gifted or talented in some way?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_7"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_28"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("8. Do you feel that other people are watching you or talking about you?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_8"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_29"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("9. Do you sometimes get strange feelings on or just beneath your skin, like bugs crawling?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_9"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_30"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("10. Do you sometimes feel suddenly distracted by distant sounds that you are not normally aware of?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_10"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_31"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("11. Have you had the sense that some person or force is around you, although you couldn’t see anyone?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_11"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_32"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("12. Do you worry at times that something may be wrong with your mind?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_12"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_33"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("13. Have you ever felt that you don't exist, the world does not exist, or that you are dead?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_13"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_34"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("14. Have you been confused at times whether something you experienced was real or imaginary?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_14"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_35"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("15. Do you hold beliefs that other people would find unusual or bizarre?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_15"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_36"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("16. Do you feel that parts of your body have changed in some way, or that parts of your body are working differently?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_16"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_37"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("17. Are your thoughts sometimes so strong that you can almost hear them?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_17"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_38"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("18. Do you find yourself feeling mistrustful or suspicious of other people?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_18"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_39"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("19. Have you seen unusual things like flashes, flames, blinding light, or geometric figures?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_19"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_40"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("20. Have you seen things that other people can't see or don't seem to see?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_20"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput("item_41", "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ), br(),
              h4(tags$strong("21. Do people sometimes find it hard to understand what you are saying?")),
              fluidRow(
                column(width = 2, checkboxGroupInput(ns("item_21"), "", choices = c("YES" = "1", "NO" = "0"), inline = TRUE)),
                column(width = 10, br(), div(h4(tags$strong("If YES:"), "When this happens, I feel frightened, concerned, or it causes problems for me:")),
                       checkboxGroupInput(ns("item_42"), "", choices = c("Strongly disagree" = "1", "disagree" = "2", "neutral" = "3", "agree" = "4", "strongly agree" = "5"), inline = TRUE, selected = character(0)))
              ),

              fluidRow(
                column(width = 12, h5("Source: Loewy, RL & Cannon, TD. (2010). The Prodromal Questionnaire, Brief Version (PQ-B). University of California."))
              )

))

}

#' PQ-B Scale
#'
#' Generates the PQ-B for data entry
#'
#'@export
#'
pqb_scale<- function(input, output, session) {

  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5, input$item_6, input$item_7,
                                  input$item_8, input$item_9, input$item_10, input$item_11, input$item_12, input$item_13, input$item_14,
                                  input$item_15, input$item_16, input$item_17, input$item_18, input$item_19, input$item_20, input$item_21,
                                  input$item_22, input$item_23, input$item_24, input$item_25, input$item_26, input$item_27, input$item_28,
                                  input$item_29, input$item_30, input$item_31, input$item_32, input$item_33, input$item_34, input$item_35,
                                  input$item_36, input$item_37, input$item_38, input$item_39, input$item_40, input$item_41, input$item_42, sep = ",") })

  return(scale_entry)

}

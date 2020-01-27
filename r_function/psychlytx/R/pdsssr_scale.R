#' PDSS-SR Scale
#'
#' Generates the PDSS-SR for data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export
#'
pdsssr_scale_UI<- function(id) {

  ns<- NS(id)

  tagList(

    br(),

    wellPanel(style = "background-color: #ffffff; color: black",
              fluidRow(
                column(width = 12, offset = 5, h3(tags$strong(HTML('&emsp;'), "PDSS-SR")))
              ),
              hr(),
              fluidRow(
                column(width = 12, div(h4("Several of the following questions refer to panic attacks and limited symptom attacks.
                                          For this questionnaire we define a panic attack as a", tags$strong("sudden rush"), "of fear or discomfort accompanied", tags$strong("by at
                                                                                                                                                                              least 4 of the symptoms listed below."), "In order to qualify as a sudden rush, the symptoms must peak within
                                          10 minutes. Episodes like panic attacks but having fewer than 4 of the listed symptoms are called limited
                                          symptom attacks. Here are the symptoms to count:")))
                ),
              fluidRow(
                column(width = 4,
                       tags$ul(
                         tags$li(h4("Rapid or pounding heartbeat")),
                         tags$li(h4("Sweating")),
                         tags$li(h4("Trembling or shaking")),
                         tags$li(h4("Breathlessness")),
                         tags$li(h4("Fear of choking"))
                       )),
                column(width = 4,
                       tags$ul(
                         tags$li(h4("Chest pain or discomfort")),
                         tags$li(h4("Nausea")),
                         tags$li(h4("Dizziness or faintness")),
                         tags$li(h4("Feelings of unreality")),
                         tags$li(h4("Numbness or tingling"))
                       )),
                column(width = 4,
                       tags$ul(
                         tags$li(h4("Chills or hot flushes")),
                         tags$li(h4("Fear of losing control or going crazy")),
                         tags$li(h4("Fear of dying"))
                       ))
              ),
              hr(),

              fluidRow(
                column(width = 12, h4("1. How many panic and limited symptoms attacks did you have during the week?"))
              ),
              fluidRow(
                column(width = 12, checkboxGroupInput(ns("item_1"), label = NULL, choices = c("0. No panic or limited symptom episodes" = "0",
                                                                                       "1. Mild: no full panic attacks and no more than 1 limited symptom attack/day" = "1",
                                                                                       "2. Moderate: 1 or 2 full panic attacks and/or multiple limited symptom attacks/day" = "2",
                                                                                       "3. Severe: more than 2 full attacks but not more than 1/day on average" = "3",
                                                                                       "4. Extreme: full panic attacks occurred more than once a day, more days than not" = "4"), selected = NULL))
              ),

              fluidRow(
                column(width = 12, div(h4("2. If you had any panic attacks during the past week, how distressing (uncomfortable, frightening) were they", tags$strong("while
                                                                                                                                                                      they were happening?"), "(If you had more than one, give an average rating. If you didn’t have any panic attacks but
                                          did have limited symptom attacks, answer for the limited symptom attacks.)")))
                ),
              fluidRow(
                column(width = 12, checkboxGroupInput(ns("item_2"), label = NULL, choices = c("0. Not at all distressing, or no panic or limited symptom attacks during the past week" = "0",
                                                                                       "1. Mildly distressing (not too intense)" = "1",
                                                                                       "2. Moderately distressing (intense, but still manageable)" = "2",
                                                                                       "3. Severely distressing (very intense)" = "3",
                                                                                       "4. Extremely distressing (extreme distress during all attacks)" = "4"), selected = NULL))
               ),

              fluidRow(
                column(width = 12, div(h4("3. During the past week, how much have you worried or felt anxious", tags$strong("about when your next panic attack would occur
                                                                                                                            or about fears related to the attacks"), "(for example, that they could mean you have physical or mental health problems
                                          or could cause you social embarrassment)?")))
                ),
              fluidRow(
                column(width = 12, checkboxGroupInput(ns("item_3"), label = NULL, choices = c("0. Not at all" = "0",
                                                                                       "1. Occasionally or only mildly" = "1",
                                                                                       "2. Frequently or moderately" = "2",
                                                                                       "3. Very often or to a very disturbing degree" = "3",
                                                                                       "4. Nearly constantly and to a disabling extent" = "4"), selected = NULL))
               ),

              fluidRow(
                column(width = 12, div(h4("4. During the past week were there any", tags$strong("places or situations"), "(e.g., public transportation, movie theaters, crowds, bridges,
                                          tunnels, shopping malls, being alone) you avoided, or felt afraid of (uncomfortable in, wanted to avoid or leave),", tags$strong("because
                                                                                                                                                                           of fear of having a panic attack?"), "Are there any other situations that you would have avoided or been afraid of if they had
                                          come up during the week, for the same reason? If yes to either question, please rate your level of fear and avoidance this past week.")))
                ),
              fluidRow(
                column(width = 12, checkboxGroupInput(ns("item_4"), label = NULL,
                                                     choices = c("0. None: no fear or avoidance" = "0",
                                                                  "1. Mild: occasional fear and/or avoidance but I could usually confront or endure the situation. There was little or no modification of my
                                      lifestyle due to this." = "1",
                                                                 "2. Moderate: noticeable fear and/or avoidance but still manageable. I avoided some situations, but I could confront them with a companion. There was some modification of my lifestyle because of this, but my
                                                                 overall functioning was not impaired." = "2",
                                                                 "3. Severe: extensive avoidance. Substantial modification of my lifestyle was required to accommodate the
                                      avoidance making it difficult to manage usual activities." = "3",
                                                                 "4. Extreme: pervasive disabling fear and/or avoidance. Extensive modification in my lifestyle was required
                                      such that important tasks were not performed." = "4"), selected = NULL))

              ),

              fluidRow(
                column(width = 12, div(h4("5. During the past week, were there any", tags$strong("activities"), "(e.g., physical exertion, sexual relations, taking a hot shower or bath,
                                          drinking coffee, watching an exciting or scary movie) that you avoided, or felt afraid of (uncomfortable doing, wanted to avoid
                                          or stop)", tags$strong("because they caused physical sensations like those you feel during panic attacks or that you were afraid might trigger
                                                                 a panic attack?"), "Are there any other activities that you would have avoided or been afraid of if they had come up during the week
                                          for that reason? If yes to either question, please rate your level of fear and avoidance of those activities this past week.")))
                ),
              fluidRow(
                column(width = 12, checkboxGroupInput(ns("item_5"), label = NULL,
                                               choices = c("0. No fear or avoidance of situations or activities because of distressing physical sensations" = "0",
                                                           "1. Mild: occasional fear and/or avoidance, but usually I could confront or endure with little distress activities
                                      that cause physical sensations. There was little modification of my lifestyle due to this" = "1",
                                                           "2. Moderate: noticeable avoidance but still manageable. There was definite, but limited, modification of my
                                      lifestyle such that my overall functioning was not impaired." = "2",
                                                           "3. Severe: extensive avoidance. There was substantial modification of my lifestyle or interference in my
                                      functioning." = "3",
                                                           "4. Extreme: pervasive and disabling avoidance. There was extensive modification in my lifestyle due to this
                                      such that important tasks or activities were not performed." = "4"), selected = NULL))

              ),

              fluidRow(
                column(width = 12, div(h4("6. During the past week, how much did the above symptoms altogether (panic and limited symptom attacks, worry
                                          about attacks, and fear of situations and activities because of attacks) interfere with your", tags$strong("ability to work or
                                                                                                                                                     carry out your responsibilities at home?"), "(If your work or home responsibilities were less than usual this past week,
                                          answer how you think you would have done if the responsibilities had been usual.)")))
                ),
              fluidRow(
                column(width = 12, checkboxGroupInput(ns("item_6"), label = NULL,
                                                     choices = c("0. No interference with work or home responsibilities" = "0",
                                                                 "1. Slight interference with work or home responsibilities, but I could do nearly everything I could if I didn’t
                                      have these problems." = "1",
                                                                 "2. Significant interference with work or home responsibilities, but I still could manage to do the things I
                                      needed to do." = "2",
                                                                 "3. Substantial impairment in work or home responsibilities; there were many important things I couldn’t do
because of these problems." = "3",
                                                                 "4. Extreme, incapacitating impairment such that I was essentially unable to manage any work or home
responsibilities." = "4"

                                                                 ), selected = NULL))
              ),

              fluidRow(
                column(width = 12, div(h4("7. During the past week, how much did panic and limited symptom attacks, worry about attacks and fear of situations and
                                          activities because of attacks interfere with your", tags$strong("social life?"), "(If you didn’t have many opportunities to socialize this past
                                          week, answer how you think you would have done if you did have opportunities.)")))
                ),
              fluidRow(
                column(width = 12, checkboxGroupInput(ns("item_7"), label = NULL, choices = c("0. No interference" = "0",
                                                                                              "1. Slight interference with social activities, but I could do nearly everything I could if I didn’t have these
                                      problems." = "1",
                                                                                              "2. Significant interference with social activities but I could manage to do most things if I made the effort." = "2",
                                                                                              "3. Substantial impairment in social activities; there are many social things I couldn’t do because of these
                                      problems." = "3",
                                                                                              "4. Extreme, incapacitating impairment, such that there was hardly anything social I could do." = "4"

                                                                                              ), selected = NULL))
              ),

              fluidRow(
                column(width = 12, h5("Source: Shear, Brown, Barlow, Money, Sholomskas et al. (1997)"))
              ))

              )

}

#' PDSS-SR Scale
#'
#' Generates the PDSS-SR for data entry
#'
#' @param selected_client A string indicating the unique id of the selected client.
#'
#' @param simplified A boolean value indicating whether scale is being inserted in the remote app.
#'
#' @export
#'
pdsssr_scale<- function(input, output, session, selected_client = NULL, simplified = FALSE) {

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


  scale_entry <- reactive({ paste(input$item_1, input$item_2, input$item_3, input$item_4, input$item_5,
                                  input$item_6, input$item_7, sep = ",") })

  return(scale_entry)

}

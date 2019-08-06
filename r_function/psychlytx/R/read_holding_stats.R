#' Simplified Application Statistics Read-In
#'
#' Read in required statistics from holding table in DB, to be used when client completes simplified application measure.
#'
#' @param id A string to create the namespace.
#'
#' @export
#'

read_holding_stats_UI<- function(id) {

  ns <- NS(id)

  tagList(

  fluidPage(

  fluidRow(

  column(width = 6,

  textInput(ns("client_id"), h3("Please sign in with your Psychlytx key."), width = '100%') %>% helper( type = "inline", title = "What is my Psychlytx key?", colour = "#d35400",
  content = c("You can find your unique Psychlytx key in the email that you received from your clinician. The key contains both letters and numbers."), size = "m"

  ))),

  fluidRow(

  column(width = 3,

  actionButton(ns("submit_key"), "Sign In")

  )),

  fluidRow(
    column(width = 12, h3(tags$strong("After signing in, please complete the questionnaire.")))
  )


  ))

}


#' Simplified Application Statistics Read-In
#'
#' Read in required statistics from holding table in DB, to be used when client completes simplified application measure.
#'
#' @param pool A pooled db object.
#'
#' @param measure A string indiating name of the measure.
#'
#' @param tabsetpanel_id A string to allow automated switch from sign-in tabpanel to questionnaire tabpanel.
#'
#' @export
#'

read_holding_stats<- function(input, output, session, pool, measure, tabsetpanel_id = "tabset") {

  parent_session <- get("session", envir = parent.frame(2))

  holding_statistics<- eventReactive(input$submit_key, { #Pull in the selected client's data (for this measure only) from the db.

    holding_stats_client_sql<- "SELECT h.*, c.first_name, c.last_name
    FROM holding h
    LEFT JOIN client c
    ON h.client_id = c.id
    WHERE h.client_id = ?client_id AND h.measure = ?measure;"

    holding_stats_client_query<- sqlInterpolate(pool, holding_stats_client_sql, client_id = input$client_id, measure = measure)

    dbGetQuery(pool, holding_stats_client_query)

  })


  observeEvent(input$submit_key, {


    if(length(holding_statistics()) >= 1) { #If client id matches on id in holding table send welcome message modal to client.


    sendSweetAlert(
      session = session,
      title = paste("Welcome", holding_statistics()$first_name, "!!"),
      text = "Please complete the questionnaire below then click 'submit'.",
      type = "success"
    )


      updateTabsetPanel(session = parent_session, tabsetpanel_id,  #Direct user automatically to questionnaire tab upon button click.
                        selected = paste("go_questionnaire"))

    } else {

      sendSweetAlert(             #If client id does not match on id in holding table send error message.
        session = session,
        title = "Key Not Recognised!",
        text = "Re-copy and paste the Psychlytx key that you received in the email from your clinician.",
        type = "error"
      )

    }


    })



  reactive({ holding_statistics() }) #Return the statistics to be used downstream in score processing.

}






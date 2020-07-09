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

  h3("Please complete the outcome measure.", class = "headings")

  ))

}


#' Simplified Application Statistics Read-In
#'
#' Read in required statistics from holding table in DB, to be used when client completes simplified application measure.
#'
#' @param pool A pooled db object.
#'
#' @param measure A string indicating name of the measure.
#'
#' @param client_id A unique string representing client it.
#'
#' @param start_button_input  A reactive value containing value of start_button action button.
#'
#' @export
#'

read_holding_stats<- function(input, output, session, pool, measure, client_id, start_button_input) {

  #parent_session <- get("session", envir = parent.frame(2))

  holding_statistics<- reactive({ #Pull in the selected client's data (for this measure only) from the db.

    holding_stats_client_sql<- "SELECT h.*, c.first_name, c.last_name
    FROM holding h
    LEFT JOIN client c
    ON h.client_id = c.id
    WHERE h.client_id = ?client_id AND h.measure = ?measure;"

    holding_stats_client_query<- sqlInterpolate(pool, holding_stats_client_sql, client_id = client_id, measure = measure)

    dbGetQuery(pool, holding_stats_client_query)

  })


  observeEvent(start_button_input(), {

    req(holding_statistics())

    if(nrow(holding_statistics()) >= 1) { #If client id matches on id in holding table send welcome message modal to client.


    sendSweetAlert(
      session = session,
      title = paste("Welcome", holding_statistics()$first_name[length(holding_statistics()$first_name)], "!"),
      text = "",
      type = "success"
    )

    } else {

      sendSweetAlert(             #If client id does not match on id in holding table send error message.
        session = session,
        title = "We're having trouble identifying you.",
        text = "Please contact your clinician for help.",
        type = "error"
      )

    }


    })



  reactive({ holding_statistics() }) #Return the statistics to be used downstream in score processing.

}






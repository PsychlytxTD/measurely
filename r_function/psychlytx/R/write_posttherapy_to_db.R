#' Write post-therapy analytics
#'
#' Write post-therapy analytics data to the db
#'
#' @param id A string to create the namespace
#'
#' @export

write_posttherapy_to_db_UI<- function(id) {

  ns<- NS(id)

  return(NULL)

}


#' Write post-therapy analytics
#'
#' Write post-therapy analytics data to the db
#'
#' @param pool A pooled db connection.
#'
#' @param analytics_posttherapy A dataframe containing post-therapy analytics data.
#'
#' @export



write_posttherapy_to_db<- function(input, output, session, pool, analytics_posttherapy) {

  observe({

    #pass the analytics dataframe in and append the client table in db

    dbWriteTable(pool, "posttherapy_analytics",  data.frame(analytics_posttherapy()), row.names = FALSE, append = TRUE) ;
    sendSweetAlert(
      session = session,
      title = "Successful Completion!!",
      text = "End-of-therapy outcome data has been submitted.",
      type = "success"
    )

  })


}

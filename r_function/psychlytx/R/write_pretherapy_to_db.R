#' Write pre-therapy analytics
#'
#' Write pre-therapy analytics data to the db
#'
#' @param id A string to create the namespace
#'
#' @export

write_pretherapy_analytics_to_db_UI<- function(id) {

  return(NULL)

}



#' Write pre-therapy analytics
#'
#' Write pre-therapy analytics data to the db
#'
#' @param pool A pooled db connection
#'
#' @param analytics_pretherapy A dataframe containing the pretherapy data to send to the db
#'
#' @export


write_pretherapy_analytics_to_db<- function(input, output, session, pool, analytics_pretherapy) {


  observe({

    client_check_sql<- "SELECT *
    FROM client
    WHERE first_name = ?inputted_first_name AND last_name = ?inputted_last_name AND birth_date = ?inputted_birth_date;"

    client_check_query<- sqlInterpolate(pool, client_check_sql, inputted_first_name = analytics_pretherapy()$first_name,
                                        inputted_last_name = analytics_pretherapy()$last_name, inputted_birth_date = analytics_pretherapy()$birth_date)

    client_check_data<- dbGetQuery(pool, client_check_query)

    if(length(client_check_data) == 0) {

      #pass the pretherapy analytics dataframe in and append the client table in db
      dbWriteTable(pool, "client",  data.frame(analytics_pretherapy()), row.names = FALSE, append = TRUE) ;
      sendSweetAlert(
        session = session,
        title = "Registration Successful!!",
        text = "Your client is signed up to use Measurely web applications.",
        type = "success"
      )

    } else(

           sendSweetAlert(
             session = session,
             title = "Registration Problem!!",
             text = "An entry already exists for this client. Please check the client details you have inputted and resubmit.",
             type = "error"
           )

           ) #Client registration details cannot be written to db ifan identical entry has already been created

  })






}

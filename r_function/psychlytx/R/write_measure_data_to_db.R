#' Write client's measure data to db
#'
#' Write the client's new scores and associated statistics to the db
#'
#' @param id A string to create the namespace
#'
#' @export

write_measure_data_to_db_UI<- function(id) {

  return(NULL)

}




#' Write client's measure data to db
#'
#' Write the client's new scores and associated statistics to the db
#'
#' @param pool A pooled db connection
#'
#' @param measure_data A dataframe indicating the dataframe to send to the db
#'
#' @param manual_entry A list of values returned when clinician submits new scale responses. Of list items, only accessing the button value, to trigger the query.
#'
#' @export




write_measure_data_to_db<- function(input, ouput, session, pool, measure_data, manual_entry, formatted_response_body_for_email) {

  #We pass in the value of the submit scores button, so that when this button is clicked, the code below is triggered.

  observeEvent(manual_entry()$submit_scores_button_value, {


    sendSweetAlert(             #Modal popup showing client that their responses have been submitted.
      session = session,
      title = "Success!!",
      text = "Questionnaire responses have been submitted.",
      type = "success"
    )

    #Write the measure data (from this entry) to the scale table in the db.

    dbWriteTable(pool, "scale",  data.frame(measure_data()), row.names = FALSE, append = TRUE)


    #Wrangle item-level data to be sent to the item table in the db.

      items<- as.list( manual_entry()$item_scores)
      item_names<- c(paste("item", "_", 1:length(items), sep = "")) #create labels for each item, corresponding to the column names in item table (item_1, item_2, etc.)
      named_items<- items %>% purrr::set_names(item_names)
      item_data<- list( date = manual_entry()$date, item_id = measure_data()$scale_id[1], measure = measure_data()$measure[1], clinician_id = measure_data()$clinician_id,
                        client_id = measure_data()$client_id, named_items ) %>% purrr::flatten()

      dbWriteTable(pool, "item",  as.data.frame(item_data), row.names = FALSE, append = TRUE) #Write the item-level responses to the item table.


#Trying to send email with responses below



      url <- c("https://api.sendgrid.com/v3/mail/send")

      headers = c(
        `Authorization` = "bearer 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",
        `Content-Type` = "application/json"
      )

      #Need to replace tim@effectivepsych.com.au with the clinician’s email address: environment variable pulled from Autho
      #Need to replace psychlytx@gmail.com with the real psychlytx email address.


      body = formatted_response_body_for_email()



result <- httr::POST(url,                     #Send the email
                    add_headers(headers),
                    body = body,
                    encode="json",
                    verbose())






  })


observe({ print( formatted_response_body_for_email() )})


}

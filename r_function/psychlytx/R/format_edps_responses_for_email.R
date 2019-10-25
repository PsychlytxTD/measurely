#' Convert EDPS Measure Responses
#'
#' Convert EDPS raw measure responses into a readable table, to be send in an email to the clinician.
#'
#' @param id A string to create the namespace
#'
#' @export


format_edps_responses_for_email_UI<- function(id) {

  ns<- NS(id)

  return(NULL)
}


#' Convert EDPS Measure Responses
#'
#' Convert EDPS raw measure responses into a readable table, to be send in an email to the clinician.
#'
#' @param pool A pool db connection object
#'
#' @param manual_entry A list of raw item scores and the date of measure completion.
#'
#' @param measure_data A list of values returned when clinician submits new scale responses. Of list items, only accessing the button value, to trigger the query.
#'
#'
#' @param simplified A logical value indicating how the clinician_email string should be parsed (i.e. from being  reactive value or regular string).
#' @export

format_edps_responses_for_email<- function(input, output, session, pool, clinician_email, manual_entry, measure_data, simplified = FALSE) {

  reactive({

    formatted_item_responses<- purrr::map_at(manual_entry()$item_scores, 1, ~ {

      if(.x == 0) { "As much as I always could"}
      else if(.x == 1) {"Not quite as much now"}
      else if(.x == 2) {"Definietly not so much now"}
      else {"Not at all"}

    }) %>% purrr::map_at(2, ~ {

      if(.x == 0) { "As much as I ever did"}
      else if(.x == 1) {"Rather less than I used to"}
      else if(.x == 2) {"Definietly less than I used to"}
      else {"Hardly at all"}

    }) %>% purrr::map_at(3, ~ {

      if(.x == 0) { "No, never"}
      else if(.x == 1) {"Not very often"}
      else if(.x == 2) {"Yes, some of the time"}
      else {"Yes, most of the time"}

    })  %>% purrr::map_at(4, ~ {

      if(.x == 0) { "No, not at all"}
      else if(.x == 1) {"Hardly ever"}
      else if(.x == 2) {"Yes, sometimes"}
      else {"Yes, very often"}

    }) %>% purrr::map_at(5, ~ {

      if(.x == 0) { "No, not at all"}
      else if(.x == 1) {"No, not much"}
      else if(.x == 2) {"Yes, sometimes"}
      else {"Yes, quite a lot"}

    })  %>% purrr::map_at(6, ~ {

      if(.x == 0) { "No, I have been coping as well as ever"}
      else if(.x == 1) {"No, most of the time I have coped quite well"}
      else if(.x == 2) {"Yes, sometimes I haven't been coping as well as usual"}
      else {"Yes, most of the time I haven't been able to cope at all"}

    }) %>% purrr::map_at(7, ~ {

      if(.x == 0) { "No, not at all"}
      else if(.x == 1) {"No, not very often"}
      else if(.x == 2) {"Yes, sometimes"}
      else {"Yes, most of the time"}

    }) %>% purrr::map_at(8, ~ {

      if(.x == 0) { "No, not at all"}
      else if(.x == 1) {"Not very often"}
      else if(.x == 2) {"Yes, quite often"}
      else {"Yes, most of the time"}

    }) %>% purrr::map_at(9, ~ {

      if(.x == 0) { "No, never"}
      else if(.x == 1) {"Only occasionally"}
      else if(.x == 2) {"Yes, quite often"}
      else {"Yes, most of the time"}

    }) %>% purrr::map_at(10, ~ {

      if(.x == 0) { "Never"}
      else if(.x == 1) {"Hardly ever"}
      else if(.x == 2) {"Sometimes"}
      else {"Yes, quite often"}

    }) %>% unlist()


    #Need to retrieve client's name for the email          #For this measure, include sex to enable correct cutoff selection

    client_name_sql<- "SELECT first_name, last_name, sex
    FROM client
    WHERE id = ?client_id;"

    client_name_query<- sqlInterpolate(pool, client_name_sql, client_id = measure_data()$client_id)

    client_name<- dbGetQuery( pool, client_name_query )

    client_sex<- client_name$sex    #Retrieve sex of the client for correct cutoff selection (needed for this measure)

    client_name<- paste(client_name[1:2], collapse = " ") #Don't include sex in dropdown names



    #If the measure does not have established cutoffs, use the function below to create the vector of scores and severity range descriptions.
    #Otherwise, if there are widely recognised cutoffs, just use those cutoffs for the email, using a custom function like the one just below.
    #May be cases where we use a custom method for one subscale (e.g. PCL-5 total scale) but use the find_severity_range() function to generate
    #the severity range descriptions for the other subscales. In that case, would need to pass subsetted measure_data into the function
    #and would need to join that function output with the output produced by the custom method.

    #measure_data<- measure_data()
    #score_severity_range<- psychlytx::find_severity_range(measure_data) #use the find_severity_range() function to make a single vector of strings
    #containing (in order) the scores and the severity range descriptions.

    if(client_sex == "Female") {    #Basic cutoffs to appear in email, dependent on gender of client.

    severity_range<- dplyr::case_when(

      measure_data()$score >= 13  ~ "Depression",

      TRUE ~ as.character(measure_data()$score)

    ) } else {

      severity_range<- dplyr::case_when(

        measure_data()$score >= 10  ~ "Depression",

        TRUE ~ as.character(measure_data()$score)

      )


    }



    if(simplified == TRUE) {

      clinician_email<- clinician_email$value

    } else {

      clinician_email<- clinician_email

    }



    score_severity_range<- c(measure_data()$score, severity_range)


    body_values<- c(clinician_email, client_name, score_severity_range, formatted_item_responses) #Join the previous score/severity range description strings with the item responses to make one vector.


    #Need to replage "to:" field with clinician's email address, pulled from Autho

    body<- do.call(sprintf, c(list('{"from": {"email":"measurely@psychlytx.com","name":"Measurely"},
                                   "personalizations": [{"to": [{"email":"%s"}],
                                   "dynamic_template_data":{
                                   "header":"Your client, %s, has completed a measure.",

                                   "score": "%s",
                                   "severity_range": "%s",

                                   "response_1":"%s",
                                   "response_2":"%s",
                                   "response_3":"%s",
                                   "response_4":"%s",
                                   "response_5":"%s",
                                   "response_6":"%s",
                                   "response_7":"%s",
                                   "response_8":"%s",
                                   "response_9":"%s",
                                   "response_10":"%s",

                                   "content": "text/html",
                                   "c2a_button":"Download Full Clinical Report",
                                   "c2a_link":"http://www.psychlytx.com"}}],
                                   "template_id":"d-62888edce1ae4c789543e955a8990832"}'), body_values)) #Pass in the vector of strings to replace placeholders in order.

    return(body)


  })

}

#' Convert GAD-7 Measure Responses
#'
#' Convert GAD-7 raw measure responses into a readable table, to be send in an email to the clinician.
#'
#' @param id A string to create the namespace
#'
#' @export


format_gad7_responses_for_email_UI<- function(id) {

  ns<- NS(id)

  return(NULL)
}


#' Convert GAD-7 Measure Responses
#'
#' Convert GAD-7 raw measure responses into a readable table, to be send in an email to the clinician.
#'
#' @param pool A pool db connection object
#'
#' @param manual_entry A list of raw item scores and the date of measure completion.
#'
#' @param measure_data A list of values returned when clinician submits new scale responses. Of list items, only accessing the button value, to trigger the query.
#'
#' @export

format_gad7_responses_for_email<- function(input, output, session, pool, manual_entry, measure_data) {

  reactive({

  formatted_item_responses<- dplyr::case_when( #Convert the client's responses from numerical form to readable responses, teo appear in the email.

   manual_entry()$item_scores == 0 ~ "Not at all",

   manual_entry()$item_scores == 1 ~ "Several days",

   manual_entry()$item_scores == 2 ~ "More than half the days",

   manual_entry()$item_scores == 3 ~ "Nearly every day",

   TRUE ~ as.character(manual_entry()$item_scores)

 )


 #Need to retrieve client's name for the email

  client_name_sql<- "SELECT first_name, last_name
  FROM client
  WHERE client_id = ?client_id;"

  client_name_query<- sqlInterpolate(pool, client_name_sql, client_id = measure_data()$client_id)

  client_name<- dbGetQuery( pool, client_name_query )
  client_name<- paste(client_name, collapse = " ")



  #If the measure does not have established cutoffs, use the function below to create the vector of scores and severity range descriptions.
  #Otherwise, if there are widely recognised cutoffs, just use those cutoffs for the email, using a custom function like the one just below.
  #May be cases where we use a custom method for one subscale (e.g. PCL-5 total scale) but use the find_severity_range() function to generate
  #the severity range descriptions for the other subscales. In that case, would need to pass subsetted measure_data into the function
  #and would need to join that function output with the output produced by the custom method.

 #measure_data<- measure_data()
 #score_severity_range<- psychlytx::find_severity_range(measure_data) #use the find_severity_range() function to make a single vector of strings
                                                                     #containing (in order) the scores and the severity range descriptions.


 severity_range<- dplyr::case_when(

   measure_data()$score >= 5 & measure_data()$score < 10 ~ "Mild",

   measure_data()$score >= 10 & measure_data()$score < 14 ~ "Moderate",

   measure_data()$score >= 14 ~ "Severe",

   TRUE ~ as.character(measure_data()$score)

 )

 score_severity_range<- c(measure_data()$score, severity_range)


 body_values<- c(client_name, score_severity_range, formatted_item_responses) #Join the previous score/severity range description strings with the item responses to make one vector.


                    #Need to replage "to:" field with clinician's email address, pulled from Autho

    body<- do.call(sprintf, c(list('{"from": {"email":"measurely@psychlytx.com","name":"Measurely"},
        "personalizations": [{"to": [{"email":"tim@effectivepsych.com.au"}],
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

                   "content": "text/html",
                   "c2a_button":"Download Full Clinical Report",
                   "c2a_link":"http://www.psychlytx.com"}}],
                   "template_id":"d-c102ab1090724b6a90a269479f37e943"}'), body_values)) #Pass in the vector of strings to replace placeholders in order.

    return(body)


  })

}

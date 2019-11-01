#' Convert PDSS-SR Measure Responses
#'
#' Convert PDSS-SR raw measure responses into a readable table, to be send in an email to the clinician.
#'
#' @param id A string to create the namespace
#'
#' @export


format_pdsssr_responses_for_email_UI<- function(id) {

  ns<- NS(id)

  return(NULL)
}


#' Convert PDSS-SR Measure Responses
#'
#' Convert PDSS-SR raw measure responses into a readable table, to be send in an email to the clinician.
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

format_pdsssr_responses_for_email<- function(input, output, session, pool, clinician_email, manual_entry, measure_data, simplified = FALSE) {

    reactive({

    formatted_item_responses<- purrr::map_at(manual_entry()$item_scores, 1, ~ {

      if(.x == 0) {"No panic or limited symptom episodes"}
      else if(.x == 1) {"Mild: no full panic attacks and no more than 1 limited symptom attack/day"}
      else if(.x == 2) {"Moderate: 1 or 2 full panic attacks and/or multiple limited symptom attacks/day"}
      else if(.x == 3) {"Severe: more than 2 full attacks but not more than 1/day on average"}
      else {"Extreme: full panic attacks occurred more than once a day, more days than not"}

    }) %>% purrr::map_at(2, ~ {

      if(.x == 0) {"Not at all distressing, or no panic or limited symptom attacks during the past week"}
      else if(.x == 1) {"Mildly distressing (not too intense)"}
      else if(.x == 2) {"Moderately distressing (intense, but still manageable)"}
      else if(.x == 3) {"Severely distressing (very intense)"}
      else {"Extremely distressing (extreme distress during all attacks)"}

    }) %>% purrr::map_at(3, ~ {

      if(.x == 0) {"Not at all"}
      else if(.x == 1) {"Occasionally or only mildly"}
      else if(.x == 2) {"Frequently or moderately"}
      else if(.x == 3) {"Very often or to a very disturbing degree"}
      else {"Nearly constantly and to a disabling extent"}

    }) %>% purrr::map_at(4, ~ {

      if(.x == 0) {"None: no fear or avoidance."}
      else if(.x == 1) {"Mild: occasional fear and/or avoidance but I could usually confront or endure the situation. There was little or no modification of my lifestyle due to this."}
      else if(.x == 2) {"Moderate: noticeable fear and/or avoidance but still manageable. I avoided some situations, but I could confront them with a companion. There was some modification of my lifestyle because of this, but myoverall functioning was not impaired."}
      else if(.x == 3) {"Severe: extensive avoidance. Substantial modification of my lifestyle was required to accommodate the avoidance making it difficult to manage usual activities."}
      else {"Extreme: pervasive disabling fear and/or avoidance. Extensive modification in my lifestyle was required such that important tasks were not performed."}

    }) %>% purrr::map_at(5, ~ {

      if(.x == 0) {"No fear or avoidance of situations or activities because of distressing physical sensations"}
      else if(.x == 1) {"Mild: occasional fear and/or avoidance, but usually I could confront or endure with little distress activities that cause physical sensations. There was little modification of my lifestyle due to this"}
      else if(.x == 2) {" Moderate: noticeable avoidance but still manageable. There was definite, but limited, modification of my lifestyle such that my overall functioning was not impaired."}
      else if(.x == 3) {"Severe: extensive avoidance. There was substantial modification of my lifestyle or interference in my functioning."}
      else {"Extreme: pervasive and disabling avoidance. There was extensive modification in my lifestyle due to this such that important tasks or activities were not performed."}

    }) %>% purrr::map_at(6, ~ {

      if(.x == 0) {"No interference with work or home responsibilities"}
      else if(.x == 1) {"Slight interference with work or home responsibilities, but I could do nearly everything I could if I didn’t have these problems."}
      else if(.x == 2) {"Significant interference with work or home responsibilities, but I still could manage to do the things I needed to do."}
      else if(.x == 3) {"Substantial impairment in work or home responsibilities; there were many important things I couldn’t do because of these problems."}
      else {"Extreme, incapacitating impairment such that I was essentially unable to manage any work or home responsibilities."}

    }) %>% purrr::map_at(7, ~ {

      if(.x == 0) {"No interference"}
      else if(.x == 1) {"Slight interference with social activities, but I could do nearly everything I could if I didn’t have these problems."}
      else if(.x == 2) {"Significant interference with social activities but I could manage to do most things if I made the effort."}
      else if(.x == 3) {"Substantial impairment in social activities; there are many social things I couldn’t do because of these problems."}
      else {"Extreme, incapacitating impairment, such that there was hardly anything social I could do."}

      }) %>% unlist()

    #Need to retrieve client's name for the email

    client_name_sql<- "SELECT first_name, last_name
    FROM client
    WHERE id = ?client_id;"

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

      measure_data()$score < 4 ~ "Normal",

      measure_data()$score >= 4 & measure_data()$score < 6 ~ "Borderline Ill",

      measure_data()$score >= 6 & measure_data()$score < 10 ~ "Mildly Ill",

      measure_data()$score >= 10 & measure_data()$score < 17 ~ "Moderately Ill",

      measure_data()$score >= 17 & measure_data()$score < 22 ~ "Markedly Ill",

      measure_data()$score >= 22 ~ "Severely Ill",

      TRUE ~ as.character(measure_data()$score)

    )



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

                                   "content": "text/html",
                                   "c2a_button":"Download Full Clinical Report",
                                   "c2a_link":"http://www.psychlytx.com"}}],
                                   "template_id":"d-0cf1d5b8c78941868374673ed5ad9d34"}'), body_values)) #Pass in the vector of strings to replace placeholders in order.

    return(body)


})

}




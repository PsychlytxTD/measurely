#' Convert PQ-B Measure Responses
#'
#' Convert PQ-B raw measure responses into a readable table, to be send in an email to the clinician.
#'
#' @param id A string to create the namespace
#'
#' @export


format_pqb_responses_for_email_UI<- function(id) {

  ns<- NS(id)

  return(NULL)
}


#' Convert PQ-B Measure Responses
#'
#' Convert PQ-B raw measure responses into a readable table, to be send in an email to the clinician.
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

format_pqb_responses_for_email<- function(input, output, session, pool, clinician_email, manual_entry, measure_data, simplified = FALSE) {

  reactive({


    #Separate the dichotomous (yes-no) items from the distress items

    dichotomous_items<- manual_entry()$item_scores[1:21]

    distress_items<- manual_entry()$item_scores[22:42]


    formatted_dichotomous_item_responses<- dplyr::case_when( #Convert the client's responses from numerical form to readable responses, teo appear in the email.

      dichotomous_items == 0 ~ "No",

      dichotomous_items == 1 ~ "Yes",

      TRUE ~ as.character(dichotomous_items)

    )

    formatted_distress_item_responses<- dplyr::case_when( #Convert the client's responses from numerical form to readable responses, teo appear in the email.

      distress_items == 1 ~ "Strongly Disagree",

      distress_items == 2 ~ "Disagree",

      distress_items == 3 ~ "Neutral",

      distress_items == 4 ~ "Agree",

      distress_items == 5 ~ "Strongly Agree",

      TRUE ~ "N/A"

    )

    #Join the dichotomous and distress item responses into one vector

    formatted_item_responses<- c(formatted_dichotomous_item_responses, formatted_distress_item_responses)



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


    severity_range_dichotomous<- dplyr::case_when(    #Create simplified severity descriptors for dichotomouse and distress subscales

      measure_data()$Score[1] < 9 ~ "Below Clinical High Risk Status",

      measure_data()$Score[1] >= 9 ~ "Clinical High Risk Status",

      TRUE ~ as.character(measure_data()$score)

    )

    severity_range_distress<- dplyr::case_when(

      measure_data()$Score[2] < 18 ~ "Below Clinical High Risk Status",

      measure_data()$Score[2] >= 18 ~ "Clinical High Risk Status",

      TRUE ~ as.character(measure_data()$score)


    )


    severity_range<- c(severity_range_dichotomous, severity_range_distress) #Join the two simplified severity range descriptor strings together




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

                                   "score_1": "%s",
                                   "score_2": "%s",
                                   "severity_range_1": "%s",
                                   "severity_range_2": "%s",

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
                                   "response_11":"%s",
                                   "response_12":"%s",
                                   "response_13":"%s",
                                   "response_14":"%s",
                                   "response_15":"%s",
                                   "response_16":"%s",
                                   "response_17":"%s",
                                   "response_18":"%s",
                                   "response_19":"%s",
                                   "response_20":"%s",
                                   "response_21":"%s",

                                   "response_22":"%s",
                                   "response_23":"%s",
                                   "response_24":"%s",
                                   "response_25":"%s",
                                   "response_26":"%s",
                                   "response_27":"%s",
                                   "response_28":"%s",
                                   "response_29":"%s",
                                   "response_30":"%s",
                                   "response_31":"%s",
                                   "response_32":"%s",
                                   "response_33":"%s",
                                   "response_34":"%s",
                                   "response_35":"%s",
                                   "response_36":"%s",
                                   "response_37":"%s",
                                   "response_38":"%s",
                                   "response_39":"%s",
                                   "response_40":"%s",
                                   "response_41":"%s",
                                   "response_42":"%s",

                                   "content": "text/html",
                                   "c2a_button":"Download Full Clinical Report",
                                   "c2a_link":"http://www.psychlytx.com"}}],
                                   "template_id":"d-c102ab1090724b6a90a269479f37e943"}'), body_values)) #Pass in the vector of strings to replace placeholders in order.

    return(body)


})

  }

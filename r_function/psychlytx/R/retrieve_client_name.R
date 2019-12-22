#' Retrieve Client Name
#'
#' Retrive name to display thoughout pages of parent app
#'
#' @param id A string to creat the namespace
#'
#' @export

retrieve_client_name_UI<- function(id) {

  ns <- NS(id)

  return(NULL)

}


#' Retrieve Client Name
#'
#' Retrive name to display thoughout pages of parent app
#'
#' @param pool A pooled db connection
#'
#' @param input_retrieve_client_data A reactive value: the value of client selection button
#'
#' @param selected_client A reactive value containing the id of the selected client
#'
#' @export


retrieve_client_name<- function(input, output, session, pool, input_retrieve_client_data, selected_client) {

  client_name_for_display<- eventReactive(input_retrieve_client_data(),{

    client_name_sql<- "SELECT first_name, last_name
    FROM client
    WHERE id = ?client_id;"

    client_name_query<- sqlInterpolate(pool, client_name_sql, client_id = selected_client())

    dbGetQuery(pool, client_name_query)

  })

}




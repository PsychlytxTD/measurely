#' Write client's statistics to holding table
#'
#' Write the client's statistics (selected by clinician) to holding table in DB if sending measure via email link.
#'
#' @param id A string to create the namespace
#'
#' @export

write_statistics_to_holding_UI<- function(id) {

  ns <- NS(id)

  tagList(

  fluidPage(

    fluidRow(

      column(width = 4,

             titlePanel(span(tagList(icon("edit", lib = "font-awesome", class = "far fa-edit"),
                                     h4(tags$b("Please Complete The Measure.")))))

      )),

  fluidRow(

 column(width = 6, #Create button to send measure to client via email, and to automatically write his or her statistics to the holding table in the db.
  br(),
  br(),
  actionButton(ns("submit_holding_data"), "Email This Measure To My Client Instead", class = "submit_button", style = "margin-top: 9px") %>%
    helper( type = "inline", title = "What happens once I send this measure to my client?", colour = "#283747", #Make info icon to explain what happens when email is sent.
            content = c("1. Your client will receive a unique Measurely key and a link to complete this particular measure.",
                        "",
                        "2. After the measure has been completed, you will receive an email displaying your client's results.",
                        "",
                        "3. Within the same email, you will receive a link to return to this application and download a full clinical report.")))

  )))

}




#' Write client's statistics to holding table
#'
#' Write the client's statistics (selected by clinician) to holding table in DB if sending measure via email link.
#'
#' @param pool A pooled database connection.
#'
#' @param holding_data A dataframe indicating the dataframe to send to the db.
#'
#' @export




write_statistics_to_holding<- function(input, ouput, session, pool, holding_data) {


  observeEvent(input$submit_holding_data, {


    sendSweetAlert(                 #Holding stats are sent to the db and an email is sent to the client for measure  completion. Make alert telling clinician measure has been sent.
      session = session,
      title = "Success !!",
      text = "The questionnaire has been sent to your client for completion.",
      type = "success"
    )

    #Read in client's email address from client table

    client_email_sql<- "SELECT email_address
    FROM client
    WHERE id = ?client_id;"

    client_email_query<- sqlInterpolate(pool, client_email_sql, client_id = holding_data()$client_id[length(holding_data()$client_id)])

    selected_client_email<- dbGetQuery(pool, client_email_query)




    url <- c("https://api.sendgrid.com/v3/mail/send")

    headers = c(
      `Authorization` = "bearer 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",
      `Content-Type` = "application/json"
    )


    body = sprintf('{"from": {"email":"measurely@psychlytx.com","name":"Measurely"},
     "personalizations": [{"to": [{"email":"%s"}],
"dynamic_template_data":{
"header":"A measure is ready to be completed",
"text": "Before you begin, please copy copy the following unique key to your clipboard: %s"
"c2a_button":"Begin",
"c2a_link":"https://measurely-remote.psychlytx.com/app/gad_7s"}}],
"template_id":"d-0680c882a9904f3a9e8f72638ff1d807"}', selected_client_email, holding_data()$client_id)

    result <- httr::POST(url,                     #Send the email
                         add_headers(headers),
                         body = body,
                         encode="json",
                         verbose())


    #Delete existing rows in the db for this client (only for this measure) to avoid
    #the remote app pulling in more rows than necessary.

    conn<- poolCheckout(pool)

    delete_old_holding_query<- glue::glue_sql("DELETE FROM holding
                                              WHERE client_id = {holding_data()$client_id[1]}
                                              AND measure = {holding_data()$measure[1]}", .con = conn
                                              )

    dbExecute(conn, sqlInterpolate(ANSI(), delete_old_holding_query))

    poolReturn(conn)



    #Write the client's holding statistics to the holding table in the databse (so they can be used when client completes the simplified app).

    dbWriteTable(pool, "holding",  data.frame(holding_data()), row.names = FALSE, append = TRUE)


  })




}

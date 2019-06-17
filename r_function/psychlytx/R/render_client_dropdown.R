#'Render Client Dropdown
#'
#'#Render client dropdown menu
#'
#'@param id A string to create the namespace
#'
#'@export

render_client_dropdown_UI<- function(id) {

ns <- NS(id)

tagList(

titlePanel(span(tagList(icon("f07c", lib = "font-awesome", class = "far fa-folder-open"), h4("Find And Select Your Client")))),

actionButton(ns("refresh"), "Refresh Client List", class = "submit_data_blue"),

br(),

uiOutput(ns("client_dropdown"))


)

}



#'Render Client Dropdown
#'
#'#Render client dropdown menu
#'
#' @param pool A pool db connection object
#'
#' @param clinician_id Clinician's unique identifier
#'
#'@export


render_client_dropdown<- function(input, output, session, pool, clinician_id) {

clients<- reactive({

  input$refresh

  # Querying code to be called when clinician clicks 'existing client' tab further down. To generate dropdown of clients.

  client_list_sql<- "SELECT clinician_id, client_id, first_name, last_name, birth_date
  FROM client
  WHERE clinician_id = ?clinician_id;"

  client_list_query<- sqlInterpolate(pool, client_list_sql, clinician_id = clinician_id)

  client_list<- dbGetQuery( pool, client_list_query )

  validate(need(length(client_list) >= 1, "No clients registered yet."))

  client_list <- client_list %>%
    tidyr::unite(dropdown_client, first_name, last_name, birth_date, sep = " ", remove = FALSE)

  client_list<- client_list %>%
    collect  %>%
    split( .$dropdown_client ) %>%    # Field that will be used for the labels
    purrr::map(~.$client_id)          #Field that will be returned when the clinician actually chooses the client


})



output$client_dropdown<- renderUI({ #Make the client selection widget

  ns <- session$ns

  req(clients())

  selectizeInput(
    inputId = ns("client_selection"),
    label = "",
    choices = clients())


})

outputOptions(output, "client_dropdown", suspendWhenHidden = FALSE)


reactive({ input$client_selection }) #Return the selected client client_id

}

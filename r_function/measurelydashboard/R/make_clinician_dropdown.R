#' Make Clinician Selection Widget
#'
#' Make a widget allowing practice manager to filter dashboard data based on a clinician.
#'
#' @param id A string to create the namespace.
#'
#' @export


make_clinician_dropdown_UI<- function(id) {

  ns<- NS(id)

  uiOutput(ns("clinician_dropdown"))


}

#' Make Clinician Selection Widget
#'
#' Make a widget allowing practice manager to filter dashboard data based on a clinician.
#'
#' @param pool A pooled db object
#'
#' @param practice_id A string intdicating the id of the practice to which the clinician belongs.
#'
#' @export

make_clinician_dropdown<- function(input, output, session, pool, practice_id) {

  clinicians<- reactive({

  clinician_list_sql<- "SELECT id, first_name, last_name, birth_date
  FROM clinician
  WHERE practice_id= ?practice_id;"

  clinician_list_query<- sqlInterpolate(pool, clinician_list_sql, practice_id = practice_id)

  clinician_list<- dbGetQuery( pool, clinician_list_query )

  validate(need(length(clinician_list) >= 1, "No clinicians to show"))

  clinician_list$birth_date<- as.character(format(clinician_list$birth_date, "%d/%m/%Y")) #Make sure date appears in correct format (i.e. day, month, year)

  clinician_list <- clinician_list %>%
      tidyr::unite(dropdown_clinician, first_name, last_name, birth_date, sep = " ", remove = FALSE)

  clinician_list<- clinician_list %>%
      collect  %>%
      split( .$dropdown_clinician ) %>%    # Field that will be used for the labels
      purrr::map(~.$id)          #Field that will be returned when the clinician actually chooses the client


  })

  output$clinician_dropdown<- renderUI({ #Make the client selection widget

    ns <- session$ns

    req(clinicians())

    selectizeInput(
      inputId = ns("clinician_selection"),
      label = "",
      choices = clinicians(),
      options = list(
        placeholder = 'Type a name or scroll down..',
        onInitialize = I('function() { this.setValue(""); }')
      ))


  })


  reactive({ input$clinician_selection })







}
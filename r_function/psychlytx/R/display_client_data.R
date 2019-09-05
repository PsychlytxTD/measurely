#' Select Client
#'
#' Select client and display his/her data in abbreviated form.
#'
#' @param id A string to creat the namespace
#'
#' @export

display_client_data_UI<- function(id) {

  ns <- NS(id)

  tagList(

    shinycssloaders::withSpinner( DT::dataTableOutput(ns("selected_client_data_out")), type = getOption("spinner.type", default = 7),
                                  color = getOption("spinner.color", default = "#d35400") ),

    shinycssloaders::withSpinner( verbatimTextOutput(ns("client_data_availability_message")), type = getOption("spinner.type", default = 7),
                                  color = getOption("spinner.color", default = "#d35400") )

  )

}



#' Select Client
#'
#' Select client and display his/her data in abbreviated form.
#'
#' @param pool A pooled db object
#'
#' @param selected_client A string indicating selected client's unique identifier
#'
#' @param measure A string indiating name of the measure
#'
#' @param input_retrieve_client_data A numeric value indicating the value of the action button - used to trigger a database query.
#'
#' @export


display_client_data<- function(input, output, session, pool, selected_client, measure, input_retrieve_client_data) {


  selected_client_data<- eventReactive(input_retrieve_client_data(), { #Pull in the selected client's data (for this measure only) from the db.

    selected_client_sql<- "SELECT *
    FROM scale
    WHERE client_id = ?client_id AND measure = ?measure;"

    selected_client_query<- sqlInterpolate(pool, selected_client_sql, client_id = selected_client(), measure = measure)

    dbGetQuery(pool, selected_client_query)


  })





  output$selected_client_data_out<- DT::renderDataTable({ #Show a snapshot of the data in a table so that the user can see how many assessments have been completed.

    req( selected_client_data() )

    snapshot_selected_client_data<- if(length( selected_client_data() )  < 1) {
      return(NULL) } else {selected_client_data() %>% dplyr::select(date, measure, subscale, score) %>%
          dplyr::rename_all(toupper) %>% dplyr::mutate(MEASURE = gsub("_", " ", MEASURE),
                                                       SUBSCALE = gsub("_", " ", SUBSCALE),
                                                       DATE = as.character(format(DATE, "%d/%m/%Y"))
                                                       )}


     DT::datatable(

      snapshot_selected_client_data,
      extensions = 'Scroller', rownames = FALSE,
      options = list(initComplete = JS(
        "function(settings, json) {",
        "$(this.api().table().header()).css({'background-color': '#e5e5e5', 'color': '#d35400'});",
        "}"), deferRender = TRUE, scrollY = 200, scroller = TRUE, dom = "t" )

    )

  })


  output$client_data_availability_message<- renderText({ #Show user whether client has been selected and whether data has previously been inputted.

    req( selected_client_data() )

    if(length(selected_client_data()) >= 1) {

      glue::glue("Client selected. Note: only your client's outcome data for the {measure} are displayed.")

    } else {

      glue::glue("Client selected. No data to show yet for this measure. Note: only your client's outcome data for the {measure} are displayed.")

    }

  })

  reactive({ selected_client_data() }) #Return the client's existing scale data

}

#' Collect Simplified Application Subscale Input
#'
#' Collect simplified application subscale data for writing to db.
#'
#' @param id String to create a unique namespace.
#'
#' @export



simplified_collect_holding_input_UI<-  function(id) {

  ns<- NS(id)

  return(NULL)

}

#' Collect Simplified Application Subscale Input
#'
#' Collect simplified application subscale data for writing to db.
#'
#' @param holding_data A dataframe containing the relevant statistics for the client selected by the clinician.
#'
#' @param aggregate_scores A list of aggregated subscale scores.
#'
#' @param mean_input A list containing the mean value and reference (widget inputs).
#'
#' @param sd_input A list containing the sd value and reference (widget inputs).
#'
#' @param reliability_input A list containing the test-retest value and reference (widget inputs).
#'
#' @param confidence A numeric value indicating the level of confidence selected for intervals (widget input).
#'
#' @param method A string value indicating the reliable change method selected (widget value).
#'
#' @param cutoff_input A list containing the cutoff values, labels and references (widget inputs).
#'
#' @param subscale_number A numeric value representing which index (i.e. which subscale) to select from the list of indices.



simplified_collect_holding_input<- function(input, output, session, holding_data, manual_entry, aggregate_scores, mean_input, sd_input, reliability_input,
                                            confidence, method, cutoff_input, subscale_number) {


  reactive({

    #Pull certain statistics from correct patient row in holding table in db: only the ones that haven't been used to update widgets.
    #Where stats have been pulled in to update widget, we use the value returned by the updated widget, rather reading the
    #value directly from the holding table itself.

    #Return the list of data for a subscale.


    list( holding_data()$clinician_id[subscale_number], holding_data()$client_id[subscale_number], holding_data()$measure[subscale_number], holding_data()$subscale[subscale_number],
          manual_entry()[["date"]], aggregate_scores()[[subscale_number]], mean_input(), sd_input(), reliability_input(), confidence(), method(),
          holding_data()$population[subscale_number], cutoff_input() )

    })

}

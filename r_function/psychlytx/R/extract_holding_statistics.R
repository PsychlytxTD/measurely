#' Collect Holding Statistics
#'
#' Store holding statistics in a list.
#'
#' @param id String to create a unique namespace.
#'
#' @export



extract_holding_statistics_UI<-  function(id) {

  ns<- NS(id)

  return(NULL)

}

#' Collect Holding Statistics
#'
#' Store holding statistics in a list.
#'
#' @param clinician_id A string indicating the clinician's unique identifier
#'
#' @param client_id A string indicating the client's unique identifier
#'
#' @param measure A string indicating the name of the measure.
#'
#' @param subscale A string indicating the name of the subscale.
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
#' @param input_population A string value indicating the reference population selected by the user.
#'
#' @param cutoff_input A list containing the cutoff values, labels and references (widget inputs).
#'
#' @param subscale_number A numeric value representing which index (i.e. which subscale) to select from the list of indices.



extract_holding_statistics<- function(input, output, session, clinician_id, client_id, measure, subscale, mean_input, sd_input, reliability_input, confidence, method, input_population, cutoff_input, subscale_number) {

  #Return a list of statistics (no scores or score information), to be sent to the holding table in the db. Needed when client completes simplified application.

  reactive({ list( clinician_id, client_id(), measure, subscale, mean_input(), sd_input(), reliability_input(), confidence(), method(), input_population(), cutoff_input() ) })

}

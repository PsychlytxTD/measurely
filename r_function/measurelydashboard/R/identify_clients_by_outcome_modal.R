#' Indentify Clients For Outcomes Modals
#'
#' Filter nested df by clinical outcome to identify clients
#'
#' @param nested_data A reactive nested dataframe containing subscale scores for each individual.
#'
#' @export


identify_clients_by_outcome_modal<- function(nested_data, filtering_var) {

  outcome<- rlang::enquo(filtering_var)

  nested_data() %>% dplyr::filter(!!outcome == TRUE) %>% dplyr::select(`Last Assessment` = last_assessment_date, `First Name` = first_name, Surname = last_name,
                                                                       D.O.B. = birth_date, Measure = measure,
                                                                       Subscale = subscale)

}
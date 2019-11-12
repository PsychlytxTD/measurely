#' Indentify Clients For Outcomes Modals
#'
#' Filter nested df by clinical outcome to identify clients
#'
#' @param nested_data A reactive nested dataframe containing subscale scores for each individual.
#'
#' @export


identify_clients_by_outcome_modal<- function(nested_data, filtering_var) {

  outcome<- rlang::enquo(filtering_var)

  nested_data() %>% dplyr::filter(!!outcome == TRUE) %>% dplyr::select(first_name, last_name, birth_date, subscale)

}
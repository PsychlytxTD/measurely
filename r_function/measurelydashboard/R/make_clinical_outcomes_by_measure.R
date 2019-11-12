#' Make Clinical Outcomes By Measure
#'
#' Generate counts and percentages by measure to show in by-measure plot of clinical outcomes
#'
#' @param nested_data A reactive nested dataframe
#'
#' @param outcome_var The name of the outcome to calculate: improve, sig_improve, remained_same or deteriorated

make_clinical_outcomes_by_measure<- function(nested_data, outcome_var) {

  outcome<- rlang::enquo(outcome_var)

  nested_data() %>% dplyr::group_by(measure) %>% dplyr::summarise(

  count = round(sum(!!outcome, na.rm = TRUE), 1),
  percent = round((count / length(!!outcome)) * 100, 1),
  average_change = round(mean(change, na.rm = TRUE), 1)

  )
}



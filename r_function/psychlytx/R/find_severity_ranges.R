#' Find Severity Range
#'
#' Obtain scores and severity ranges for presenting in email
#'
#' @param measure_data A dataframe indicating the dataframe to send to the db
#'
#' @export

find_severity_range<- function(measure_data) {

  #Subset the data to retrieve cutoff values only (to facilitate conversion to lists row-wise)
  #Need to add "zero" cutoff value and label to prevent error if the client's score is below the lowest cutoff.

  cutoff_vals_only<- measure_data %>% dplyr::select(contains("value")) %>% dplyr::mutate(cutoff_value_0 = 0)
  cutoff_vals_only<- cutoff_vals_only %>% dplyr::select(cutoff_value_0, everything())

  #Subset the data to retrieve cutoff labels only (to facilitate conversion to lists row-wise)

  cutoff_labs_only<- measure_data %>% dplyr::select(contains("label")) %>% dplyr::mutate(cutoff_label_0 = paste("Below", cutoff_label_1))
  cutoff_labs_only<- cutoff_labs_only %>% dplyr::select(cutoff_label_0, everything())


  score<- measure_data$score #Store subscale scores in single vector

  vals_list<- purrrlyr::invoke_rows(.d = cutoff_vals_only, .f = list) %>% dplyr::select(vals_list = .out) #Each row of cutoff values converted into single list

  labs_list<- purrrlyr::invoke_rows(.d = cutoff_labs_only, .f = list) %>% dplyr::select(labs_list = .out) #Each row of labels values converted into single list


  bound_df<- dplyr::bind_cols(score = score, vals_list = vals_list, labs_list = labs_list)

  bound_df$score<- as.list(bound_df$score) #Make dataframe of list columns containing subscale scores, lists of cutoff values & lists of cuotff labels


  #For each score (each row of df) locate the cutoff score immediately beneath it.

  bound_df<- bound_df %>% dplyr::mutate(found_val = purrr::map2(bound_df$vals_list, bound_df$score, ~.x[max(which(.x <= .y))]))


  #Make a dataframe with cutoff value lists in one column and cutoff value labels in the other — need this for indexing
  bound_df<- bound_df %>% dplyr::mutate(cutoff_df = purrr::map2(bound_df$labs_list, bound_df$vals_list, ~ dplyr::bind_cols(labels = unlist(.x), values = unlist(.y))))

  bound_df$found_val<- bound_df$found_val %>% purrr::flatten() #Need to prevent nested list for found val

  #Index the dataframe to locate the severity ranges for each subscale

  bound_df<- bound_df %>% dplyr::mutate(severity_range = purrr::map2(bound_df$cutoff_df, bound_df$found_val, ~ paste("Above or equal to", .x[.x$values == .y, 1])))

  bound_df$severity_range<- purrr::map(bound_df$severity_range, ~ as.vector(unlist(.x))) #Unlist the severity range column

  flattened_score<- purrr::flatten_dbl(bound_df$score)

  flattened_severity_ranges<- purrr::flatten_chr(bound_df$severity_range)

  body_string<- list(flattened_score, flattened_severity_ranges) %>% purrr::flatten()

  body_string<- unlist(as.vector(body_string))

  return(body_string) #Return a vector of strings containing (in order) the scores, and the severity range descriptions

}

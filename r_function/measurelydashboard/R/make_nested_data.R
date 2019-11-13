#' Make nested data
#'
#' Make a nested dataframe with list column of subscale scores for each individual.
#'
#' @param id A string to create the namespace.
#'
#' @export


make_nested_data_UI<- function(id) {

  ns<- NS(id)

  return(NULL)

}


#' Make nested data
#'
#' Make a nested dataframe with list column of subscale scores for each individual.
#'
#' @param joined_data A reactive df consisting of the joined database tables: client, scale & posttherapy.
#'
#' @export

make_nested_data<- function(input, output, session, joined_data) {

  #Nest the joined data - required for analysis of outcomes by measure and client

  #Create a list column with scores on a specific subscale for each client

  nested_data<- reactive({

    nested<- joined_data() %>% dplyr::group_by(client_id, first_name, last_name, birth_date, measure, subscale) %>% tidyr::nest()

    #Arrange the date column within each nested dataframe, from earliest to latest

    nested$data<- purrr::map(nested$data, ~dplyr::arrange(., lubridate::dmy(.x$date)))

    #Within each nested dataframe, canculate key stats across all timepoints for that subscale

    nested<- nested %>% dplyr::mutate(data = purrr::map(data, ~ dplyr::mutate(., improve_all = .x$score < lag( .x$score ),
                                                                              sig_improve_all = .x$score < lag( .x$ci_lower ),
                                                                              remained_same_all = .x$score == lag( .x$score ),
                                                                              deteriorated_all = .x$score > lag( .x$score ),
                                                                              change_all = .x$score - lag(.x$score)
    )))

    #Use the nested dataframes to add new variables of key stats between first and last timepoint for each client per subscale


    nested<- nested %>% dplyr::mutate(change = purrr::map_dbl( data, ~.x$score[1] - .x$score[length(.x$score)] ), #Specify non-sig improvement
                                      improve = purrr::map_lgl( data, ~ .x$score[length(.x$score)] < .x$score[1] & .x$score[length(.x$score)] >= .x$ci_lower[1]  ),
                                      sig_improve = purrr::map_lgl( data, ~.x$score[length(.x$score)] < .x$ci_lower[1] ),
                                      remained_same = purrr::map_lgl( data, ~ (length(.x$score) > 1) & (.x$score[length(.x$score)] == .x$score[1]) ),
                                      deteriorated = purrr::map_lgl(data, ~.x$score[length(.x$score)] > .x$score[1] )
    )

  })

}

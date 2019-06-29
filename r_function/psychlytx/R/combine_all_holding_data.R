#' Combine All Holding Statistics
#'
#' Combine all lists of holding statistics
#'
#' @param id A string to create the namespace.

combine_all_holding_data_UI<- function(id) {

  ns<- NS(id)

  return(NULL)

}




#' Combine All Holding Statistics
#'
#' Combine all lists of holding statistics
#'
#' @param input_list A list of input lists (one for each subscale).
#'
#' @export


combine_all_holding_data<- function(input, output, session, holding_statistics_list) {

  reactive({
    #Once we have the inputs from all widgets, flatten each sublist so we end up with one list of sublists

    all_input<- holding_statistics_list() %>% purrr::map( ~ purrr::flatten(.x) %>% purrr::set_names(c("clinician_id", "client_id", "measure", "subscale", "mean",
                                                                                         "mean_reference","sd", "sd_reference", "reliability", "reliability_reference", "confidence", "method", "population",
                                                                                         "cutoff_label_1", "cutoff_label_2", "cutoff_label_3", "cutoff_label_4", "cutoff_label_5", "cutoff_label_6",
                                                                                         "cutoff_value_1", "cutoff_value_2", "cutoff_value_3", "cutoff_value_4", "cutoff_value_5", "cutoff_value_6",
                                                                                         "cutoff_reference_1", "cutoff_reference_2","cutoff_reference_3", "cutoff_reference_4",
                                                                                         "cutoff_reference_5", "cutoff_reference_6")))


    holding_statistics_data<- all_input %>% {

      tibble::tibble(   #Create a dataframe with the values of each sublist filling a row

        clinician_id = purrr::map_chr(., "clinician_id"),
        client_id = purrr::map_chr(., "client_id"),
        measure = purrr::map_chr(., "measure"),
        subscale = purrr::map_chr(., "subscale"),
        mean = purrr::map_dbl(., "mean"),
        mean_reference = purrr::map_chr(., "mean_reference"),
        sd = purrr::map_dbl(., "sd"),
        sd_reference = purrr::map_chr(., "sd_reference"),
        reliability = purrr::map_dbl(., "reliability"),
        reliability_reference = purrr::map_chr(., "reliability_reference"),
        confidence = purrr::map_dbl(., "confidence"),
        method = purrr::map_chr(., "method"),
        population = purrr::map_chr(., "population"),
        cutoff_label_1 = purrr::map_chr(., "cutoff_label_1"),
        cutoff_label_2 = purrr::map_chr(., "cutoff_label_2"),
        cutoff_label_3 = purrr::map_chr(., "cutoff_label_3"),
        cutoff_label_4 = purrr::map_chr(., "cutoff_label_4"),
        cutoff_label_5 = purrr::map_chr(., "cutoff_label_5"),
        cutoff_label_6 = purrr::map_chr(., "cutoff_label_6"),
        cutoff_value_1 = purrr::map_dbl(., "cutoff_value_1"),
        cutoff_value_2 = purrr::map_dbl(., "cutoff_value_2"),
        cutoff_value_3 = purrr::map_dbl(., "cutoff_value_3"),
        cutoff_value_4 = purrr::map_dbl(., "cutoff_value_4"),
        cutoff_value_5 = purrr::map_dbl(., "cutoff_value_5"),
        cutoff_value_6 = purrr::map_dbl(., "cutoff_value_6"),
        cutoff_reference_1 = purrr::map_chr(., "cutoff_reference_1"),
        cutoff_reference_2 = purrr::map_chr(., "cutoff_reference_2"),
        cutoff_reference_3 = purrr::map_chr(., "cutoff_reference_3"),
        cutoff_reference_4 = purrr::map_chr(., "cutoff_reference_4"),
        cutoff_reference_5 = purrr::map_chr(., "cutoff_reference_5"),
        cutoff_reference_6 = purrr::map_chr(., "cutoff_reference_6")

      )

    } %>% dplyr::mutate(id = uuid::UUIDgenerate()) %>% dplyr::select(id, everything())

    return(holding_statistics_data)

  })


}

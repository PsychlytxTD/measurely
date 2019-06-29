#' Combine All Input
#'
#' Combine all lists of widget input values
#'
#' @param id A string to create the namespace.

combine_all_input_UI<- function(id) {

  ns<- NS(id)

  return(NULL)

}




#' Combine All Input
#'
#' Combine all lists of widget input values
#'
#' @param input_list A list of input lists (one for each subscale).
#'
#' @export


combine_all_input<- function(input, output, session, input_list) {

  reactive({
                        #Once we have the inputs from all widgets, flatten each sublist so we end up with one list of sublists

    all_input<- input_list() %>% purrr::map( ~ purrr::flatten(.x) %>% purrr::set_names(c("clinician_id", "client_id", "measure", "subscale", "date", "score", "mean",
          "mean_reference","sd", "sd_reference", "reliability", "reliability_reference", "confidence", "method", "population",
          "cutoff_label_1", "cutoff_label_2", "cutoff_label_3", "cutoff_label_4", "cutoff_label_5", "cutoff_label_6",
          "cutoff_value_1", "cutoff_value_2", "cutoff_value_3", "cutoff_value_4", "cutoff_value_5", "cutoff_value_6",
          "cutoff_reference_1", "cutoff_reference_2","cutoff_reference_3", "cutoff_reference_4", "cutoff_reference_5", "cutoff_reference_6")))


    scale_data<- all_input %>% {

      tibble::tibble(   #Create a dataframe with the values of each sublist filling a row

        clinician_id = purrr::map_chr(., "clinician_id"),
        client_id = purrr::map_chr(., "client_id"),
        measure = purrr::map_chr(., "measure"),
        subscale = purrr::map_chr(., "subscale"),
        date = as.character(lubridate::as_date(purrr::map_dbl(., "date"))), #Convert to correct SQL format and conver to character
        score = purrr::map_dbl(., "score"),
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

      )    # Use mutate() to make columns for pts, se, ci, ci_upper, ci_lower

    } %>% dplyr::mutate(

      pts = switch(method[1], # Check the first row of the method variable (should be the same for all rows (i.e. all subscales))
                   # Based on reliable change method used, pts and se are calculated differently.

                   "Nunnally & Bernstein (1994)" = (reliability * score) + (mean * (1 - reliability)),
                   "Jacobson & Truax (1991)" = score

      ),

      se = switch(method[1],

                  "Nunnally & Bernstein (1994)" = sd * sqrt(1 - reliability ^ 2),
                  "Jacobson & Truax (1991)" = sqrt((2 * (sd ^ 2)) * (1 - reliability))

      ),

      ci = confidence * se, #Calculate confidence intervals

      ci_upper = pts + ci,

      ci_lower = pts - ci


      #Round numeric variables
      #Arrange the order of columns in a logical way, with the most important variables coming first.

      #Use UUIDgenerate to make unique entry id for scale table called scale_id. Need this for lookup using Ruby API.

    ) %>% dplyr::mutate_if(is.numeric, round, 2) %>% dplyr::mutate(id = uuid::UUIDgenerate()) %>%  dplyr::select(clinician_id, client_id, measure, subscale, date, score, pts, se, ci, ci_upper, ci_lower, everything())



    return(scale_data)

    })


}

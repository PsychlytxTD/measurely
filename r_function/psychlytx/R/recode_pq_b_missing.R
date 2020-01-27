#' Adjust PQ-B missing values vector
#'
#' Implenent PQ-B recording to account for split scorring.
#'
#' @param missing A numeric vector indicating the location of missing values
#'
#' @export


recode_pq_b_missing<- function(missing) {

  missing<- dplyr::case_when(

    missing == 22 ~ 1,
    missing == 23 ~ 2,
    missing == 24 ~ 3,
    missing == 25 ~ 4,
    missing == 26 ~ 5,
    missing == 27 ~ 6,
    missing == 28 ~ 7,
    missing == 29 ~ 8,
    missing == 30 ~ 9,
    missing == 31 ~ 10,
    missing == 32 ~ 11,
    missing == 33 ~ 12,
    missing == 34 ~ 13,
    missing == 35 ~ 14,
    missing == 36 ~ 15,
    missing == 37 ~ 16,
    missing == 38 ~ 17,
    missing == 39 ~ 18,
    missing == 40 ~ 19,
    missing == 41 ~ 20,
    missing == 42 ~ 21
  )

  return(missing)

}


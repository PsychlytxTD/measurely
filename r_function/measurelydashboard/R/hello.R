#' Make Age Discrete
#'
#' Cut the continuous age variable into a discrete variable
#'
#' @param x A numeric vector
#'
#' @param lower Lower bound
#'
#' @param upper Upper bound
#'
#' @param by Age category increment
#'
#' @param sep Separator
#'
#' @param above_char Plus symbol for paste function
#'
#' @export

age_cat <- function(x, lower = 0, upper, by = 10,
                    sep = "-", above_char = "+") {

  labs <- c(paste(seq(lower, upper - by, by = by),
                  seq(lower + by - 1, upper - 1, by = by),
                  sep = sep),
            paste(upper, above_char, sep = ""))

  cut(floor(x), breaks = c(seq(lower, upper, by = by), Inf),
      right = FALSE, labels = labs)
}

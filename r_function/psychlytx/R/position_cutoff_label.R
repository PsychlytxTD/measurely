#' Position Cutoff Labels
#'
#' Position Cutoff Labels on Plots
#'
#' @param lower Lower border of cutoff shading area
#'
#' @param upper Upper border of cutoff shading area
#'
#' @export


position_cutoff_label<- function(lower, upper) {

  lower + (0.5 * diff(c(lower, upper)) )

}

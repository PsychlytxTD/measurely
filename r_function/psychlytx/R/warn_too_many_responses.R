#' Indicate Excessive Item Response
#'
#' Make sweet alert indicating endorsement of too many items
#'
#' @param session A session object.
#'
#' @param item_too_long A logical vector indicating whether an input is greater than length one.
#'
#' @export

warn_too_many_responses<- function(session, item_too_long) {

if(length(item_too_long[item_too_long==TRUE]) >= 1) {

  index_long_items<- which(item_too_long == TRUE)

  index_long_items<- paste(index_long_items, sep = " ", collapse = " and ")

  sendSweetAlert(
    session = session,
    title = "Multiple responses to a single item!!",
    text = paste("Please enter only a single response to question", index_long_items),
    type = "error"
  )

}

}

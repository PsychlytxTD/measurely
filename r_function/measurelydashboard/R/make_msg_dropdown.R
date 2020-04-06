#' Make Notification Dropdown
#'
#' Make a dropdown in header showing notifications.
#'
#' @param id A string to create the namespace
#'
#' @export


make_notification_dropdown_UI<- function(id) {

  ns<- NS(id)

  tagList(

  dropdownMenuOutput(ns("messages_menu"))

  dropdownMenuOutput(ns("notification_menu"))

  )

}


#' Make Notification Dropdown
#'
#' Make a dropdown in header showing notifications.
#'
#' @param nested_data A nested data frame with clinical outcomes by subscale.
#'
#' @export


make_notification_dropdown<- function(input, output, session, nested_data) {

  output$notification_menu <- renderMenu({

    ns <- session$ns

    only_one_timepoint<- nested_data() %>% dplyr::filter(at_least_two == FALSE)

    msgs <- apply(only_one_timepoint, 1, function(row) {

      notificationItem(
        text = h3(paste(row[["first_name"]], row[["last_name"]], "requires follow-up assessment with the",
                        stringr::str_replace(row[["measure"]], "_", "-"))),
        icon("clipboard fa-2x"),
        status = "info"
      )
    })


    # This is equivalent to calling:
    #   dropdownMenu(type="messages", msgs[[1]], msgs[[2]], ...)
    dropdownMenu(type = "notifications", .list = msgs)
  })








  output$message_menu <- renderMenu({

    ns <- session$ns

    improvements_df<- measurelydashboard::identify_clients_by_outcome_modal(nested_data(), improve)

    time_since_last_assessment<- difftime(Sys.Date(), improvements_df$`Last Assessment`,units="days")
    time_since_last_assessment<- stringr::str_extract(as.character(time_since_last_assessment), "\\d+")

    improvements_df<- improvements_df %>% dplyr::filter(at_least_two == TRUE &)

    msgs <- apply(only_one_timepoint, 1, function(row) {

      messageItem(
        text = h3(paste(row[["first_name"]], row[["last_name"]], "requires follow-up assessment with the",
                        stringr::str_replace(row[["measure"]], "_", "-"))),
        icon("clipboard fa-2x"),
        status = "info"
      )
    })


    # This is equivalent to calling:
    #   dropdownMenu(type="messages", msgs[[1]], msgs[[2]], ...)
    dropdownMenu(type = "messages", .list = msgs)
  })

}
#' Make Posttherapy Outcomes Value Boxes
#'
#' Render value boxes for post-therapy outcomes
#'
#' @param id A string to create the namespace.
#'
#' @export

make_posttherapy_valueboxes_UI<- function(id) {

  ns<- NS(id)

  tagList(

  h2("Attendance & Therapy Characteristics", class = "headings"),

  br(),

fluidRow(
  valueBoxOutput(ns("attendances")),
  valueBoxOutput(ns("cancellations")),
  valueBoxOutput(ns("dnas"))
))

}


#' Make Posttherapy Outcomes Value Boxes
#'
#' Render value boxes for post-therapy outcomes
#'
#' @param posttherapy_analytics_table A reactive dataframe with posttherapy analytics data
#'
#' @export

make_posttherapy_valueboxes<- function(input, output, session, posttherapy_analytics_table) {

value_box_posttherapy<- reactive({

  validate(need(nrow(posttherapy_analytics_table()) >= 1, "No results to show yet"))

  posttherapy_analytics_table() %>% dplyr::summarise(

    avg_attendances<- round(mean(attendances, na.rm = TRUE), 1),

    avg_cancellations<- round(mean(cancellations, na.rm = TRUE), 1),

    avg_dnas<- round(mean(non_attendances, na.rm = TRUE), 1)

  )


})


output$attendances <- renderValueBox({

  valueBox(
    value = paste0(req(value_box_posttherapy()) %>% dplyr::pull(1)),
    subtitle = "Average Sessions Per Client"
  )
})

output$cancellations <- renderValueBox({

  valueBox(
    value = paste0(req(value_box_posttherapy()) %>% dplyr::pull(2)),
    subtitle = "Average Cancellations Per Client"
  )
})

output$dnas <- renderValueBox({
  valueBox(
    value = paste0(req(value_box_posttherapy()) %>% dplyr::pull(3)),
    subtitle = "Average DNAs Per Client"
  )

})

}
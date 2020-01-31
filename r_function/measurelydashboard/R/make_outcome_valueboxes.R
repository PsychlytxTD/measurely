#' Clinical Outcomes By Measure Plot
#'
#' Make the plot for displaying clinical outcomes by individual measures
#'
#' @param id A string to create the namespace
#'
#' @export


make_outcome_valueboxes_UI<- function(id) {

  ns<- NS(id)

  tagList(

  fluidRow(

  column(width = 9, offset = 3,
  actionButton(ns("valuebox_info"), "Information About Clinical Outcome Value Boxes", class = "submit_button")
  )),

  br(),

  fluidRow(

    shinycssloaders::withSpinner(valueBoxOutput(ns("improved"), width = 3), type = getOption("spinner.type", default = 7),
                                 color = getOption("spinner.color", default = "#d35400")),

    bsModal(ns("mod_1"),"Cases of Symptom Improvement","btn", size = "large",
            DT::dataTableOutput(ns("table_improved"))),


    valueBoxOutput(ns("sig_improved"), width = 3),

    bsModal(ns("mod_2"),"Cases of Statistically Reliable Symptom Improvement","btn", size = "large",
            DT::dataTableOutput(ns("table_sig_improved"))),


    valueBoxOutput(ns("remained_same"),
                   width = 3),

    bsModal(ns("mod_3"),"Cases of Nil Symptom Change","btn", size = "large",
            DT::dataTableOutput(ns("table_remained_same"))),


    valueBoxOutput(ns("deteriorated"), width = 3),

    bsModal(ns("mod_4"),"Cases of Symptom Deterioration","btn", size = "large",
            DT::dataTableOutput(ns("table_deteriorated")))
  ))


}


#' Clinical Outcomes By Measure Plot
#'
#' Make the plot for displaying clinical outcomes by individual measures
#'
#' @param nested_data A reactive nested dataframe containing subscale scores for each individual.
#'
#' @export


make_outcome_valueboxes<- function(input, output, session, nested_data) {

  observeEvent(input$valuebox_info, {

    sendSweetAlert(
      session = session,
      title = "How clinical change outcomes displayed in value boxes are derived:",
      text = "Only clients who have been assessed at least twice using an outcome measure are included in analyses. The number and percentage of clients that 'improved',
      'reliably improved', 'did not change' and 'deteriorated' are shown. Clients are not included more than once when
      calculating clinical change outcomes. For example, if John Smith displays an improvement on both the GAD-7 and
      PCL-5, this counts as 1 patient improvement, and he will be added to the 'improved' value box. Click on a value box to view episodes of assessment and clinical outcomes for individual clients.",
      type = "info"
    )

  })


#Wrangle the data for the value boxes

value_box_outcomes<- reactive({

  #total_administrations<- nrow(nested_data())

  #Only select cases with at least two timepoints on a subscale

  at_least_two_timepoints_cases<-  req(nested_data()) %>% dplyr::filter(at_least_two == TRUE)

  #Create separate dataframes for each client, then select only the list column containing this data

  by_client<- at_least_two_timepoints_cases %>% dplyr::group_by(client_id) %>% tidyr::nest() %>% dplyr::select(data)

  #Calculate the number of unique clients that have two timepoints

  n_at_least_two_timepoints<- dplyr::n_distinct(at_least_two_timepoints_cases$client_id)


    #Calculate the number and percentage of patients (with at least 2 timepoints) that
    #showed at least one outcome (improved, sig_improved, remained_same or deteriorated).

    improved<- sum(by_client$data %>% purrr::map_lgl(~any(.x$improve) == TRUE), na.rm = TRUE)
    improved_percent<- round(improved /  n_at_least_two_timepoints * 100, 1)
    sig_improved<- sum(by_client$data %>% purrr::map_lgl(~any(.x$sig_improve) == TRUE), na.rm = TRUE)
    sig_improved_percent<- round(sig_improved /  n_at_least_two_timepoints * 100, 1)
    remained_same<- sum(by_client$data %>% purrr::map_lgl(~any(.x$remained_same) == TRUE), na.rm = TRUE)
    remained_same_percent<- round(remained_same /  n_at_least_two_timepoints * 100, 1)
    deteriorated<- sum(by_client$data %>% purrr::map_lgl(~any(.x$deteriorated) == TRUE), na.rm = TRUE)
    deteriorated_percent<- round(deteriorated /  n_at_least_two_timepoints * 100, 1)

    tibble::tibble(improved, improved_percent, sig_improved, sig_improved_percent,
                   remained_same, remained_same_percent, deteriorated, deteriorated_percent)

    #Old way of calculating outcomes

    #improved = sum(improve, na.rm = TRUE),
    #improved_percent = round((improved/total_administrations) * 100 , 1),
    #sig_improved = sum(sig_improve, na.rm = TRUE),
    #sig_improved_percent = round((sig_improved/total_administrations) * 100, 1),
    #remained_same = sum(remained_same, na.rm = TRUE),
    #remained_same_percent = round((remained_same/total_administrations) * 100, 1),
    #deteriorated = sum(deteriorated, na.rm = TRUE),
    #deteriorated_percent = round((deteriorated/total_administrations) * 100, 1)



})

#Render the value boxes and the DT table modals that show upon clicking value boxes

output$improved <- renderValueBox({

  ns <- session$ns

  entry_01<- 20
  box1<- valueBox(
    value = paste0(value_box_outcomes() %>% dplyr::pull(1), " ", "(",
                   value_box_outcomes() %>% dplyr::pull(2), "%", ")"),
    icon = tags$i(
      class = "far fa-thumbs-up",
      style = "color: #7FFF00"
    ),
    href = "#",
    subtitle = HTML("<b>Improved</b>")
  )
  box1$children[[1]]$attribs$class<-"action-button"
  box1$children[[1]]$attribs$id<-ns("button_box_01")
  return(box1)

})


output$table_improved<- DT::renderDataTable({

  DT::datatable(

    measurelydashboard::identify_clients_by_outcome_modal(nested_data, improve),
    extensions = 'Scroller', rownames = FALSE,
    options = list(initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'background-color': '#e5e5e5', 'color': '#d35400'});",
      "}"), deferRender = TRUE, scrollY = 200, scroller = TRUE, dom = "t" )

  )


})

observeEvent(input$button_box_01, {
  toggleModal(session,"mod_1","open")
})





output$sig_improved <- renderValueBox({

  ns <- session$ns

  entry_02<- 20
  box2<- valueBox(
    value = paste0(value_box_outcomes() %>% dplyr::pull(3), " ", "(",
                   value_box_outcomes() %>% dplyr::pull(4), "%", ")"),
    icon = tags$i(
      class = "far fa-thumbs-up",
      style = "color: green"
    ),
    href = "#",
    subtitle = HTML("<b>Reliably Improved</b>")
  )
  box2$children[[1]]$attribs$class<-"action-button"
  box2$children[[1]]$attribs$id<-ns("button_box_02")
  return(box2)
})

output$table_sig_improved<- DT::renderDataTable({

  DT::datatable(

    measurelydashboard::identify_clients_by_outcome_modal(nested_data, sig_improve),
    extensions = 'Scroller', rownames = FALSE,
    options = list(initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'background-color': '#e5e5e5', 'color': '#d35400'});",
      "}"), deferRender = TRUE, scrollY = 200, scroller = TRUE, dom = "t" )

  )

})

observeEvent(input$button_box_02, {
  toggleModal(session,"mod_2","open")
})



output$remained_same <- renderValueBox({

  ns <- session$ns

  entry_03<- 20
  box3<- valueBox(
    value = paste0(value_box_outcomes() %>% dplyr::pull(5), " ", "(",
                   value_box_outcomes() %>% dplyr::pull(6), "%", ")"),
    icon = tags$i(
      class = "far fa-thumbs-down",
      style = "color: #d35400"
    ),
    href = "#",
    subtitle = HTML("<b>Did Not Change</b>")
  )
  box3$children[[1]]$attribs$class<-"action-button"
  box3$children[[1]]$attribs$id<- ns("button_box_03")
  return(box3)
})


output$table_remained_same<- DT::renderDataTable({

  DT::datatable(

    measurelydashboard::identify_clients_by_outcome_modal(nested_data, remained_same),
    extensions = 'Scroller', rownames = FALSE,
    options = list(initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'background-color': '#e5e5e5', 'color': '#d35400'});",
      "}"), deferRender = TRUE, scrollY = 200, scroller = TRUE, dom = "t" )

  )

})

observeEvent(input$button_box_03, {
  toggleModal(session,"mod_3","open")
})


output$deteriorated <- renderValueBox({

  ns <- session$ns

  entry_04<- 20
  box4<- valueBox(
    value = paste0(value_box_outcomes() %>% dplyr::pull(7), " ", "(",
                   value_box_outcomes() %>% dplyr::pull(8), "%", ")"),
    icon = tags$i(
      class = "far fa-thumbs-down",
      style = "color: #CD5C5C"
    ),
    href = "#",
    subtitle = HTML("<b>Deteriorated</b>")
  )
  box4$children[[1]]$attribs$class<-"action-button"
  box4$children[[1]]$attribs$id<- ns("button_box_04")
  return(box4)
})


output$table_deteriorated<- DT::renderDataTable({

  DT::datatable(

    measurelydashboard::identify_clients_by_outcome_modal(nested_data, deteriorated),
    extensions = 'Scroller', rownames = FALSE,
    options = list(initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'background-color': '#e5e5e5', 'color': '#d35400'});",
      "}"), deferRender = TRUE, scrollY = 200, scroller = TRUE, dom = "t" )

  )

})

observeEvent(input$button_box_04, {
  toggleModal(session,"mod_4","open")
})

}

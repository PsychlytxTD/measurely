#' Clinical Outcomes By Measure Plot
#'
#' Make the plot for displaying clinical outcomes by individual measures
#'
#' @param id A string to create the namespace
#'
#' @export


make_outcome_valueboxes_UI<- function(id) {

  ns<- NS(id)

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
  )


}


#' Clinical Outcomes By Measure Plot
#'
#' Make the plot for displaying clinical outcomes by individual measures
#'
#' @param nested_data A reactive nested dataframe containing subscale scores for each individual.
#'
#' @export


make_outcome_valueboxes<- function(input, output, session, nested_data) {


#Wrangle the data for the value boxes

value_box_outcomes<- reactive({

  total_administrations<- nrow(nested_data())

  nested_data() %>% dplyr::summarise(

    improved = sum(improve, na.rm = TRUE),
    improved_percent = round((improved/total_administrations) * 100 , 1),
    sig_improved = sum(sig_improve, na.rm = TRUE),
    sig_improved_percent = round((sig_improved/total_administrations) * 100, 1),
    remained_same = sum(remained_same, na.rm = TRUE),
    remained_same_percent = round((remained_same/total_administrations) * 100, 1),
    deteriorated = sum(deteriorated, na.rm = TRUE),
    deteriorated_percent = round((deteriorated/total_administrations) * 100, 1)

  )

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
    subtitle = HTML("<b>Improvements</b>")
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
    subtitle = HTML("<b>Reliable* Improvements</b>")
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
    subtitle = HTML("<b>No Change</b>")
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
    subtitle = HTML("<b>Deteriorations</b>")
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

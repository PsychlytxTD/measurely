#' Simplifed Application Reliable Change Method
#'
#' Generates simplified application widgets to select reliable change method.
#'
#' @param id String to create a unique namespace.
#'
#' @export

simplified_method_widget_UI<- function(id) {

  ns<- NS(id) #Set the namespace

  tagList( #Create a tag list containing the widgets for reliable change method selection and confidence interval width selection

    br(),

    radioButtons(ns("reliable_change_method"), h4(tags$strong("Select Reliable Change Method")), choices = c("Nunnally & Bernstein (1994)", "Jacobson & Truax (1991)"))

  )


}


#' Reliable Change Method & Custom Confidence Intervals
#'
#' Generates widgets to select reliable change method and custom confidence interval width (if custom intervals are selected)
#'
#' @param holding_data A dataframe representing the client's statistics in the DB holding table.
#'
#' @export



simplified_method_widget<- function(input, output, session, holding_data) { #In the parent app, need to pass a character vector of subscale names
  #(underscore replacing white space) in callModule()


  observe({

      updateRadioButtons(session, "reliable_change_method", selected = holding_data()$method[1]) #If there is existing data, use the existing value for reliable change method
      #to preopulate widget

  })



  reactive({

    return(req(input$reliable_change_method)) #Return the reliable change method

  })


}

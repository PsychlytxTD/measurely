#' Reliable Change Method & Custom Confidence Intervals
#'
#' Generates widgets to select reliable change method and custom confidence interval width (if custom intervals are selected)
#'
#' @param id String to create a unique namespace.
#'
#' @export

method_widget_UI<- function(id) {

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
#'@param existing_data A dataframe indicating the client's existing available data for this measure.
#'
#' @export



method_widget<- function(input, output, session, existing_data) { #In the parent app, need to pass a character vector of subscale names
                                                                      #(underscore replacing white space) in callModule()


  observe({

    if(length(existing_data()$method) >= 1) {

      updateRadioButtons(session, "reliable_change_method", selected = existing_data()$method[1]) #If there is existing data, use the existing value for reliable change method
                                                                                                  #to preopulate widget

    }

  })



  reactive({

    return(req(input$reliable_change_method)) #Return the reliable change method

    })


}

#' Simplified Manual Data Entry Widgets
#'
#' Creates layout and widgets for simple application manual data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export


simplified_manual_data_UI<- function(id) {

  ns<- NS(id) #Set the namespace


  uiOutput(ns("simplified_manual_data_output"))

}


#' Simplified Manual Data Entry Widgets
#'
#' Creates layout and widgets for simple application manual data entry
#'
#' @param scale_entry The item scores passed from the online scale (if completed).
#'
#' @export



#The scale_entry_scores object refers to the item scores from the online scale (if completed)

simplified_manual_data<- function(input, output, session, scale_entry) {


  simplified_manual_data_output<- renderUI({

    ns <- session$ns


  tagList(


    fluidRow(

      column(width = 4,

             textInput(ns('item_scores'), 'Inputted Item Scores', "0,1,2,etc")),



      column(width = 4,

             dateInput(ns("date"), "Date", format = "dd/mm/yyyy")

      )),

    fluidRow(

      column(width = 4,

             actionButton(ns("submit_scores"), "Submit", class = "submit_data"),

             tags$head(tags$style(".submit_data{color:#d35400;}"))

      ))

  )


  })




  observe({

    updateTextInput(session, "item_scores", value = scale_entry()) #If the online scale was completed, pass these item scores directly into
    #the manually-entry field. Thus, item scores always come from one place
    #when used for subsequent processing.

  })

  #Return manually entered items scores and date as seperate objects in a list, for further analyis



  date<- reactive({ input$date })

  item_scores<- reactive({ as.numeric(unlist(strsplit(input$item_scores, ","))) })   #Collect item scores and store in vector

  eventReactive(input$submit_scores, { list( date = date(), item_scores = item_scores(), submit_scores_button_value = input$submit_scores ) })
  #On click of 'submit' questionnaire scores, return list of date, item scores and the value of the submit button (to use to trigger db writing.)


}

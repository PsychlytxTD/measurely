#' Manual Data Entry Widgets
#'
#' Creates layout and widgets for manual data entry
#'
#' @param id String to create a unique namespace.
#'
#' @export


manual_data_UI<- function(id) {

  ns<- NS(id) #Set the namespace



  tagList(


    fluidRow(

      column(width = 4,

             textInput(ns('item_scores'), 'Inputted Item Scores', "0,1,2,etc")),



      column(width = 4,

             dateInput(ns("date"), "Date", format = "dd/mm/yyyy")

      )),

    fluidRow(

      column(width = 4,

             actionButton(ns("submit_scores"), "Submit Measure Responses", class = "submit_data"),

             tags$head(tags$style(".submit_data{color:#d35400;}"))

      ),

      column(width = 3,

             htmlOutput(ns("item_warning"))

             )

      )

  )



}


#' Manual Entry Widgets
#'
#' Creates layout and widgets for manual data entry
#'
#' @param scale_entry The item scores passed from the online scale (if completed).
#'
#' @param do_recode A logical, indicating whether or not to apply the recoding function.
#'
#' @param items_to_recode A numeric vector indicating the items that should be recoded, of the form c(3,5,6) etc.
#'
#' @param recoding_key A string indicating the recoding pattern to use, of the form '0=;1=5;2=4;3=3;4=2;5=1;6=0' etc.
#'
#' @param expected_responses A single numerical value indicating the expected number of responses for the measure.
#'
#' @export



#The scale_entry_scores object refers to the item scores from the online scale (if completed)

manual_data<- function(input, output, session, scale_entry, do_recode = FALSE, items_to_recode = NULL, recoding_key = NULL, expected_responses) {

  observe({

    updateTextInput(session, "item_scores", value = scale_entry()) #If the online scale was completed, pass these item scores directly into
    #the manually-entry field. Thus, item scores always come from one place
    #when used for subsequent processing.

  })

  #Return manually entered items scores and date as seperate objects in a list, for further analyis



  date<- reactive({ input$date })


  #Collect item scores and store in vector. Recode items if necessary.

  item_scores<- reactive({

    item_scores<- as.numeric(unlist(stringr::str_split(input$item_scores, ",")))

    if(do_recode == TRUE) {

      recoded_items<- car::recode(item_scores[c(items_to_recode)], paste(recoding_key))

      item_scores[c(items_to_recode)]<- recoded_items
    }

    return(item_scores)

    })


  output$item_warning<- renderText({

    missing<- which(is.na(item_scores()))

  if(any(is.na(item_scores()))) {
   paste("<span style=\"color:red\"> Please provide a response to item", missing, "</span>")
   }

  })


  observeEvent(input$submit_scores, {

    if(length(item_scores()) != expected_responses) {

      sendSweetAlert(
        session = session,
        title = "Incorrect number of responses!!",
        text = "Please make sure you provide only response per question",
        type = "error"
      )
    }

  })


  eventReactive(input$submit_scores, {

              if(length(item_scores()) == expected_responses) {

              list( date = date(), item_scores = item_scores(), submit_scores_button_value = input$submit_scores )

                } else {

                  return(NULL)

                }

    })
  #On click of 'submit' questionnaire scores, return list of date, item scores and the value of the submit button (to use to trigger db writing.)


}

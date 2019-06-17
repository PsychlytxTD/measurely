#' Cutoff widget module
#'
#' Generates the widget with correct default values for the reliability widget and references.
#'
#' @param id String to create a unique namespace.
#'
#' @export


generate_cutoff_widget_UI <- function(id) {

  ns <- NS(id) #Set the namespace

  fluidRow(uiOutput(ns("cutoff_widget_out")))

}



#' Cutoff widget module
#'
#' Generates the widget with correct default values for the reliability widget and references.
#'
#' @param title A string (white space allowed) indicating the name of the subscale, to be used as a panel title.
#'
#' @param brief_title An abbreviated title or acronym.
#'
#' @param measure A string indicating the global measure.
#'
#' @param subscale A string (underscores should replace white space) indicating the name of the subscale for which the function is being used (e.g. "Anxiety").
#'
#' @param population_quantity A numeric value of possible populations from which the user can select.
#'
#' @param populations A list of strings (underscores should replace white space) indicating the possible range of populations.
#'
#' @param input_population A string (reactive value) representing the name of the selected population.
#'
#' @param sds A list of numeric values representing the standard deviations for all populations on that subscale.
#'
#' @param means A list of numeric values representing the means for all populations on that subscale.
#'
#' @param mean_sd_references A list of strings indicating the references for each mean/standard deviation by population.
#'
#' @param reliabilities A list of numeric values representing the test-retest reliabilities for all populations on that subscale.
#'
#' @param reliability_references A list of strings indicating the references for each reliability value by population.
#'
#' @param cutoff_values A list of concatenated numeric values representing the cutoff values on this subscale for each population.
#'
#' @param cutoff_labels A list of concatenated strings indicating the cutoff value descriptors. Use rep() function to multiple by populations.
#'
#' @param cutoff_references A list of strings indicating the references for each reliability value by population.
#'
#' @param cutoff_quantity A numeric value indicating the number of cutoff scores for the subscale.
#'
#' @param items A numeric vector representing an item index for the subscale.
#'
#' @param max_score A numeric value indicating maximum possible score on the subscale.
#'
#' @param min_score A numeric value indicating minimum possible score on the subscale.
#'
#' @param description A string indicating a description of subscale's properties, to display in report
#'
#' @param sample_overview A string indicating a description of each research sample (different for each population)
#'
#' @param journal_references The string indicating a full reference for each research sample for mean and sd.
#'
#' @param existing_data A dataframe representing the client's existing available data for this measure.
#'
#' @export


#Subscale list parameters (mostly lists themselves) are arguments to the module function.

generate_cutoff_widget <-function(input, output, session, title, brief_title, measure, subscale, population_quantity, populations, input_population, sds,means,
                                  mean_sd_references, reliabilities, reliability_references, cutoff_values, cutoff_labels, cutoff_references,
                                  cutoff_quantity, items, max_score, min_score, description, sample_overview, journal_references, existing_data) {

    cutoff_widget_reac <- reactive({

      ns <- session$ns #Set the namespace

      subscale_title<- div(fluidRow(column(width = 7, offset = 3,

      h4(tags$strong(title)) #The name of the subscale should appear centred, above the widgets

      )))


      arr_list<- params_list_maker(
        title = title,
        measure = measure,
        subscale = subscale,
        population_quantity = population_quantity,
        populations = populations,
        input_population = input_population(),
        means = means,
        sds = sds,
        mean_sd_references = mean_sd_references,
        reliabilities = reliabilities,
        reliability_references = reliability_references,
        cutoff_values = cutoff_values,
        cutoff_labels = cutoff_labels,
        cutoff_references = cutoff_references,
        cutoff_quantity = cutoff_quantity
      )[c(8, 9, 10, 11, 12, 14)] #Return the correct list of paramaters corresponding to the selected population


      index<- order(arr_list$cutoff_values)                 #Ensure that cutoff values are ordered (smallest to largest) to prevent errors in plotting.
      arr_list$cutoff_values<- arr_list$cutoff_values[index]
      arr_list$cutoff_labels<- arr_list$cutoff_labels[index]
      arr_list$cutoff_references<- arr_list$cutoff_references[index]

     #Widgets will be stored in this list before being called in do.call()

      cutoff_widget_list <-

        #Params_list_maker() creates a list of lists, each containing parameters corresponding to a different population
         #It will return a single list matching the population selected by the user

        purrr::pmap(arr_list,

       #Set these relevant parameters as function arguments (need to do this or the code won't run).

        function(cutoff_value_ids, cutoff_label_ids, cutoff_values, cutoff_labels, cutoff_references, cutoff_reference_ids) {


          div(
          column(width = 2,

            textInput(inputId = ns(cutoff_label_ids), label = "Description", value = cutoff_labels),

            numericInput(inputId = ns(cutoff_value_ids), label = "Value", value = cutoff_values),

            textInput(inputId = ns(cutoff_reference_ids), label = "Reference", value = cutoff_references),

            hr()

          ))


        })


      if(length(existing_data()$cutoff_value_1) >= 1) {    #If the client has existing data, pull in the cutoff-related info and use it to prepopulate cutoff widgets
                                                           #This allows the user to save their settings

        updateNumericInput(session, "cutoff_value_id_1", "Value", value = existing_data()$cutoff_value_1[1])
        updateNumericInput(session, "cutoff_value_id_2", "Value", value = existing_data()$cutoff_value_2[1])
        updateNumericInput(session, "cutoff_value_id_3", "Value", value = existing_data()$cutoff_value_3[1])
        updateNumericInput(session, "cutoff_value_id_4", "Value", value = existing_data()$cutoff_value_4[1])
        updateNumericInput(session, "cutoff_value_id_5", "Value", value = existing_data()$cutoff_value_5[1])
        updateNumericInput(session, "cutoff_value_id_6", "Value", value = existing_data()$cutoff_value_6[1])

        updateNumericInput(session, "cutoff_label_id_1", "Description", value = existing_data()$cutoff_label_1[1])
        updateNumericInput(session, "cutoff_label_id_2", "Description", value = existing_data()$cutoff_label_2[1])
        updateNumericInput(session, "cutoff_label_id_3", "Description", value = existing_data()$cutoff_label_3[1])
        updateNumericInput(session, "cutoff_label_id_4", "Description", value = existing_data()$cutoff_label_4[1])
        updateNumericInput(session, "cutoff_label_id_5", "Description", value = existing_data()$cutoff_label_5[1])
        updateNumericInput(session, "cutoff_label_id_6", "Description", value = existing_data()$cutoff_label_6[1])

        updateTextInput(session, "cutoff_reference_id_1", "Reference", value = existing_data()$cutoff_reference_1[1])
        updateTextInput(session, "cutoff_reference_id_2", "Reference", value = existing_data()$cutoff_reference_2[1])
        updateTextInput(session, "cutoff_reference_id_3", "Reference", value = existing_data()$cutoff_reference_3[1])
        updateTextInput(session, "cutoff_reference_id_4", "Reference", value = existing_data()$cutoff_reference_4[1])
        updateTextInput(session, "cutoff_reference_id_5", "Reference", value = existing_data()$cutoff_reference_5[1])
        updateTextInput(session, "cutoff_reference_id_6", "Reference", value = existing_data()$cutoff_reference_6[1])

      }



      #Call the the subscale name (to appear as heading) and call the div containing the widgets

      do.call(tagList, list(subscale_title, cutoff_widget_list))


    })


    #Render the widgets

    output$cutoff_widget_out <- renderUI({

      cutoff_widget_reac()

    })

    #Make sure the values for the mean widgets are accessible even if tab is not clicked

    outputOptions(output, "cutoff_widget_out", suspendWhenHidden = FALSE)


    reactive({    #use the param_list_maker() function to access all the needed cutoff widget ids (regardless)
                  #of how many there are

      list( req(input$cutoff_label_id_1), req(input$cutoff_label_id_2), req(input$cutoff_label_id_3), req(input$cutoff_label_id_4), req(input$cutoff_label_id_5),
            req(input$cutoff_label_id_6), req(input$cutoff_value_id_1), req(input$cutoff_value_id_2), req(input$cutoff_value_id_3), req(input$cutoff_value_id_4),
            req(input$cutoff_value_id_5), req(input$cutoff_value_id_6), req(input$cutoff_reference_id_1), req(input$cutoff_reference_id_2),
            req(input$cutoff_reference_id_3), req(input$cutoff_reference_id_4), req(input$cutoff_reference_id_5), req(input$cutoff_reference_id_6) )

    })



  }

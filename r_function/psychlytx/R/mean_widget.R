#' Mean widget module
#'
#' Generates the widget with correct default values for the mean widget and references.
#'
#' @param id String to create a unique namespace.
#'
#' @export


generate_mean_widget_UI <- function(id) {

  ns <- NS(id) #Set namespace


  fluidRow(uiOutput(ns("mean_widget_out")))


}


#' Mean widget module
#'
#' Generates the widget with correct default values for the mean widget and references.
#'
#' Apply Initial Settings Through Population Selection
#'
#' Select an initial population thereby applying settings for analyses
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



generate_mean_widget <-function(input, output, session, title, brief_title, measure, subscale, population_quantity, populations, input_population, sds, means,
                                mean_sd_references, reliabilities, reliability_references, cutoff_values, cutoff_labels, cutoff_references, cutoff_quantity, items, max_score, min_score,
                                description, sample_overview, journal_references, existing_data) {


    mean_widget_reac <- reactive({

      ns <- session$ns #Set the namespace

      subscale_title<- div(fluidRow(column(width = 7, offset = 3,

                                           h4(tags$strong(title)) #The name of the subscale should appear centred, above the widgets

      )))

    #Widgets will be stored in this list before being called in do.call()

      mean_widget_list <-

       #Params_list_maker() creates a list of lists, each containing parameters corresponding to a different population
        #It will return a single list matching the population selected by the user

        purrr::pmap(params_list_maker(
          title = title,
          measure = measure,
          subscale = subscale,
          population_quantity = population_quantity,
          populations = populations,
          input_population = input_population(), #input_population() is population (reactive object) selected from the selectInput widget in the parent app
          means = means,
          sds = sds,
          mean_sd_references = mean_sd_references,
          reliabilities = reliabilities,
          reliability_references = reliability_references,
          cutoff_values = cutoff_values,
          cutoff_labels = cutoff_labels,
          cutoff_references = cutoff_references,
          cutoff_quantity = cutoff_quantity
        )[c(1, 3, 5, 13)],

       #Set these relevant parameters as function arguments (need to do this or the code won't run)

        function(mean_sd_rel_ids, means, mean_sd_references, mean_sd_rel_reference_ids, existing_data) {

         #Create a div containing the dynamically generated widgets

          div(column(width = 2,

            numericInput(inputId = ns(mean_sd_rel_ids), label = tags$strong("Mean"), value = means),

            textInput(inputId = ns(mean_sd_rel_reference_ids), label = "Reference", value = mean_sd_references),

            hr()

          ))

        }

       )


      if(length(existing_data()$mean) >= 1) { #Pull in the settings (if existing data is available) to prepopulate widgets with client's settings

      updateNumericInput(session, "mean_sd_rel_value_id", "Mean", value = existing_data()$mean[1])

      updateTextInput(session, "mean_sd_rel_reference_id", "Reference", value = existing_data()$mean_reference[1])

      }

      do.call(tagList, list(subscale_title, mean_widget_list))

    })


    #Render the widgets

    output$mean_widget_out <- renderUI({

      mean_widget_reac()


    })


    #Make sure the values for the mean widgets are accessible even if tab is not clicked

    outputOptions(output, "mean_widget_out", suspendWhenHidden = FALSE)

    #Need to finish the module with reactive value list containing id of value widget & reference widget - so these can be accessed by another module.
    #Add req() so the input values aren't NULL initially


    reactive({ list( req(input$mean_sd_rel_value_id), req(input$mean_sd_rel_reference_id) ) })




  }

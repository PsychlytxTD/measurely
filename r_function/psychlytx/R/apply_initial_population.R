#' Apply Initial Settings Through Population Selection
#'
#' Select an initial population thereby applying settings for analyses
#'
#' @param id String to create the namespace
#'
#' @export


apply_initial_population_UI<- function(id) {

  ns <- NS(id)

  tagList(

    fluidPage(

      fluidRow(

      column(width = 10, offset = 1,
             checkboxInput(ns("first_time_scale_completion"), h4(tags$strong("Check here if your client is completing this questionnaire for the first time.", style = "color: #d35400")), width = "100%" #Checking the 'first' box should trigger prompt to select a population
                                           ))),

    conditionalPanel(condition = "input.first_time_scale_completion == 1", ns = ns,

                     tagList(
                         fluidRow(

                           #Make info icon to explain why it is important to select a population

                           column(width = 8, offset = 2, HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;'),h4(tags$strong("Select A Group With Similar Characteristics To Your Client")) %>%
                                    helper( type = "inline", title = "Why select a client group?", colour = "#283747",
                                            content = c("<b>Choosing a client group ensures that:</b>",
          "",
          "<b>1.</b> Appropriate research statistics (e.g. means and standard deviations) are used to estimate
          measurement error when calculating change in scores over time.",
          "",
          "<b>2.</b> Suitable classifications of symptom severity appear in your client's clinical report. ",
          "",
          "",
          "You may customise your client's settings if desired."), size = "m"
                                    ))),

    fluidRow(
      column(width = 6, offset = 3,

      uiOutput(ns("select_population"))

    )),

    fluidRow(
      column(width = 5, offset = 3,

             uiOutput(ns("sample_description"))
      )),

    br(),
    br(),
    br(),

    fluidRow(
      column(width = 3, offset = 3,

             uiOutput(ns("other_population")),

             actionButton(ns("go_custom_settings"), "Customise Client Settings (Optional) ", class = "submit_data")

             )))),

  fluidRow(

    column(width = 12,

          titlePanel(span(tagList(icon("edit", lib = "font-awesome", class = "far fa-edit"),
                            h4(tags$b("Complete the questionnaire below and and click"),
                               tags$code("Submit.", style = "color:#d35400")))))

    ))

    ))

}



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
#' @param tabsetpanel_id A string indicating a panel id to allow automatic switching between panels.
#'
#' @export


apply_initial_population<- function(input, output, session, title, brief_title, measure, subscale, population_quantity, populations, sds, means,
                                    mean_sd_references, reliabilities, reliability_references, cutoff_values, cutoff_labels, cutoff_references, cutoff_quantity,
                                    items, max_score, min_score, description, sample_overview, journal_references, existing_data, tabsetpanel_id = "tabset") {

  parent_session <- get("session", envir = parent.frame(2)) #Need to ensure correct scoping - want R to look in the parent app not the module


  observeEvent(input$go_custom_settings, {
    updateTabsetPanel(session = parent_session, tabsetpanel_id,  #Direct user to new tab upon button click
                      selected = paste("go_custom_settings"))
  })



  output$select_population<- renderUI({

    ns <- session$ns

    existing_data() #Need to take a dependency on existing data so that original population choices reinstate if client with no data is selected.

    population_labels<- purrr::map(populations, ~ gsub("_", " ", .x)) #The population choices that are visible to users should have no white space

    population_list<- purrr::set_names(populations, population_labels)


    selectInput(ns("population"), "",
                choices = population_list, width = "60%") #Make the population selection widget


  })

  outputOptions(output, "select_population", suspendWhenHidden = FALSE)



  observe({


    updateSelectInput(session, "population", selected = existing_data()$population[1], choices =  existing_data()$population[1]) #Update the population widget based on user's
                                                                                                                                 #existing data to reinstill their settings.

  })



  output$other_population<- renderUI({

    ns <- session$ns

    req(input$population)

    if(input$population == "Other") { #Create text widget to input name of alternative popopulation, if 'Other' is chosen during intitial population selection.

      textInput(ns("other_population_widget"), h5("Enter the name of a new client group. Then specifiy group-appropriate statistics
                                                  and references by clicking below. The values you define will be used in
                                                  analyses and will appear in the clinical report."))

    }


  })

  outputOptions(output, "other_population", suspendWhenHidden = FALSE)


  output$sample_description <- renderUI({

    #Make functionality to create icon that user can click to reveal information about the research sample upon with statistics
    #for a given population are based.

    ns <- session$ns

    req(input$population)

    sample_info_params<- purrr::pmap(list(

      #From the subscale info list, iterate over the sublists we need (i.e. populations, journal_references & sample_overview)
      #Create a final list with the correct elements taken from each of these three sublists, corresponding to the population selected.

      populations = populations,
      journal_references = journal_references,
      sample_overview = sample_overview

    ),

    function(populations, journal_references, sample_overview) {


      #Create a list of paramaters for each unique population to be accessible in the modal popup, generate by icon click.

      list( populations = populations, journal_references = journal_references, sample_overview = sample_overview )

    }

    )


    #Set the names of each list to be the population names (underscores replacing white space)

    names(sample_info_params)<- populations


    if( !(input$population %in% populations )) {    #Need to make sure that stored settings for 'Other' are retrieved.

      selected_sample_info<- sample_info_params[["Other"]]

    } else {


    #Use the population_selected object to return the correct list (i.e. the one containing the values of the population selected by the user)

    selected_sample_info<- sample_info_params[[input$population]]

    }

    h4("Learn more about this client group") %>% #Make the population info popup modal
      helper(
             colour = "#283747",
             size = "m",
             type = "inline",
             title = paste(gsub("_", " ", selected_sample_info$populations)),
             content = c("Below is information about the research sample that was employed to provide the mean and standard deviation for this client group. Means and standard deviations are used in reliable change calculations and to show how severe your client's symptoms are relative to others in his or her group.",
                         "",
                         paste("<b>Sample Characteristics:</b>", " ", selected_sample_info$sample_overview),
                         "",
                         paste("<b>Reference:</b>", " ", selected_sample_info$journal_references)
                         ))
  })







  reactive({

    validate(need(length(input$population) >= 1, "Please select a client."))

    if(input$population == "Other") {

      return(input$other_population_widget) #Return the name of the custom-defined population, if selected.

    } else {

     return(input$population) #Return the selected population, to be accessed by modules downstream.

    }

    })

}


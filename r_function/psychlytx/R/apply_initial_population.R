#' Apply Initial Settings Through Population Selection
#'
#' Select an initial population thereby applying settings for analyses
#'
#' @param id String to create the namespace
#'
#' @export


apply_initial_population_UI<- function(id) {

  ns <- NS(id)

  div(id = ns("reset_id"),

  tagList(

    fluidPage(

      fluidRow(

        column(width = 10, offset = 1,
              uiOutput(ns("assessment_stage_widget"))
        )
      ),

      conditionalPanel(condition = "input.assessment_stage == 'first'", ns = ns,

                       tagList(

                         fluidRow(
                           column(width = 7, offset = 2,

                                  uiOutput(ns("sample_description")),

                                  uiOutput(ns("select_population"))

                           )),

                         br(),

                         fluidRow(
                           column(width = 10, offset = 2,

                                  uiOutput(ns("other_population"))



                           )),

                         h5("Optional: Set custom cutoff values and reliable change statistics for this client by navigating to the client settings page.")

                         )),


      conditionalPanel(condition = "input.assessment_stage == 'last'", ns = ns,

                       tagList(
                         fluidPage(
                           sidebarLayout(
                             sidebarPanel(width = 11,
                                          tagList(
                                            titlePanel(span(tagList(icon("chart-bar", lib = "font-awesome")),
                                                            h3(tags$b("Record Your Client's Therapy & Attendance Outcomes")))),
                                            br(),
                                            selectizeInput(ns("principal_diagnosis"), "Primary Diagnosis", choices = psychlytx::diagnosis_list,
                                                           options = list(
                                                             placeholder = 'Type a word or scroll down..',
                                                             onInitialize = I('function() { this.setValue(""); }')
                                                           ),
                                                           multiple = FALSE, width = '60%'),
                                            selectizeInput(ns("secondary_diagnosis"), "Secondary Diagnosis", choices = psychlytx::diagnosis_list,
                                                           options = list(
                                                             placeholder = 'Type a word or scroll down..',
                                                             onInitialize = I('function() { this.setValue(""); }')
                                                           ),
                                                           width = '60%'),
                                            textInput(ns("referrer"), "Referrer", value = "", width = '50%'),
                                            selectInput(ns("attendance_schedule"), "Schedule of Attendance", c("", "Varied", "Twice A Week", "Once A Week", "Once a Fortnight", "Once Every 3 Weeks", "Once A Month", "Greater Than 1 Month Apart"), width = '40%'),
                                            numericInput(ns("cancellations"), "Number of Cancellations", value = "", width = '20%'),
                                            numericInput(ns("non_attendances"), "Number of Non-Attendances (No Notice Given)", value = "", width = '20%'),
                                            numericInput(ns("attendances"), "Number of Sessions Attended", value = "", width = '20%'),
                                            radioButtons(ns("premature_dropout"), "Premature Dropout", choices = c("Yes", "No"), selected = character(0), width = '20%'),
                                            selectizeInput(ns("therapy"), "Therapeutic Approach Used", choices = psychlytx::therapies_list,
                                                           options = list(
                                                             placeholder = 'Type a word or scroll down..',
                                                             onInitialize = I('function() { this.setValue(""); }')
                                                           ),
                                                           width = '50%'),
                                            selectInput(ns("funding"), "Funding Source", choices = c("", "Entirely Self-Funded", "Partly Medicare Funded", "Entirely Medicare Funded (Bulk Billed)",
                                                                                                     "Private Health Fund", "National Disability Insurance Scheme (NDIS)",
                                                                                                     "WorkCover", "Transport Accident Commission (TAC)",
                                                                                                     "Department of Veterans Affairs (DVA)",
                                                                                                     "Victims of Crime Assistance Tribunal (VOCAT)",
                                                                                                     "Other"), width = '40%'),
                                            conditionalPanel(condition = "input.funding == 'Private Health Fund'", ns = ns,

                                                             selectizeInput(inputId = ns("private_health_fund"), label = "Select Private Health Fund", width = '60%',
                                                                            choices = c("", "ACA", "ahm", "Apia", "Australian Unity", "Allianz", "Budget Direct", "Bupa",
                                                                                        "CBHS", "CDH", "CUA", "Defence Health", "Doctors Health Fund", "Emergency Services Health",
                                                                                        "Frank Health Insurance", "GMF", "GMHBA", "GUHealth", "HBA", "HBF", "HCF", "HealthCare",
                                                                                        "Health Partners", "health.com.au", "HIF", "IMAN Health Cover", "Latrove Health", "Medibank",
                                                                                        "Mildura Health Fund", "Navy Health", "NIB", "Nurses & Midwives Health", "onemedifund",
                                                                                        "Peoplecare", "Phoenix Health FUnd", "Police Health", "Qantas Insurance", "Queensland Country Health Fund",
                                                                                        "Researve Bank Health Society", "RT Health Insurance", "St.LukesHealth", "Teachers Health",
                                                                                        "Transport Health", "TUH", "UniHealth", "Westfund Health"),
                                                                            options = list(
                                                                              placeholder = 'Type a word or scroll down..',
                                                                              onInitialize = I('function() { this.setValue(""); }')
                                                                            ))

                                            ),

                                            selectInput(ns("out_of_pocket"), "Out-Of-Pocket Expense", c("", "None", "$1-$10",
                                                                                                        "$11-$20", "$21-$30", "$31-$40",
                                                                                                        "$41-$50", "$51-$60",
                                                                                                        "$61-$70", "$71-$80",
                                                                                                        "$81-$90", "$91-$100",
                                                                                                        "$101-$110", "$111-$120",
                                                                                                        "$121-$130", "$131-140",
                                                                                                        "$141-$150", "$151-$160",
                                                                                                        "$161-$170", "$171-$180",
                                                                                                        "$181-$190", "$191-$200",
                                                                                                        "$201-$210", "$211-$220",
                                                                                                        "$221-$230", "$231-$240",
                                                                                                        "$241-$250", "$251-$260",
                                                                                                        "$261-$270", "$271-$280",
                                                                                                        "$281-$290", "$291-$300",
                                                                                                        "More than $300"), width = '20%'),
                                            actionButton(ns("submit_analytics_posttherapy"), "Submit Clinical Outcomes", class = "submit_button")

                                          )),

                             mainPanel()

                           )))

      )

    )))

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
#' @param plot_shading_gap A numeric value subtracted from a cutoff score to indicate the amount of white space between shaded rectangles.
#'
#' @param plot_cutoff_label_start A numeric value added to a cutoff score to indicate how far up the cutoff label appears.
#'
#' @param plot_cutoff_label_size A numeric value indicating the font size of the cutoff labels.
#'
#' @param description A string indicating a description of subscale's properties, to display in report
#'
#' @param sample_overview A string indicating a description of each research sample (different for each population)
#'
#' @param journal_references The string indicating a full reference for each research sample for mean and sd.
#'
#' @param existing_data A dataframe representing the client's existing available data for this measure.
#'
#' @param pool A pooled db connection.
#'
#' @param selected_client A string indicating the unique id of the selected client.
#'
#' @param clinician_id A string indicating the unique id of the clinician.
#'
#' @param practice_id String indicating the id of the practice.
#'
#' @export


apply_initial_population<- function(input, output, session, title, brief_title, measure, subscale, population_quantity, populations, sds, means,
                                    mean_sd_references, reliabilities, reliability_references, cutoff_values, cutoff_labels, cutoff_references, cutoff_quantity,
                                    items, max_score, min_score, plot_shading_gap, plot_cutoff_label_start, plot_cutoff_label_size, description,
                                    sample_overview, journal_references, existing_data, pool, selected_client, clinician_id, practice_id) {


  observeEvent(selected_client(), {

    shinyjs::reset("reset_id")

  })


  output$assessment_stage_widget<- renderUI({

    ns<- session$ns

    if(nrow(existing_data()) >= 1) {

      checkboxGroupInput(ns("assessment_stage"), "", c(
        "My client is continuing therapy after this assessment." = "ongoing",
        "My client is finishing therapy and this will be the last assessment." = "last"),
        selected = "ongoing")

    } else {

      checkboxGroupInput(ns("assessment_stage"), "", c(
        "My client is completing this measure for the first time." = "first"),
        selected = "first")

    }

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

    ns <- session$ns

    #Make functionality to create icon that user can click to reveal information about the research sample upon with statistics
    #for a given population are based.


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

    h4("Select A Group With Similar Characteristics To Your Client") %>% #Make the population info popup modal
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

  analytics_posttherapy<- eventReactive(input$submit_analytics_posttherapy, {

    #For now use temp vars to check that writing works: in reality, at clinician argument to function
    # and bring it in from Shiny Proxy login details

    client_id<- selected_client()

    posttherapy_analytics_items<- list( req(clinician_id), req(client_id), input$principal_diagnosis, input$secondary_diagnosis, input$referrer, input$attendance_schedule,
                                        input$cancellations, input$non_attendances, input$attendances, input$premature_dropout, input$therapy, input$funding, input$private_health_fund,
                                        input$out_of_pocket ) %>% purrr::set_names(c("clinician_id", "client_id", "principal_diagnosis",
                                                                                     "secondary_diagnosis", "referrer", "attendance_schedule", "cancellations", "non_attendances", "attendances", "premature_dropout", "therapy", "funding", "private_health_fund",
                                                                                     "out_of_pocket"))


    list( posttherapy_analytics_items ) %>% {

      tibble::tibble(

        clinician_id = purrr::map_chr(., "clinician_id"),
        client_id = purrr::map_chr(., "client_id"),
        practice_id = practice_id,
        principal_diagnosis = purrr::map_chr(., "principal_diagnosis"),
        secondary_diagnosis = purrr::map_chr(., "secondary_diagnosis"),
        referrer = purrr::map_chr(., "referrer"),
        attendance_schedule = purrr::map_chr(., "attendance_schedule"),
        cancellations = purrr::map_chr(., "cancellations"),
        non_attendances = purrr::map_dbl(., "non_attendances"),
        attendances = purrr::map_dbl(., "attendances"),
        premature_dropout = purrr::map_chr(., "premature_dropout"),
        therapy = purrr::map_chr(., "therapy"),
        funding = purrr::map_chr(., "funding"),
        private_health_fund = purrr::map_chr(., "private_health_fund"),
        out_of_pocket = purrr::map_chr(., "out_of_pocket")

      )

    } %>% dplyr::mutate(id = uuid::UUIDgenerate()) %>% dplyr::select(id, everything())


  })


  observe({

    #pass the analytics dataframe in and append the client table in db

    dbWriteTable(pool, "posttherapy_analytics",  data.frame(req(analytics_posttherapy())), row.names = FALSE, append = TRUE) ;
    sendSweetAlert(
      session = session,
      title = "Successful Completion!!",
      text = "End-of-therapy outcome data has been submitted.",
      type = "success"
    )

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

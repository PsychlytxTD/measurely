#' Pre-Therapy Analytics Widgets
#'
#' Module generates pre-therapy analytics widgets
#'
#' @param id String to create a unique namespace.
#'
#' @export

analytics_pretherapy_UI<- function(id) {

  ns<- NS(id)

                   tagList(
                     sidebarLayout(
                      sidebarPanel(width = 10,
                     titlePanel(span(tagList(icon("clipboard", lib = "font-awesome")), h3(tags$b("Please Complete Client Registration.")))),
                     br(),
                     br(),
                     column(width = 7, a(tags$strong("We take privacy seriously. View our policy here."),
                                                    href = "http://www.psychlytx.com", style = "color:#d35400; text-decoration: underline;") ),
                     br(),
                     br(),
                     textInput(ns("first_name"), "First Name", width = '50%'), #Create the widgets for pretherapy analytics
                     textInput(ns("last_name"), "Last Name", width = '50%'),
                     textInput(ns("email_address"), "Email Address", width = '50%'),
                     selectInput(ns("sex"), "Sex", c("", "Male", "Female", "Other"), width = '20%'),
                     dateInput(ns("birth_date"), "Date of Birth", startview = "year", format = "dd-mm-yyyy", value = as.Date(NA), width = '20%'),
                     numericInput(ns("postcode"), "Postcode", value = "", width = '20%'),
                     selectInput(ns("marital_status"), "Marital Status", c("", "Never Married", "Currently Married", "Separated", "Divorced", "Widowed", "Cohabiting"), width = '30%'),
                     selectInput(ns("sexuality"), "Sexual Orientation", c("", "Heterosexual", "Lesbian", "Gay", "Bisexual", "Transgender", "Queer", "Other"), width = '30%'),
                     selectInput(ns("ethnicity"), "Ethnicity", c("", "Caucasian", "Latino/Hispanic", "Middle Eastern", "African", "Caribbean", "South Asian",
                                                                 "East Asian", "Mixed", "Other"), width = '30%'),
                     checkboxInput(ns("indigenous"), "Identifies as Being of Aboriginal or Torres Strait Islander Descent", width = '20%'),
                     numericInput(ns("children"), "Number of Dependent Children", value = "", width = '20%'),
                     selectInput(ns("workforce_status"), "Primary Workforce Status", c("", "Working Full-Time", "Working Part-Time", "Working Casual Hours", "Studying", "Unemployed", "Retired"), width = '30%'),
                     selectInput(ns("education"), "Highest Education Level", c("", "No Education", "Primary Education", "Secondary Education", "Post-Secondary/Tertiary Education",
                                                                               "Bachelor or Equivalent", "Master or Equivalent", "Doctoral or Equivalent"), width = '30%'),

                     htmlOutput(ns("pretherapy_data_entry_message")),

                     br(),

                     actionButton(ns("submit_analytics_pretherapy"), "Register Client", class = "submit_data")

                      ),

                     mainPanel()

                   ))


}



#' New or existing client status widget and headings
#'
#' Module generates client status widget and headings.
#'
#' @param id String to create a unique namespace.
#'
#' @param clinician_id String indicating clinician's unique identifier.
#'
#' @export

analytics_pretherapy<- function(input, output, session, clinician_id) {

  output$pretherapy_data_entry_message<- renderText({ #Send message to ensure that fields for first and last name are filled out by user


    if(input$first_name == "" | input$last_name == "" | length(input$birth_date) < 1 | input$email_address == "") {

      return(paste("<span style=\"color:red\">Information is missing. Please provide your client's first name, last name, date of birth and email address to complete registration.</span>"))

    } else {

      "Client registration details are ready for submission."

    }

  })


  #Need to return input to make input parameters available

  eventReactive(input$submit_analytics_pretherapy, {


   client_id<- uuid::UUIDgenerate() #Generate unique client ID


    #Use req() to avoid error messages if the values are NULL

    pretherapy_analytics_items<- list( req(clinician_id), req(client_id), req(input$first_name), req(input$last_name), req(input$email_address), input$sex,
                                       req(input$birth_date), input$postcode, input$marital_status,
                                       input$sexuality, input$ethnicity, input$indigenous, input$children,
                                       input$workforce_status, input$education ) %>% purrr::set_names(c("clinician_id", "client_id", "first_name", "last_name", "email_address", "sex", "birth_date",
                                       "postcode", "marital_status", "sexuality", "ethnicity", "indigenous", "children", "workforce_status", "education"))




    pretherapy_analytics_df<- list( pretherapy_analytics_items ) %>% {

      tibble::tibble(  #Create a dataframe with all the pre-therapy analytics widget values as columns
                       #Specify the variable type explicitly

      clinician_id = purrr::map_chr(., "clinician_id"),
      client_id = purrr::map_chr(., "client_id"),
      first_name = purrr::map_chr(., "first_name"),
      last_name = purrr::map_chr(., "last_name"),
      email_address = purrr::map_chr(., "email_address"),
      sex = purrr::map_chr(., "sex"),
      birth_date = format(lubridate::as_date(purrr::map_dbl(., "birth_date")), "%d/%m/%Y"), #Convert to date class
      postcode = purrr::map_chr(., "postcode"),
      marital_status = purrr::map_chr(., "marital_status"),
      sexuality = purrr::map_chr(., "sexuality"),
      ethnicity = purrr::map_chr(., "ethnicity"),
      indigenous = purrr::map_chr(., "indigenous"),
      children = purrr::map_dbl(., "children"),
      workforce_status = purrr::map_chr(., "workforce_status"),
      education = purrr::map_chr(., "education")

    )


    }

  })

}




#' Post-Therapy Analytics Widgets
#'
#' Module generates post-therapy analytics widgets
#'
#' @param id String to create a unique namespace.
#'
#' @export

analytics_posttherapy_UI<- function(id) {

  ns<- NS(id)

  tagList(

    fluidPage(

      fluidRow(

    column(width = 12, checkboxInput(ns("last_assessment"), h4(tags$strong("Check here if your client is completing their final assessment on any questionnaire.", style = "color: #d35400")),
                                                 width = "100%"))),

    conditionalPanel(condition = "input.last_assessment == 1", ns = ns,

                     tagList(
                       sidebarLayout(
                         sidebarPanel(width = 11,
                                      tagList(
                                        titlePanel(span(tagList(icon("chart-bar", lib = "font-awesome")),
                                                        h3(tags$b("Please provide important information about clinical outcomes.")))),
                                        br(),
                                        selectInput(ns("principal_diagnosis"), "Primary Diagnosis", psychlytx::diagnosis_list, width = '60%'),
                                        selectizeInput(ns("secondary_diagnosis"), "Secondary Diagnosis", psychlytx::diagnosis_list, width = '60%'),
                                        textInput(ns("referrer"), "Referrer", value = "", width = '50%'),
                                        selectInput(ns("attendance_schedule"), "Schedule of Attendance", c("", "Varied", "Twice A Week", "Once A Week", "Once a Fortnight", "Once Every 3 Weeks", "Once A Month", "Greater Than 1 Month Apart"), width = '40%'),
                                        numericInput(ns("cancellations"), "Number of Cancellations", value = "", width = '20%'),
                                        numericInput(ns("non_attendances"), "Number of Non-Attendances (No Notice Given)", value = "", width = '20%'),
                                        numericInput(ns("attendances"), "Number of Sessions Attended", value = "", width = '20%'),
                                        radioButtons(ns("premature_dropout"), "Premature Dropout", choices = c("Yes", "No"), selected = character(0), width = '20%'),
                                        selectInput(ns("therapy"), "Therapeutic Approach Used", psychlytx::therapies_list, width = '50%'),
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
                                                                                    "Transport Health", "TUH", "UniHealth", "Westfund Health"))

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
                                        actionButton(ns("submit_analytics_posttherapy"), "Submit", class = "submit_data")

                                           )),

                         mainPanel()

                       )))))


}



#' New or existing client status widget and headings
#'
#' Module generates client status widget and headings.
#'
#' @param id String to create a unique namespace.
#'
#' @param clinician_id String indicating clinician's unique identifier.
#'
#' @param selected_client String indicating client's unique identifier.
#'
#' @export

analytics_posttherapy<- function(input, output, session, clinician_id, selected_client) {


  #Need to return input to make input parameters available

  eventReactive(input$submit_analytics_posttherapy, {

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

    }


    })

}


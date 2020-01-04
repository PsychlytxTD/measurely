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
                      sidebarPanel(width = 8, class = "pretherapy_sidepanel",
                     titlePanel(span(tagList(icon("clipboard", lib = "font-awesome")), h3(tags$b("Please Complete Client Registration.")))),
                     br(),
                     br(),
                     column(width = 12, a(tags$strong("We take privacy seriously. View our policy here."),
                                                    href = "http://www.psychlytx.com", style = "color:#d35400; text-decoration: underline;") ),
                     br(),
                     br(),
                     helpText("**Required Items"),
                     br(),
                     textInput(ns("first_name"), tags$strong("First Name**")), #Create the widgets for pretherapy analytics
                     textInput(ns("last_name"), tags$strong("Last Name**")),
                     textInput(ns("email_address"), tags$strong("Email Address**")),
                     selectInput(ns("sex"), "Sex", c("", "Male", "Female", "Other")),
                     dateInput(ns("birth_date"), tags$strong("Date of Birth**"), startview = "year", format = "dd/mm/yyyy", value = as.Date(NA)),
                     numericInput(ns("postcode"), "Postcode", value = "", width = '30%'),
                     selectInput(ns("marital_status"), "Marital Status", c("", "Never Married", "Currently Married", "Separated", "Divorced", "Widowed", "Cohabiting")),
                     selectInput(ns("sexuality"), "Sexual Orientation", c("", "Heterosexual", "Lesbian", "Gay", "Bisexual", "Transgender", "Queer", "Other")),
                     selectInput(ns("ethnicity"), "Ethnicity", c("", "Caucasian", "Latino/Hispanic", "Middle Eastern", "African", "Caribbean", "South Asian",
                                                                 "East Asian", "Mixed", "Other")),
                     checkboxInput(ns("indigenous"), "Aboriginal or Torres Strait Islander Descent"),
                     numericInput(ns("children"), "Number of Dependent Children", value = "", width = '30%'),
                     selectInput(ns("workforce_status"), "Primary Workforce Status", c("", "Working Full-Time", "Working Part-Time", "Working Casual Hours", "Studying", "Unemployed", "Retired")),
                     selectInput(ns("education"), "Highest Education Level", c("", "No Education", "Primary Education", "Secondary Education", "Post-Secondary/Tertiary Education",
                                                                               "Bachelor or Equivalent", "Master or Equivalent", "Doctoral or Equivalent")),

                     htmlOutput(ns("pretherapy_data_entry_message")),

                     br(),

                     actionButton(ns("submit_analytics_pretherapy"), "Register Client", class = "submit_button")

                      ),

                     mainPanel()

                   ))


}



#' New or existing client status widget and headings
#'
#' Module generates client status widget and headings.
#'
#' @param session A session object.
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


   id<- uuid::UUIDgenerate() #Generate unique client ID


    #Use req() to avoid error messages if the values are NULL

    pretherapy_analytics_items<- list( req(id), req(clinician_id), req(input$first_name), req(input$last_name), req(input$email_address), input$sex,
                                       req(input$birth_date), input$postcode, input$marital_status,
                                       input$sexuality, input$ethnicity, input$indigenous, input$children,
                                       input$workforce_status, input$education ) %>% purrr::set_names(c("id", "clinician_id", "first_name", "last_name", "email_address", "sex", "birth_date",
                                       "postcode", "marital_status", "sexuality", "ethnicity", "indigenous", "children", "workforce_status", "education"))




    pretherapy_analytics_df<- list( pretherapy_analytics_items ) %>% {

      tibble::tibble(  #Create a dataframe with all the pre-therapy analytics widget values as columns
                       #Specify the variable type explicitly

      id = purrr::map_chr(., "id"),
      clinician_id = purrr::map_chr(., "clinician_id"),
      first_name = purrr::map_chr(., "first_name"),
      last_name = purrr::map_chr(., "last_name"),
      email_address = purrr::map_chr(., "email_address"),
      sex = purrr::map_chr(., "sex"),
      birth_date = as.character(lubridate::as_date(purrr::map_dbl(., "birth_date"))), #Convert to correct SQL format and conver to character
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





library(shiny)
library(pool)
library(DBI)
library(RPostgreSQL)
library(shinyWidgets)
library(dplyr)
library(purrr)
library(magrittr)


pool <- dbPool( #Set up the connection with the db
    drv = dbDriver("PostgreSQL"),
    dbname = "postgres",
    host = Sys.getenv("DBHOST"),
    user = Sys.getenv("DBUSER"),
    password = Sys.getenv("DBPASSWORD")
)


onStop(function() {
    #Close pool object when session ends
    poolClose(pool)
})

# Define UI for application that draws a histogram
ui <- fluidPage(

    tags$head(

        tags$link(rel = "stylesheet", type = "text/css", href = "Styling.css") #Link to the css style sheet,

    ),

    fluidRow(

    column(offset = 4, width = 8,

    titlePanel(span("Clinician Registration", class = "title_heading"))

    )),

    fluidRow(
        column(offset = 4, width = 8,

               span("Psychlytx | Measurely Web Applications", icon("registered", lib = "font-awesome"), class = "title_heading")

        )),

    br(),

    fluidRow(
        column(offset = 4, width = 8,

    h6("An asterix (*) indicates that a response is required.", class = "title_heading")
        )),

    br(),


    fluidRow(

        column(offset = 4, width = 8,

    textInput("first_name", "First Name*"),
    textInput("last_name", "Last Name*"),
    textInput("email_address", "Email Address*"),
    dateInput("birth_date", "Date of Birth"),
    selectInput("sex", "Sex", choices = c("Female", "Male", "I'd prefer not to specify"), selectize = FALSE, selected = FALSE, size = 4),
    selectInput("profession", "Profession", choices = c("General Psychologist", "Clinical Psychologist", "Counselling Psychologist",
                                                        "Community Psychologist", "Educational & Developmental Psychologist",
                                                        "Forensic Psychologist", "Health Psychologist",
                                                        "Organisational Psychologist", "Psychology Registrar",
                                                        "Clinical Neuropsychologist", "Psychiatrist", "General Practitioner",
                                                        "Occupational Therapist", "Allied Health Practitioner", "Nurse"), selectize = FALSE, selected = FALSE, size = 4),
    selectInput("highest_qualification", "Highest Academic Qualification", choices = c("Secondary School Completion",
                                                                                       "TAFE Diploma/Certificate", "Bachelor Degree",
                                                                                       "Masters Degree", "Doctorate",
                                                                                       "PhD"), selectize = FALSE, selected = FALSE, size = 4),
    numericInput("years_practiced", "Number of Years Practicing", value = NULL),
    numericInput("weekly_hours", "Number of Client-Facing Hours Per Week", value = NULL),
    selectizeInput("primary_therapy_orientation", "Primary Therapeutic Approach Used", choices = psychlytx::therapies_list,
                   options = list(
                       placeholder = 'Type a word or scroll down..',
                       onInitialize = I('function() { this.setValue(""); }')
                   )),
    selectizeInput("secondary_therapy_orientation", "Secondary Therapeutic Approach Used", choices = psychlytx::therapies_list,
                   options = list(
                       placeholder = 'Type a word or scroll down..',
                       onInitialize = I('function() { this.setValue(""); }')
                   )),

    uiOutput("practice_dropdown"),
    #If clinician is not part of an existing practice, he/she must add details of their practice, to be stored in db practice table.

    conditionalPanel(condition = "input.practice_selection == 'no_listing'",

    textInput("practice_name", "Please Indicate the Name of your Practice/Organisation*"),

    selectInput("practice_type", "Type of Organisation/Practice", choices = c("Private Practice", "Medical Hospital",
                                                                                  "Private Mental Health Facility",
                                                                                  "Alcohol And Other Drug Service",
                                                                                  "Public Mental Health Service",
                                                                                  "Community/Not-For-Profit Organisation",
                                                                                  "Secondary School",
                                                                                  "University",
                                                                                  "Corporate Setting"), selectize = FALSE, selected = FALSE, size = 4),
    numericInput("practice_location", "Postcode at Current Place of Practice", value = NULL)
    ),

    br(),

    actionButton("submit_clinician_registration", "Submit", class = "submit_clinician_registration")

        ))



)



# Define server logic required to draw a histogram
server <- function(input, output, session) {


    practices<- reactive({

        practice_list_sql<- "SELECT id, name
                           FROM practice;"

        practice_list_query<- sqlInterpolate(pool, practice_list_sql)

        practice_list<- dbGetQuery( pool, practice_list_query )

        practice_list<- practice_list %>%
            collect  %>%
            split( .$name ) %>%    # Field that will be used for the labels
            purrr::map(~.$id)

       practice_list[["My practice is not listed"]]<- "no_listing"

       return(practice_list)


    })




    output$practice_dropdown<- renderUI({

        req(practices())

        selectizeInput(
            inputId = "practice_selection",
            label = "Name of Practice/Organisation*",
            choices = practices(),
            options = list(
                placeholder = 'Type a name or scroll down..',
                onInitialize = I('function() { this.setValue(""); }')
            ))
    })

    outputOptions(output, "practice_dropdown", suspendWhenHidden = FALSE)




    observeEvent(input$submit_clinician_registration, {

        if(any(c(input$first_name, input$last_name, input$email_address, input$practice_selection) == "")) {

            sendSweetAlert(
                session = session,
                title = "Looks Like We Have A Problem...",
                text = "Please provide your first name, last name, email address and practice/organisation name to continue.",
                type = "error"
            )
        }


        clinician_data<- data.frame(id = uuid::UUIDgenerate(),
                                    practice_id = ifelse( input$practice_selection == 'no_listing', uuid::UUIDgenerate(), input$practice_selection),
                                    first_name = req(input$first_name), last_name = req(input$last_name),
                                    email_address = req(input$email_address), birth_date = input$birth_date,
                                    sex = input$sex,
                                    profession = input$profession,
                                    highest_qualification = input$highest_qualification,
                                    years_practiced = input$years_practiced,
                                    weekly_hours = input$weekly_hours,
                                    primary_therapy_orientation = input$primary_therapy_orientation,
                                    secondary_therapy_orientation = input$secondary_therapy_orientation
                                    )


        #Write the measure data (from this entry) to the scale table in the db.

        dbWriteTable(pool, "clinician",  clinician_data, row.names = FALSE, append = TRUE)


        if(input$practice_selection == "no_listing") {

            practice_data<- data.frame(
                name = req(input$practice_name),
                id = uuid::UUIDgenerate(),
                type = input$practice_type,
                location = input$practice_location
            )


        dbWriteTable(pool, "practice", practice_data,  row.names = FALSE, append = TRUE)

        }


    sendSweetAlert(
        session = session,
        title = "Success!!",
        text = "You are now registered to use Measurely web applications",
        type = "success"
    )


    })



}

# Run the application
shinyApp(ui = ui, server = server)

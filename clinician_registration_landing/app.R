#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(pool)
library(RPostgreSQL)
library(shinyWidgets)

pool <- dbPool( #Set up the connection with the db
    drv = dbDriver("PostgreSQL"),
    dbname = "postgres",
    host = "measurely.cglmjkxzmdng.ap-southeast-2.rds.amazonaws.com",
    user = "timothydeitz",
    password = Sys.getenv("PGPASSWORD")
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

    h5("An asterix (*) indicates that a response is required.", class = "title_heading")
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
                                                        "Clinical Neuropsychologist", "Psychiatrist", "Occupational Therapist",
                                                        "Allied Health Practitioner", "Nurse"), selectize = FALSE, selected = FALSE, size = 4),
    selectInput("highest_qualification", "Highest Academic Qualification", choices = c("Secondary School Completion",
                                                                                       "TAFE Diploma/Certificate", "Bachelor Degree",
                                                                                       "Masters Degree", "Doctorate",
                                                                                       "PhD"), selectize = FALSE, selected = FALSE, size = 4),
    numericInput("years_practiced", "Number of Years Practicing", value = NULL),
    numericInput("weekly_hours", "Number of Client-Facing Hours Per Week", value = NULL),
    textInput("organisation_name", "Name of Organisation/Practice"),
    selectInput("organisation_type", "Type of Organisation/Practice", choices = c("Private Practice", "Medical Hospital",
                                                                                  "Private Mental Health Facility",
                                                                                  "Alcohol And Other Drug Service",
                                                                                  "Public Mental Health Service",
                                                                                  "Community/Not-For-Profit Organisation",
                                                                                  "Secondary School",
                                                                                  "University",
                                                                                  "Corporate Setting"), selectize = FALSE, selected = FALSE, size = 4),
    numericInput("organisation_location", "Postcode at Current Place of Practice", value = NULL),
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

    br(),

    actionButton("submit_clinician_registration", "Submit", class = "submit_clinician_registration")

        ))



)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

    observeEvent(input$submit_clinician_registration, {

        if(any(c(input$first_name, input$last_name, input$email_address) == "")) {

            sendSweetAlert(
                session = session,
                title = "Looks Like We Have A Problem...",
                text = "Please provide your first name, last name and email address to continue.",
                type = "error"
            )
        }



        clinician_data<- data.frame(id = uuid::UUIDgenerate(),
                                    practice_id = uuid::UUIDgenerate(), #In production this will need to be replaced with an environment variable
                                                                        #- because multiple clinicians can have the same practice id.
                                    first_name = req(input$first_name), last_name = req(input$last_name),
                                    email_address = req(input$email_address), birth_date = input$birth_date,
                                    sex = input$sex, profession = input$profession,
                                    highest_qualification = input$highest_qualification,
                                    years_practiced = input$years_practiced, weekly_hours = input$weekly_hours,
                                    organisation_name = input$organisation_name,
                                    organisation_type = input$organisation_type,
                                    organisation_location = input$organisation_location,
                                    primary_therapy_orientation = input$primary_therapy_orientation,
                                    secondary_therapy_orientation = input$secondary_therapy_orientation
                                    )

    sendSweetAlert(
        session = session,
        title = "Success!!",
        text = "You are now registered to use Measurely web applications",
        type = "success"
    )

    #Write the measure data (from this entry) to the scale table in the db.

    dbWriteTable(pool, "clinician",  clinician_data, row.names = FALSE, append = TRUE)


    })



}

# Run the application
shinyApp(ui = ui, server = server)

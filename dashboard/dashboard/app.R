library(shinydashboard)
library(magrittr)
library(purrr)
library(tidyr)
library(dplyr)
library(knitr)
library(lubridate)
library(chron)
library(grid)
library(shinyjs)
library(RPostgreSQL)
library(DBI)
library(pool)
library(ggplot2)
library(ggrepel)
library(DT)
library(memor)
library(extrafont)
library(extrafontdb)
library(shinyhelper)
library(shinyWidgets)
library(shinycssloaders)
library(httr)
library(car)
library(purrrlyr)
library(uuid)
library(shinyBS)
library(tibble)
library(aws.s3)
library(glue)


library(shiny)

# Define UI for application that draws a histogram
ui <- dashboardPage(

  dashboardHeader(
    title = "Measurely Outcomes Dashboard",
    titleWidth = 200
  ),

  dashboardSidebar(

    selectInput(
      inputId = "measure",
      label = "Select Measure",
      choices = c("GAD-7", "PHQ-9")
    ),

    sidebarMenu(

      menuItem("Measure Outcomes", tabName = "measure_outcomes", icon = icon("dashboard")),

      menuItem("Demographics", tabName = "demographics", icon = icon("th")),

      menuItem("Therapeutic Outcomes", tabName = "therapeutic_outcomes", icon = icon("th"))


    )),


  dashboardBody(

    fluidRow(

      valueBoxOutput("improved"),
      valueBoxOutput("sig_improved"),
      valueBoxOutput("nil_change"),
      valueBoxOutput("deteriorated")
    ),

    tabItems(
      # First tab content
      tabItem(tabName = "measure_outcomes",

              fluidPage(

                fluidRow(

                column(width = 6,

                  plotly::plotlyOutput("spaghetti_outcomes_plot", height = 300)

                      ),

                column(width = 6,

                  plotly::plotlyOutput("summary_outcomes_plot")

                      )
                         ),



                  plotly::plotlyOutput("measure_plot_individual"),

                  DT::dataTableOutput("measure_table_individual")



                      )
      ),



      tabItem(tabName = "demographics",

        fluidPage(

          fluidRow(

            column(width = 6,

                   plotly::plotlyOutput("demographics_plot", height = 300)

            ),

            column(width = 6,

                   plotly::plotlyOutput("summary_outcomes_plot_by_demographics")

            )))),


      tabItem(tabName = "post_therapy_outcomes",

              fluidPage(

                fluidRow(

                  valueBoxOutput("attendances"),
                  valueBoxOutput("cancellations"),
                  valueBoxOutput("dnas")
                ),

                fluidRow(

                  column(width = 6,

                         plotly::plotlyOutput("post_therapy_plot", height = 300)

                  ),

                  column(width = 6,

                         plotly::plotlyOutput("summary_outcomes_plot_by_post_therapy")

                  ))))


))

)

# Define server logic required to draw a histogram
server <- function(input, output) {


}

# Run the application
shinyApp(ui = ui, server = server)


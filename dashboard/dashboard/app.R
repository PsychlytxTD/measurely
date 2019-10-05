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


pool <- dbPool( #Set up the connection with the db
  drv = dbDriver("PostgreSQL"),
  dbname = "scaladb",
  host = "scaladb.cdanbvyi6gfm.ap-southeast-2.rds.amazonaws.com",
  user = "jameslovie",
  password = Sys.getenv("PGPASSWORD")
)


onStop(function() {
  #Close pool object when session ends
  poolClose(pool)

})


clinician_email<- "timothydeitz@gmail.com"  #Sys.getenv("SHINYPROXY_USERNAME")  ##This is how we will access the clinician username (i.e. email) to pass to the modules

#url<- "https://scala.au.auth0.com/userinfo"

#clinician_object<- httr::GET( url, httr::add_headers(Authorization = paste("Bearer", Sys.getenv("SHINYPROXY_OIDC_ACCESS_TOKEN")),
#`Content-Type` = "application/json"))

#clinician_object<- httr::content(clinician_object)

clinician_id<- "auth0|5c99f47197d7ec57ff84527e" #paste(clinician_object["sub"]) #Access the id object


data<- tbl(pool, "scale") %>% left_join(tbl(pool, "client"), by = c("client_id" = "id")) %>%
  left_join(tbl(pool, "posttherapy_analytics"), by = c("client_id" = "client_id")) %>%
  filter(clinician_id == clinician_id) %>% dplyr::collect()




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

      valueBoxOutput("improved", width = 3),
      valueBoxOutput("sig_improved", width = 3),
      valueBoxOutput("remained_same", width = 3),
      valueBoxOutput("deteriorated", width = 3)
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

  #Join relevant tables and select variables relevant to dashboard

  db_data<- tbl(pool, "scale") %>% inner_join(tbl(pool, "client"), by = c("client_id" = "id")) %>%
    inner_join(tbl(pool, "posttherapy_analytics"), by = "client_id") %>% filter(clinician_id == clinician_id) %>%
    dplyr::select(clinician_id, client_id, first_name, last_name, birth_date, sex, postcode, marital_status, sexuality,
                  ethnicity, indigenous, children, workforce_status, education, entry_id, measure, subscale, date,
                  score, pts, se, ci, ci_upper, ci_lower, contains("cutoff_value"), contains("cutoff_label"),
                  principal_diagnosis, secondary_diagnosis, attendance_schedule, cancellations, non_attendances,
                  attendances, premature_dropout, therapy, funding, private_health_fund, referrer, out_of_pocket) %>%
    dplyr::collect()



  #Create a list column with scores on a specific subscale for each client

  nested<- db_data %>% dplyr::group_by(client_id, measure, subscale) %>% tidyr::nest()

  #Arrange the date column within each nested dataframe, from earliest to latest

  nested$data<- purrr::map(nested$data, ~dplyr::arrange(., lubridate::dmy(.x$date)))

  #Within each nested dataframe, canculate key stats across all timepoints for that subscale

  nested<- nested %>% dplyr::mutate(data = purrr::map(data, ~ dplyr::mutate(., improve_all = .x$score < lag( .x$score ),
                                                                            sig_improve_all = .x$score < lag( .x$ci_lower ),
                                                                            remained_same_all = .x$score == lag( .x$score ),
                                                                            deteriorated_all = .x$score > lag( .x$score )
  )))

  #Use the nested dataframes to add new variables of key stats between first and last timepoint for each client per subscale

  nested<- nested %>% dplyr::mutate(change = purrr::map_dbl( data, ~.x$score[1] - .x$score[length(.x$score)] ),
                                    improve = purrr::map_lgl( data, ~ .x$score[length(.x$score)] < .x$score[1] ),
                                    sig_improve = purrr::map_lgl( data, ~.x$score[length(.x$score)] < .x$ci_lower[1] ),
                                    remained_same = purrr::map_lgl( data, ~ .x$score[length(.x$score)] == .x$score[1] ),
                                    deteriorated = purrr::map_lgl(data, ~.x$score[length(.x$score)] > .x$score[1] )
  )



  total_clients_improved<- sum(nested$improve, na.rm = TRUE)

  total_clients_sig_improved<- sum(nested$sig_improve, na.rm = TRUE)

  total_clients_remained_same<- sum(nested$remained_same, na.rm = TRUE)

  total_clients_deteriorated<- sum(nested$deteriorated, na.rm = TRUE)

  total_administrations<- db_data %>% dplyr::select(entry_id) %>% dplyr::n_distinct()


  output$improved <- renderValueBox({
    valueBox(
      value = paste0(total_clients_improved, " ", "(", (total_clients_improved/total_administrations) * 100, "%", ")"),
      subtitle = "Clients Improved"
    )
  })

  output$sig_improved <- renderValueBox({
    valueBox(
      value = paste0(total_clients_sig_improved, " ", "(", (total_clients_sig_improved/total_administrations) * 100, "%", ")"),
      subtitle = "Clients Sigificantly Improved"
    )
  })

  output$remained_same <- renderValueBox({
    valueBox(
      value = paste0(total_clients_remained_same, " ", "(", (total_clients_remained_same/total_administrations) * 100, "%", ")"),
      subtitle = "Clients Did Not Change"
    )
  })

  output$deteriorated <- renderValueBox({
    valueBox(
      value = paste0(total_clients_deteriorated, " ", "(", (total_clients_deteriorated/total_administrations) * 100, "%", ")"),
      subtitle = "Clients Deteriorated"
    )
  })



}

# Run the application
shinyApp(ui = ui, server = server)


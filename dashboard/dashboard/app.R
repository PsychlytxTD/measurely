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
library(plotly)


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


age_cat <- function(x, lower = 0, upper, by = 10,
                    sep = "-", above_char = "+") {

  labs <- c(paste(seq(lower, upper - by, by = by),
                  seq(lower + by - 1, upper - 1, by = by),
                  sep = sep),
            paste(upper, above_char, sep = ""))

  cut(floor(x), breaks = c(seq(lower, upper, by = by), Inf),
      right = FALSE, labels = labs)
}




ui <- dashboardPage(

  dashboardHeader(
    title = "Measurely Outcomes Dashboard",
    titleWidth = 200
  ),

  dashboardSidebar(

    uiOutput("date_dropdown"),

    uiOutput("measure_dropdown"),

    sidebarMenu(

      menuItem("Measure Outcomes", tabName = "measure_outcomes", icon = icon("dashboard")),

      menuItem("Demographics", tabName = "demographics", icon = icon("th")),

      menuItem("Therapeutic Outcomes", tabName = "posttherapy_outcomes", icon = icon("th"))


    )),


  dashboardBody(

    fluidRow(

      plotly::plotlyOutput("all_outcomes"),

      valueBoxOutput("improved"),
      bsModal("mod_1","Clients Showing Improvement","btn", size = "large",
              DT::dataTableOutput("table_improved")),


      valueBoxOutput("sig_improved"),
      bsModal("mod_2","Clients Showing Statistically Reliable Improvement","btn", size = "large",
              DT::dataTableOutput("table_sig_improved")),

      valueBoxOutput("remained_same"),
      bsModal("mod_3","Clients Showing No Change","btn", size = "large",
              DT::dataTableOutput("table_remained_same")),



      valueBoxOutput("deteriorated"),
      bsModal("mod_4","Clients Showing Deterioration","btn", size = "large",
              DT::dataTableOutput("table_deteriorated"))
    ),


    tabItems(
      # First tab content
      tabItem(tabName = "measure_outcomes",

              fluidPage(

                fluidRow(

                  column(width = 12,

                         checkboxGroupInput("outcome_type", "Select Outcome",
                                            choices = c("Improvement", "Statistically Reliable Improvement",
                                                        "No Change", "Deterioration"), inline = TRUE),

                         plotly::plotlyOutput("plot_outcomes_by_measure")

                         )


                ),

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

           uiOutput("demographics_dropdown")

          ),

          fluidRow(

          column(width = 6,

           plotly::plotlyOutput("demographics_plot", height = 300)

          ),

          DT::dataTableOutput("test"),

          column(width = 6,

           plotly::plotlyOutput("summary_outcomes_plot_by_demographics"),

           uiOutput("back")



          )


            ))),


      tabItem(tabName = "posttherapy_outcomes",

              fluidPage(

                fluidRow(

                  valueBoxOutput("attendances"),
                  valueBoxOutput("cancellations"),
                  valueBoxOutput("dnas")
                ),

                fluidRow(

                  uiOutput("posttherapy_dropdown")

                ),

                fluidRow(

                  column(width = 12,

                         plotly::plotlyOutput("diagnosis_plot"),
                         br(),
                         plotly::plotlyOutput("posttherapy_plot"),
                         plotly::plotlyOutput("summary_outcomes_plot_by_posttherapy"),
                         uiOutput("back_posttherapy")

                  )

                 )))


))

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {


  client<- tbl(pool, "client") %>% dplyr::collect() %>% as.data.frame() %>% dplyr::mutate(creation_date = as.Date(creation_date))

  #First convert birth dates to ages (numerical variable), then cut it into discrete categories
  client$birth_date<- age_cat(eeptools::age_calc(client$birth_date, units = 'years'), upper = 70)

  measure<- tbl(pool, "scale") %>% dplyr::collect() %>% as.data.frame() %>% dplyr::mutate(date = as.Date(date))

  posttherapy_analytics<- tbl(pool, "posttherapy_analytics") %>% dplyr::collect() %>% as.data.frame() %>% dplyr::mutate(creation_date = as.Date(creation_date))

  dates<- c(as.Date(min(measure$date)),
            as.Date(max(measure$date)))





  output$date_dropdown<- renderUI({

    dateRangeInput("date_selection", "Select Date Range", start = dates[1], end = dates[2], format = "yyyy-mm-dd")

  })




  measure_table<- reactive({

    measure %>% dplyr::filter(date >= input$date_selection[1] & date <= input$date_selection[2])

    })


  client_table<- reactive({

    c<- client %>% dplyr::filter(creation_date >= input$date_selection[1] & creation_date <= input$date_selection[2])

    })


  posttherapy_analytics_table<- reactive({

    posttherapy_analytics %>%  dplyr::filter(creation_date >= input$date_selection[1] & creation_date <= input$date_selection[2])

    })


  joined_data<- reactive({

    measure_table() %>%
    dplyr::inner_join(client_table(), by = c("client_id" = "id")) %>%
    dplyr::left_join(posttherapy_analytics_table(), by = "client_id") %>% filter(clinician_id == clinician_id) %>%
    dplyr::select(clinician_id, client_id, first_name, last_name, birth_date, sex, postcode, marital_status, sexuality,
                  ethnicity, indigenous, children, workforce_status, education, entry_id, measure, subscale, date,
                  score, pts, se, ci, ci_upper, ci_lower, contains("cutoff_value"), contains("cutoff_label"),
                  principal_diagnosis, secondary_diagnosis, attendance_schedule, cancellations, non_attendances,
                  attendances, premature_dropout, therapy, funding, private_health_fund, referrer, out_of_pocket)
  })



  #Create a list column with scores on a specific subscale for each client

  nested_data<- reactive({

    nested<- joined_data() %>% dplyr::group_by(client_id, measure, subscale) %>% tidyr::nest()

    #Arrange the date column within each nested dataframe, from earliest to latest

    nested$data<- purrr::map(nested$data, ~dplyr::arrange(., lubridate::dmy(.x$date)))

    #Within each nested dataframe, canculate key stats across all timepoints for that subscale

    nested<- nested %>% dplyr::mutate(data = purrr::map(data, ~ dplyr::mutate(., improve_all = .x$score < lag( .x$score ),
                                                                              sig_improve_all = .x$score < lag( .x$ci_lower ),
                                                                              remained_same_all = .x$score == lag( .x$score ),
                                                                              deteriorated_all = .x$score > lag( .x$score )
    )))

    #Use the nested dataframes to add new variables of key stats between first and last timepoint for each client per subscale


    nested<- nested %>% dplyr::mutate(change = purrr::map_dbl( data, ~.x$score[1] - .x$score[length(.x$score)] ), #Specify non-sig improvement
                                      improve = purrr::map_lgl( data, ~ .x$score[length(.x$score)] < .x$score[1] & .x$score[length(.x$score)] >= .x$ci_lower[1]  ),
                                      sig_improve = purrr::map_lgl( data, ~.x$score[length(.x$score)] < .x$ci_lower[1] ),
                                      remained_same = purrr::map_lgl( data, ~ .x$score[length(.x$score)] == .x$score[1] ),
                                      deteriorated = purrr::map_lgl(data, ~.x$score[length(.x$score)] > .x$score[1] )
    )


  })




  outcomes_by_measure<- reactive({


      switch(input$outcome_type,

             "Improvement" = {

               nested_data() %>% dplyr::group_by(measure) %>% dplyr::summarise(

               count = round(sum(improve, na.rm = TRUE), 1),
               percent = round((count / length(improve)) * 100, 1),
               average_change = round(mean(change, na.rm = TRUE), 1)

               )

             },

             "Statistically Reliable Improvement" = {

               nested_data() %>% dplyr::group_by(measure) %>% dplyr::summarise(

               average_change = round(mean(change, na.rm = TRUE), 1),
               count = round(sum(sig_improve, na.rm = TRUE), 1),
               percent = round((count / length(sig_improve)) * 100, 1)

               )

             },

             "No Change" = {

               nested_data() %>% dplyr::group_by(measure) %>% dplyr::summarise(

               average_change = round(mean(change, na.rm = TRUE), 1),
               count = round(sum(remained_same, na.rm = TRUE), 1),
               percent = round((count / length(remained_same)) * 100, 1)

               )

             },

             "Deterioration" = {

               nested_data() %>% dplyr::group_by(measure) %>% dplyr::summarise(

               average_change = round(mean(change, na.rm = TRUE), 1),
               count = round(sum(deteriorated, na.rm = TRUE), 1),
               percent = round((count / length(deteriorated)) * 100, 1)

               )

             }


             )



  })




  output$plot_outcomes_by_measure<- plotly::renderPlotly({

    p<- ggplot(outcomes_by_measure(), aes(x=measure, y=percent, color = measure, fill = measure,
                                          text = paste0("Percentage of ", gsub('_', ' ', measure),
                                                       " respondents that showed", " ", stringr::str_to_lower(input$outcome_type), ": ", percent, "%", "<br>",
                                                       "Mean change (pre to post) on the: ", gsub('_', ' ', measure), ": ", average_change))) +
      geom_point(size=3) +
      geom_segment(aes(x=measure,
                       xend=measure,
                       y=0,
                       yend=percent)) +
      labs(title="Results By Measure",
           subtitle="Results By Individual Outcome Measures",
           caption="All Patients") +
      theme(axis.text.x = element_text(angle=65, vjust=0.6)) + coord_flip()


    ggplotly(p, tooltip = "text")

  })











  value_box_outcomes<- reactive({

    total_administrations<- joined_data() %>% dplyr::select(entry_id) %>% dplyr::n_distinct()

    joined_data() %>% dplyr::summarise(

      improved = sum(nested_data()$improve, na.rm = TRUE),
      improved_percent = round((improved/total_administrations) * 100 , 1),
      sig_improved = sum(nested_data()$sig_improve, na.rm = TRUE),
      sig_improved_percent = round((sig_improved/total_administrations) * 100, 1),
      remained_same = sum(nested_data()$remained_same, na.rm = TRUE),
      remained_same_percent = round((remained_same/total_administrations) * 100, 1),
      deteriorated = sum(nested_data()$deteriorated, na.rm = TRUE),
      deteriorated_percent = round((deteriorated/total_administrations) * 100, 1)

                                       )

    })


  lollipop_outcomes<- reactive({

    total_administrations<- joined_data() %>% dplyr::select(entry_id) %>% dplyr::n_distinct()

    outcomes<- nested_data() %>% dplyr::transmute(

      improved = sum(improve, na.rm = TRUE),
      improved_percent = round((improved/total_administrations) * 100 , 1),
      sig_improved = sum(sig_improve, na.rm = TRUE),
      sig_improved_percent = round((sig_improved/total_administrations) * 100, 1),
      remained_same = sum(remained_same, na.rm = TRUE),
      remained_same_percent = round((remained_same/total_administrations) * 100, 1),
      deteriorated = sum(deteriorated, na.rm = TRUE),
      deteriorated_percent = round((deteriorated/total_administrations) * 100, 1)

    )

    gathered_outcomes_percent<- outcomes %>% tidyr::gather("percentage_outcome", "percentage",
                                                           -improved, -sig_improved, -remained_same, -deteriorated)

    gathered_outcomes_count<- outcomes %>% tidyr::gather("count_outcome", "count",
                                                         -improved_percent, -sig_improved_percent, -remained_same_percent,
                                                         -deteriorated_percent)

   dplyr::bind_cols(gathered_outcomes_percent, gathered_outcomes_count) %>% dplyr::select(outcome = percentage_outcome,
                                                                                          percentage = percentage,
                                                                                          count = count)

  })


  output$all_outcomes<- plotly::renderPlotly({

  p<- ggplot(lollipop_outcomes(), aes(x=outcome, y=percentage)) +
    geom_point(size=3) +
    geom_segment(aes(x=outcome,
                     xend=outcome,
                     y=0,
                     yend=percentage)) +
    labs(title="All Results",
         subtitle="Summary Outcomes",
         caption="All Patients") +
    theme(axis.text.x = element_text(angle=65, vjust=0.6)) + coord_flip()


  ggplotly(p)


  })





  output$improved <- renderValueBox({
    entry_01<- 20
    box1<- valueBox(
     value = paste0(value_box_outcomes() %>% dplyr::pull(1), " ", "(",
                     value_box_outcomes() %>% dplyr::pull(2), "%", ")"),
      href = "#",
      subtitle = HTML("<b>Clients Improved</b>")
    )
    box1$children[[1]]$attribs$class<-"action-button"
    box1$children[[1]]$attribs$id<-"button_box_01"
    return(box1)
  })


  output$table_improved<- DT::renderDataTable({ client_table() %>% inner_join(nested_data(),
                          by = c("id" = "client_id")) %>% dplyr::filter(improve == TRUE) %>%
                          dplyr::select(first_name, last_name, birth_date)
                          })

  observeEvent(input$button_box_01, {
    toggleModal(session,"mod_1","open")
   })





  output$sig_improved <- renderValueBox({
    entry_02<- 20
    box2<- valueBox(
      value = paste0(value_box_outcomes() %>% dplyr::pull(3), " ", "(",
                     value_box_outcomes() %>% dplyr::pull(4), "%", ")"),
      href = "#",
      subtitle = HTML("<b>Clients Significantly Improved</b>")
    )
    box2$children[[1]]$attribs$class<-"action-button"
    box2$children[[1]]$attribs$id<-"button_box_02"
    return(box2)
  })

  output$table_sig_improved<- DT::renderDataTable({ client_table() %>% inner_join(nested_data(),
      by = c("id" = "client_id")) %>% dplyr::filter(sig_improve == TRUE) %>%
      dplyr::select(first_name, last_name, birth_date)
  })

  observeEvent(input$button_box_02, {
    toggleModal(session,"mod_2","open")
  })



  output$remained_same <- renderValueBox({
    entry_03<- 20
    box3<- valueBox(
      value = paste0(value_box_outcomes() %>% dplyr::pull(5), " ", "(",
                     value_box_outcomes() %>% dplyr::pull(6), "%", ")"),
      href = "#",
      subtitle = HTML("<b>Clients Did Not Change</b>")
    )
    box3$children[[1]]$attribs$class<-"action-button"
    box3$children[[1]]$attribs$id<-"button_box_03"
    return(box3)
  })


  output$table_remained_same<- DT::renderDataTable({ client_table() %>% inner_join(nested_data(),
  by = c("id" = "client_id")) %>% dplyr::filter(remained_same == TRUE) %>%
      dplyr::select(first_name, last_name, birth_date)
  })

  observeEvent(input$button_box_03, {
    toggleModal(session,"mod_3","open")
  })


  output$deteriorated <- renderValueBox({
    entry_04<- 20
    box4<- valueBox(
      value = paste0(value_box_outcomes() %>% dplyr::pull(7), " ", "(",
                     value_box_outcomes() %>% dplyr::pull(8), "%", ")"),
      href = "#",
      subtitle = HTML("<b>Clients Deteriorated</b>")
    )
    box4$children[[1]]$attribs$class<-"action-button"
    box4$children[[1]]$attribs$id<-"button_box_04"
    return(box4)
  })


  output$table_deteriorated<- DT::renderDataTable({ client_table() %>% inner_join(nested_data(),
                              by = c("id" = "client_id")) %>% dplyr::filter(deteriorated == TRUE) %>%
      dplyr::select(first_name, last_name, birth_date)
  })

  observeEvent(input$button_box_04, {
    toggleModal(session,"mod_4","open")
  })





  output$measure_dropdown<- renderUI({

    measures<- unique(joined_data()$measure) %>% purrr::set_names(stringr::str_replace_all(unique(joined_data()$measure), "_", " "))

    selectInput("measure_selection", "Select Outcome Measure", choices = measures)

  })


  output$demographics_dropdown<- renderUI({


    #Make named list to pass to dropdown, to avoid underscores between words

    demographic_vars<- names(joined_data()[5:14]) %>%
      purrr::set_names(stringr::str_replace_all(names(joined_data()[5:14]), "_", " "))

    selectInput("demographic_variable", "Select Demographic Outcome",
                choices = demographic_vars)
  })


  current_category<- reactiveVal()

  output$demographics_plot <- plotly::renderPlotly({

    demographics<- tibble::tibble(client_table()[, req(input$demographic_variable)]) %>%
      dplyr::count(.[[1]]) %>% purrr::set_names(c("labels", "values")) %>% dplyr::mutate_if(is.factor, as.character)

    demographics$labels[demographics$labels == "" | is.na(demographics$labels)]<- "Missing"


    plot_ly(demographics) %>%
      add_pie(
        labels = ~labels,
        values = ~values,
        customdata = ~labels
      )

  })



  observe({

    cd <- event_data("plotly_click")$customdata[[1]]

    if (isTRUE(cd %in% client[,paste(input$demographic_variable)])) current_category(cd)

  })


  outcomes_by_demographic<- reactive({

    if(length(current_category())) {

      outcomes_df<- client_table() %>% dplyr::inner_join(nested_data(), by = c("id" = "client_id"))

      outcomes_df<- outcomes_df[, c(input$demographic_variable, "improve", "sig_improve", "remained_same", "deteriorated")]

      names(outcomes_df)<- c("selected", "Improvement", "Reliable Improvement", "No Change", "Deterioration")

      outcomes_df<- outcomes_df %>% dplyr::filter(selected %in% current_category())

      outcomes_df_gathered<- outcomes_df %>% tidyr::gather("outcome", "status", -selected) %>% dplyr::filter(status == TRUE)

      outcomes_summary<- forcats::fct_count(outcomes_df_gathered$outcome, sort = TRUE, prop = TRUE) %>% dplyr::mutate(p = p * 100) %>%
        dplyr::select(Variable = f, Count = n, Percent = p)

    }

  })


  output$summary_outcomes_plot_by_demographics<- renderPlotly({


    p<- ggplot(req(outcomes_by_demographic()), aes(x = paste(current_category()[1]),
                                                   y = Percent,
                                                   fill = forcats::fct_reorder(Variable, Percent),
                                                   text = paste(Variable, "<br>","Count: ", Count))) +
      geom_col() + geom_text(aes(label = paste0(round(Percent, 1), "%")), size = 3,
                             position = position_stack(vjust = 0.5)) +
      theme(legend.title = element_blank(), legend.justification=c(0,0), legend.position=c(0,0), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            axis.line = element_blank()) + xlab("")


    plotly::ggplotly(p, tooltip = "text")


  })


  # populate back button if category is chosen
  output$back <- renderUI({

    if (length(current_category())) actionButton("clear", "Clear", icon("chevron-left"))

  })


  # clear the chosen category on back button press
  observeEvent(input$clear, current_category(NULL))





  value_box_posttherapy<- reactive({

   posttherapy_analytics_table() %>% dplyr::summarise(

     avg_attendances<- mean(attendances, na.rm = TRUE),

     avg_cancellations<- mean(cancellations, na.rm = TRUE),

     avg_dnas<- mean(non_attendances, na.rm = TRUE)

   )


 })


  output$attendances <- renderValueBox({
    valueBox(
      value = paste0(value_box_posttherapy() %>% dplyr::pull(1)),
      subtitle = "Average Sessions Per Client"
    )
  })

  output$cancellations <- renderValueBox({
    valueBox(
      value = paste0(value_box_posttherapy() %>% dplyr::pull(2)),
      subtitle = "Averange Cancellations Per Client"
    )
  })

  output$dnas <- renderValueBox({
    valueBox(
      value = paste0(value_box_posttherapy() %>% dplyr::pull(3)),
      subtitle = "Average DNAs Per Client"
    )

  })


  output$posttherapy_dropdown<- renderUI({

    #Make named list to pass to dropdown, to avoid underscores between words

    posttherapy_vars<- names(joined_data()[c(37, 38, 39, 43, 44, 45, 46, 47, 48)]) %>%
      purrr::set_names(stringr::str_replace_all(names(joined_data()[c(37, 38, 39, 43, 44, 45, 46, 47, 48)]), "_", " "))

    selectInput("posttherapy_variable", "Select Therapy Outcome",
                choices = posttherapy_vars)
  })



  output$diagnosis_plot<- plotly::renderPlotly({

    df_dsm<- posttherapy_analytics_table() %>% count(principal_diagnosis, secondary_diagnosis) %>% select(principal_diagnosis, secondary_diagnosis, number = n)

    df_dsm<- df_dsm %>% mutate('relative'=unlist(by(data = number, INDICES = principal_diagnosis,
                                            FUN = function(x) round(x/sum(x)*100, digits = 1))))

    df_dsm<- df_dsm %>% group_by(principal_diagnosis) %>% mutate(diagnosis_count = sum(number))

    df_dsm<- df_dsm %>% mutate_if(is.factor, as.character)

    df_dsm$principal_diagnosis[df_dsm$principal_diagnosis == "" | is.na(df_dsm$principal_diagnosis)]<- "Missing"

    df_dsm$secondary_diagnosis[df_dsm$secondary_diagnosis == "" | is.na(df_dsm$secondary_diagnosis)]<- "Missing"


    #create the stacked bar plot based on your data
    p<- ggplot(data = df_dsm, aes(y= number, x=principal_diagnosis, fill=secondary_diagnosis,
                              text = paste("Primary Diagnosis: ", principal_diagnosis, "<br>",
                                           "Number of Cases:", diagnosis_count, "<br>",
                                           "Representents ", round((diagnosis_count/nrow(df) * 100), 2), "% of all primary diagnoses")

    )) +
      geom_bar(stat="identity", width = 0.5) +
      xlab('Primary Diagnosis') + ylab('Count') +
      #use JOELS great solution for the label position
      #and add percentage based on variable 'relative', otherwise use 'number'
      geom_text(aes(x = principal_diagnosis, label = paste0(relative,'%')),
                colour = 'white', position=position_stack(vjust=0.5)) +
      labs(fill='Secondary Diagnosis') + coord_flip() +
      theme(panel.grid.minor.y = element_blank(),
            panel.grid.major.y = element_blank(),
            panel.background = element_blank(),
            panel.grid.major.x = element_line("grey")
      )


    ggplotly(p, tooltip = "text")

  })







  current_category_posttherapy<- reactiveVal()

  output$posttherapy_plot <- plotly::renderPlotly({

    posttherapy<- tibble::tibble(posttherapy_analytics_table()[, req(input$posttherapy_variable)]) %>%
      dplyr::count(.[[1]]) %>% purrr::set_names(c("labels", "values")) %>% dplyr::mutate_if(is.factor, as.character)

    posttherapy$labels[posttherapy$labels == "" | is.na(posttherapy$labels)]<- "Missing"


    plot_ly(posttherapy) %>%
      add_pie(
        labels = ~labels,
        values = ~values,
        customdata = ~labels
      )

  })



  observe({

    cd <- event_data("plotly_click")$customdata[[1]]

    if (isTRUE(cd %in% posttherapy_analytics[,paste(input$posttherapy_variable)])) current_category_posttherapy(cd)

  })


  outcomes_by_posttherapy<- reactive({

    if(length(current_category_posttherapy())) {

      outcomes_df<- posttherapy_analytics_table() %>% dplyr::inner_join(nested_data(), by = c("client_id" = "client_id"))

      outcomes_df<- outcomes_df[, c(input$posttherapy_variable, "improve", "sig_improve", "remained_same", "deteriorated")]

      names(outcomes_df)<- c("selected", "Improvement", "Reliable Improvement", "No Change", "Deterioration")

      outcomes_df<- outcomes_df %>% dplyr::filter(selected %in% current_category_posttherapy())

      outcomes_df_gathered<- outcomes_df %>% tidyr::gather("outcome", "status", -selected) %>% dplyr::filter(status == TRUE)

      outcomes_summary<- forcats::fct_count(outcomes_df_gathered$outcome, sort = TRUE, prop = TRUE) %>% dplyr::mutate(p = p * 100) %>%
        dplyr::select(Variable = f, Count = n, Percent = p)

    }

  })


  output$summary_outcomes_plot_by_posttherapy<- renderPlotly({


    p<- ggplot(req(outcomes_by_posttherapy()), aes(x = paste(current_category_posttherapy()[1]),
                                                   y = Percent,
                                                   fill = forcats::fct_reorder(Variable, Percent),
                                                   text = paste(Variable, "<br>","Count: ", Count))) +
      geom_col() + geom_text(aes(label = paste0(round(Percent, 1), "%")), size = 3,
                             position = position_stack(vjust = 0.5)) +
      theme(legend.title = element_blank(), legend.justification=c(0,0), legend.position=c(0,0), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            axis.line = element_blank()) + xlab("")


    plotly::ggplotly(p, tooltip = "text")


  })


  # populate back button if category is chosen
  output$back_posttherapy <- renderUI({

    if (length(current_category_posttherapy())) actionButton("clear_posttherapy", "Clear", icon("chevron-left"))

  })


  # clear the chosen category on back button press
  observeEvent(input$clear_posttherapy, current_category_posttherapy(NULL))






}



# Run the application
shinyApp(ui = ui, server = server)


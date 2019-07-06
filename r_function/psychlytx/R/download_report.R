#' Submit Nested Data to Report
#'
#' Wrangle selected_client_data pulled from database and pass it to an R Markdown report
#'
#' @param id String to create a unique namespace.
#'
#' @export

download_report_UI<- function(id) {

  ns<- NS(id)

  tagList(

    fluidPage(

      column(width = 7, titlePanel(span(tagList(icon("file-pdf-o", lib = "font-awesome")),
                                        h3(tags$b("Download Your Client's Clinical Report"))))),

      br(),

      sidebarLayout( position = "right",

                     sidebarPanel(

                       downloadButton(ns("report"), "Report Download",
                                      class = "submit_data", lib = "font-awesome") %>%  helper(type = "inline",
                                                                                               title = "Problems with report generation",
                                                                                               colour = "#d35400",
                                                                                               content = c("<b>Your report may fail to generate for three reasons:</b>",
                                                                                                           "",
                                                                                                           "<b>1.</b> You have selected a client with no recorded outcomes.",
                                                                                                           "",
                                                                                                           "<b>2.</b> When finding your client in the dropdown menu, you forgot to click <code style='color:#d35400;'>Select Client</code>.",
                                                                                                           "",
                                                                                                           "<b>3.</b> When completing the questionnaire, you forgot to click <code style='color:#d35400;'>Submit</code>."),
                                                                                               size = "m")

                     ),


                     mainPanel(tags$b("This report will display outcomes across all measures completed by the client using
                                      Measurely web applications."),

                               br(),

                               "*Report generation may take a few moments.")

                     )))

}




#' Submit Nested Data to Report
#'
#' Wrangle selected_client_data pulled from database and pass it to an R Markdown report
#'
#' @param pool The pooled db connection.
#'
#' @param selected_client A string indicating the unique id of the selected client.
#'
#' @param measure The name of the psychological measure.
#'
#' @param most_recent_client_data A dataframe representing the most recently queried data (across all measures) for this patient.
#'
#' @export


download_report<- function(input, output, session, pool, selected_client, global_subscale_info, most_recent_client_data) {


   report_data <- reactive({

     most_recent_client_data$value$date<- as.character(format(most_recent_client_data$value$date, "%d/%m/%Y"))

    #Nest the dataframe: create a list column of dataframes - one per each subscale.
    #We want to group the scores by subscale. So GAD7 should have its own df, PHQ9 should have its own df etc.

    subscale_df <- most_recent_client_data$value %>%
      dplyr::group_by(subscale) %>%
      tidyr::nest() %>% dplyr::arrange(subscale)

    to_keep<- names(global_subscale_info) %in% subscale_df$subscale

    retained_subscale_info<- purrr::keep(global_subscale_info, to_keep)


    subscale_df<- subscale_df %>% dplyr::mutate(subscale_info = retained_subscale_info)



    #Add a 'change' variable for each subscale's dataframe showing statistically reliable change in scores. This is a custom function - see above.

    subscale_df <- subscale_df %>%
      dplyr::mutate(data = purrr::map(data, ~ make_change_variable(.x)))


    #Remove the underscore between words comprising the 'population' variable and replace with white space for report display

    subscale_df<- subscale_df %>% dplyr::mutate(data = purrr::map(data, ~ dplyr::mutate(., population = gsub("_", " ", population))))

    #Change the value of the confidence variable so that percentages (not decimals) appear in the report

    subscale_df <- subscale_df %>%
      dplyr::mutate(data = purrr::map(data, ~ dplyr::mutate(
        .,
        confidence = dplyr::case_when(
          confidence == 1.645 ~ "99%",
          confidence == 1.96 ~ "95%",
          confidence == 2.575 ~ "90%"))))

    #Create a seperate plot for each subscale and store the plots in a list column
    #This is a custom plotting function - see above

    subscale_df <- subscale_df %>%
      dplyr::mutate(plot = purrr::map2(data, subscale_info, ~ plot_subscale(.x, .y)))


    #Make a seperate scores table for each subscale and store the tables in a list column

    subscale_df <- subscale_df %>%
      dplyr::mutate(
        scores_table = purrr::map(
          data, ~ dplyr::select(
            .,
            Date = date,
            Score = score,
            Change = change,
            `CI Upper` = ci_upper,
            `CI Lower` = ci_lower,
            `Predicted True Score` = pts,
            `Standard Error` = se
          ) %>%
            dplyr::mutate(
              Change = kableExtra::cell_spec(Change, "latex", color = if_else(
                is.na(Change), "gray", if_else(
                  grepl("\\*", Change), "red", "gray")))
            ) %>%
            kableExtra::kable(
              format = "latex",
              booktabs = T,
              caption = "Outcomes",
              escape = F,
              linesep = ""
            ) %>%
            kableExtra::kable_styling(latex_options = c("HOLD_position"), full_width = F) %>% kableExtra::row_spec(0, bold = TRUE)
        )
      )

    #Make a statistical info table for each subscale and store the tables in a list column

    subscale_df <- subscale_df %>%
      dplyr::mutate(
        statistics_table_1 = purrr::map(
          data, ~ dplyr::select(
            .,
            Date = date,
            `Comparison Sample` = population,
            Mean = mean,
            Sd = sd,
            `Mean & Sd Reference` = mean_reference
          ) %>%
            dplyr::mutate(
              date2 = as.Date(Date, "%m/%d/%Y")
            ) %>%
            dplyr::arrange(desc(date2)) %>%
            dplyr::slice(1) %>%
            dplyr::select(-date2) %>%
            kableExtra::kable(format = "latex", booktabs = T, caption = "Statistics Employed In Analyses") %>% kableExtra::row_spec(0, bold = TRUE) %>%
            kableExtra::kable_styling(latex_options = c("HOLD_position"), full_width = F) %>%
            kableExtra::column_spec(c(2), width = "4cm") %>%
            kableExtra::column_spec(c(5), width = "7cm")
        )
      )


    #Make another statistical info table for each subscale and store the tables in a list column

    subscale_df <- subscale_df %>%
      dplyr::mutate(
        statistics_table_2 = purrr::map(
          data, ~ dplyr::select(
            .,
            Date = date,
            `Retest Reliability` = reliability,
            `Reliability Reference` = reliability_reference,
            Confidence = confidence,
            `Reliable Change Method` = method
          ) %>%
            dplyr::mutate(
              date2 = as.Date(Date, "%m/%d/%Y")
            ) %>%
            dplyr::arrange(desc(date2)) %>%
            dplyr::slice(1) %>%
            dplyr::select(-date2) %>%
            kableExtra::kable(format = "latex", booktabs = T, caption = "Statistics Employed In Analyses") %>% kableExtra::row_spec(0, bold = TRUE) %>%
            kableExtra::kable_styling(latex_options = c("HOLD_position"), full_width = F) %>%
            kableExtra::column_spec(c(2), width = "2cm") %>%
            kableExtra::column_spec(c(3), width = "6cm") %>%
            kableExtra::column_spec(c(5), width = "3cm")
        )
      )
  })


  client_name<- reactive({ #Pull in the client's first name, last name and birth date from the db, to display in the report.

    client_name_sql<- "SELECT last_name, first_name, CONCAT('D.O.B:', ' ', birth_date)
    FROM client
    WHERE id = ?client_id;"

    client_name_query<- sqlInterpolate(pool, client_name_sql, client_id = selected_client() )

    client_name<- dbGetQuery( pool, client_name_query )


  })

  output$report <- downloadHandler( #Create report download functionality

    filename = paste0("Clinical Report", format(Sys.time(), '%d/%m/%y'),".pdf"),
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempD <- tempdir()
      tempReport <- file.path(tempD, "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      file.copy("logo.png", file.path(tempD, "logo.png"), overwrite = TRUE)

      # Pass data objects to Rmd document
      params <- list(

        report_data = report_data(), #We are passing the nested dataframe to the R markdown report.
        client_name = client_name()

      )

      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).

      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv(),
                                        withProgress(message = 'Your report is generating.',
                                                     detail = 'Please wait a moment...', value = 0, {
                                                       for (i in 1:25) {
                                                         incProgress(1/25)

                                                       }
                                                     })
                        ))})

}

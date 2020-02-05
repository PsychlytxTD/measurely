#' Make Client N by month line plot
#'
#' Show number of new registrations by month
#'
#' @param id A string to create the namespace
#'
#' @export

make_registration_plot_UI<- function(id) {

  ns<- NS(id)
 tagList(
 h3("New Client Registrations", class = "dropdown_headings"),
 plotly::plotlyOutput(ns("registration_plot"), height = '200px')
 )

}

#' Make Client N by month line plot
#'
#' Show number of new registrations by month
#'
#' @param client_table A reactive df representing the data from the client table in the database.
#'
#' @export


make_registration_plot<- function(input, output, session, client_table) {

  process_registration_data<- reactive({

  reg_df<- client_table()

  reg_df$creation_date<- format(reg_df$creation_date,"%b-%y")

  c<- dplyr::count(reg_df, creation_date)

  addon<- tibble::tibble(creation_date = c('Feb-20', 'May-20', 'Jul-20'), n = c(5, 10, 15))

  reg_df<- dplyr::bind_rows(c, addon)

  reg_df$creation_date<- as.Date(paste0("01-", reg_df$creation_date), format = "%d-%b-%Y")

  reg_df<- dplyr::arrange(reg_df, creation_date)

  reg_df$creation_date<- format(reg_df$creation_date, "%b-%y")

  reg_df$creation_date<- factor(reg_df$creation_date, levels = unique(reg_df$creation_date))

  reg_df<- reg_df %>% dplyr::mutate(change = n - lag(n))

  reg_df


  })


  output$registration_plot<- renderPlotly({

    p<- ggplot(process_registration_data(), aes(x = creation_date, y = factor(n),
                                                group = 1, text = paste("Month:", creation_date, "<br>",
                                                                        "New Client Registrations:", n, "<br>",
                                                                        "Change From Previous Month:", sprintf("%+3.1f", change))
                                                )) + geom_line(colour = "#283747") + geom_point(size = 2, colour = "#283747") +
      theme(legend.title = element_blank(), legend.justification=c(0,0), legend.position=c(0,0), panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.grid.major.x = element_line("grey"),
            axis.line = element_blank(),
            axis.text.x = element_text(angle = 90, hjust = 1)) +
      theme(panel.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
            plot.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
            legend.background = element_rect(fill = '#e5e5e5')) + xlab("Month") + ylab("")

    ggplotly(p, tooltip = "text")

  })




}

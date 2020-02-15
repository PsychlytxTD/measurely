#' Make Diagnosis Waffle Plot
#'
#' Make a waffle plot displaying all diagnoses
#'
#' @param id A string to create the namespace.
#'
#' @export


make_diagnosis_waffle_plot_UI<- function(id) {

  ns<- NS(id)


tagList(

  h2("Diagnostic Information", class = "headings"),

  h3("Primary Diagnosis Percentages", class = "dropdown_headings"),

  br(),

  plotOutput(ns("diagnosis_waffle"))

    )

}




#' Make Diagnosis Waffle Plot
#'
#' Make a waffle plot displaying all diagnoses
#'
#' @param posttherapy_analytics_table
#'
#' @export

make_diagnosis_waffle_plot<- function(input, output, session, posttherapy_analytics_table) {

  plot_colours<- grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]

  set.seed(4)
  plot_colours<- sample(plot_colours)

  output$diagnosis_waffle<- renderPlot({

  diagnosis_df<- janitor::tabyl(posttherapy_analytics_table(), principal_diagnosis) %>%
    janitor::adorn_pct_formatting(digits = 0, affix_sign = FALSE) %>% dplyr::mutate(percent = as.numeric(percent))

  to_waffle<- diagnosis_df$percent

  names(to_waffle)<- paste0(diagnosis_df$principal_diagnosis, ": ", diagnosis_df$percent, "%")

  p<- waffle::waffle(to_waffle, rows = 5, use_glyph = "child", size = 3,  equal = FALSE,
                colors = plot_colours[1:nrow(diagnosis_df)], legend_pos = "bottom")

  p + theme(legend.text=element_text(size = 14),
            legend.key = element_blank(),
            panel.background = element_blank(),
            #panel.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
            plot.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'))




  })

}

#' Plot Diagnoses
#'
#' Make stacked bar plot of primary and secondary diagnoses
#'
#' @param id A string to create the namespace
#'
#' @export

plot_diagnoses_UI<- function(id) {

  ns<- NS(id)

  tagList(

  h2("Primary & Secondary Diagnosis Summaries", class = "headings"),

fluidRow(

      plotly::plotlyOutput(ns("diagnosis_plot"))

),

br(),
br(),
br()

)

}



#' Plot Diagnoses
#'
#' Make stacked bar plot of primary and secondary diagnoses
#'
#' @param posttherapy_analytics_table A reactive dataframe with posttherapy analytics data
#'
#' @export


plot_diagnoses<- function(input, output, session, posttherapy_analytics_table) {


  process_diagnoses<- reactive({


    df_dsm<- req(posttherapy_analytics_table()) %>% count(principal_diagnosis, secondary_diagnosis) %>% select(principal_diagnosis, secondary_diagnosis, number = n)

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
                                               "Representents ", round((diagnosis_count/nrow(df_dsm) * 100), 2), "% of all primary diagnoses")

    )) +
      geom_bar(stat="identity", width = 0.5) +
      xlab('Primary Diagnosis') + ylab('Number of Cases') +
      #use JOELS great solution for the label position
      #and add percentage based on variable 'relative', otherwise use 'number'
      geom_text(aes(x = principal_diagnosis, label = paste0(relative,'%')),
                colour = 'white', position=position_stack(vjust=0.5)) +
      labs(fill='Secondary Diagnosis') + coord_flip() +
      theme(panel.grid.minor.y = element_blank(),
            panel.grid.major.y = element_blank(),
            panel.background = element_blank(),
            panel.grid.major.x = element_line("grey")
      ) + theme(panel.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
            plot.background = element_rect(fill = '#e5e5e5', colour = '#e5e5e5'),
            legend.background = element_rect(fill = '#e5e5e5'))


    ggplotly(p, tooltip = "text")


  })




  #Create plot of diagnoses

output$diagnosis_plot<- plotly::renderPlotly({

  process_diagnoses()

})

}
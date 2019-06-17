CPAQ_20_Activity_Engagement<- list(  title = "Activity Engagement Subscale", #Title can contain white space. For insertion into widget headings, plot titles etc.
                      brief_title = "Activity Engagement",
                      measure = "CPAQ_20", #The overal measure (which may contain subscales)
                      subscale = "CPAQ_20_Activity_Engagement", #The specific subscale of the measure.
                      population_quantity = 2,
                      populations = list("Chronic Pain", "Other"),
                      means = list(30.12, 0),
                      sds = list(11.91, 0),
                      mean_sd_references = list("Baranoff, Hanrahan, Kapur & Connor (2012)", "Define Value"),
                      reliabilities = list(.86, 0),
                      reliability_references = list("Fish, Hogan, Morrison, Stewart & McGuire (2013)", "Define Value"),
                      cutoff_values = list(c(12.4, 23.3, 41.9, 30.12 + (1.5 * 11.91), 30.12 + (2 * 11.91)), c(0, 0, 0, 0, 0)),
                      cutoff_labels = list(c("Low Cluster", "Medium Cluster", "High Cluster", "Mean + 1.5 Sd", "Mean + 2 Sd"), c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value")),
                      cutoff_references = list(c("Rovner, Vowles, Gerdle & Gillanders (2015)", "Rovner, Vowles, Gerdle & Gillanders (2015)",
                                                 "Rovner, Vowles, Gerdle & Gillanders (2015)", "Baranoff, Hanrahan, Kapur & Connor (2012)",
                                                "Baranoff, Hanrahan, Kapur & Connor (2012)"),
                                               c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value")),
                      cutoff_quantity = 5,
                      items = c(1,2,3,5,6,8,9,10,12,15,19),
                      max_score = 66,
                      min_score = 0,
                      description = NULL,
                      sample_overview = list(c("334 Australian patients attending multidisciplinary pain service."),
                                             c("No sample information to provide.")
                      ),
                      journal_references = list(c("Baranoff, J., Hanrahan, S. J., Kapur, D., & Connor, J. P. (2014). Validation of the chronic pain acceptance
                                                  questionnaire-8 in an Australian pain clinic sample. International Journal of Behavioral Medicine, 21(1), 177-185."),
                                                c("No sample information to provide."))

                      )

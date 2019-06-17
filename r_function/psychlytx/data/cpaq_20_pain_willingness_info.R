CPAQ_20_Pain_Willingness<- list(  title = "Pain Willingness Subscale", #Title can contain white space. For insertion into widget headings, plot titles etc.
                                          brief_title = "Pain Willingness",
                                          measure = "CPAQ_20", #The overal measure (which may contain subscales)
                                          subscale = "CPAQ_20_Pain_Willingness", #The specific subscale of the measure.
                                          population_quantity = 2,
                                          populations = list("Chronic Pain", "Other"),
                                          means = list(18.73, 0),
                                          sds = list(9.08, 0),
                                          mean_sd_references = list("Baranoff, Hanrahan, Kapur & Connor (2012)", "Define Value"),
                                          reliabilities = list(.68, 0),
                                          reliability_references = list("Fish, Hogan, Morrison, Stewart & McGuire (2013)", "Define Value"),
                                          cutoff_values = list(c(10.9, 24.2, 33, 18.73 +  9.08, 18.73 + (2 * 9.08)), c(0, 0, 0, 0, 0)),
                                          cutoff_labels = list(c("Low Cluster", "Medium Cluster", "High Cluster", "Mean + 1 Sd", "Mean + 2 Sd"), c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value")),
                                          cutoff_references = list(c("Rovner, Vowles, Gerdle & Gillanders (2015)", "Rovner, Vowles, Gerdle & Gillanders (2015)",
                                                                     "Rovner, Vowles, Gerdle & Gillanders (2015)", "Baranoff, Hanrahan, Kapur & Connor (2012)",
                                                                     "Baranoff, Hanrahan, Kapur & Connor (2012)"),
                                                                   c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value")),
                                          cutoff_quantity = 5,
                                          items = c(4,7,11,13,14,16,17,18,20),
                                          max_score = 54,
                                          min_score = 0,
                                          description = readr::read_file(
                                            "cpaq_20.md"
                                          ),
                                          sample_overview = list(c("334 Australian patients attending multidisciplinary pain service."),
                                                                 c("No sample information to provide.")
                                          ),
                                          journal_references = list(c("Baranoff, J., Hanrahan, S. J., Kapur, D., & Connor, J. P. (2014). Validation of the chronic pain acceptance
                                                                      questionnaire-8 in an Australian pain clinic sample. International Journal of Behavioral Medicine, 21(1), 177-185."),
                                                                    c("No sample information to provide."))

                                          )

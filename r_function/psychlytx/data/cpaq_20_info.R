CPAQ_20<- list(  title = "Chronic Pain Acceptance Questionnaire - 20 (CPAQ-20)", #Title can contain white space. For insertion into widget headings, plot titles etc.
                   brief_title = "CPAQ-20",
                   measure = "CPAQ_20", #The overal measure (which may contain subscales)
                   subscale = "CPAQ_20", #The specific subscale of the measure.
                   population_quantity = 2,
                   populations = list("Chronic Pain", "Other"),
                   means = list(48.48, 0),
                   sds = list(16.83, 0),
                   mean_sd_references = list("Baranoff, Hanrahan, Kapur & Connor (2012)", "Define Value"),
                   reliabilities = list(.81, 0),
                   reliability_references = list("Fish, Hogan, Morrison, Stewart & McGuire (2013)", "Define Value"),
                   cutoff_values = list(c(23.6, 47.6, 48.48 + 16.83, 74.9, 48.48 + (2*16.83)), c(0, 0, 0, 0, 0)),
                   cutoff_labels = list(c("Low Cluster", "Medium Cluster", "Mean + 1 Sd", "High Cluster", "Mean + 2 Sd"), c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value")),
                   cutoff_references = list(c("Rovner, Vowles, Gerdle & Gillanders (2015)", "Rovner, Vowles, Gerdle & Gillanders (2015)", "Baranoff, Hanrahan, Kapur & Connor (2012)",
                                              "Rovner, Vowles, Gerdle & Gillanders (2015)", "Baranoff, Hanrahan, Kapur & Connor (2012)"),
                                            c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value")),
                   cutoff_quantity = 5,
                   items = 1:20,
                   max_score = 120,
                   min_score = 0,
                   description = NULL,
                   sample_overview = list(c("334 Australian patients attending multidisciplinary pain service."),
                                          c("No sample information to provide.")
                   ),
                   journal_references = list(c("Baranoff, J., Hanrahan, S. J., Kapur, D., & Connor, J. P. (2014). Validation of the chronic pain acceptance
                                               questionnaire-8 in an Australian pain clinic sample. International Journal of Behavioral Medicine, 21(1), 177-185."),
                                             c("No sample information to provide."))

                   )

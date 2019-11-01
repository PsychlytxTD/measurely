OCI_R<- list(  title = "Obsessive Compulsive Inventory - Revised (OCI-R)", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "OCI-R",
               measure = "OCI_R", #The overal measure (which may contain subscales)
               subscale = "OCI_R", #The specific subscale of the measure.
               population_quantity = 2,
               populations = list("OCD", "University_Student"),
               means = list(28.1, 18.82),
               sds = list(13.53, 11.1),
               mean_sd_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
               reliabilities = list(.82, .82),
               reliability_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
               cutoff_values = list(
                 c(21, 28.1, 28.1 + 13.53, 28.1 + (1.5 *13.53), 28.1 + (2 *13.53), 28.1 + (3 *13.53)),
                 c(18.82, 21, 18.82 + 11.1, 18.82 + (1.5 * 11.1), 18.82 + (2 * 11.1), 18.82 + (3 * 11.1))
               ),
               cutoff_labels = list(
                 c("OCD", "Mean", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
                 c("Mean", "OCD", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd")
               ),
               cutoff_references = list(
                 c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                   "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                   "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                 c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                   "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                   "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)")
               ),
               cutoff_quantity = 6,
               items = 1:18,
               max_score = 72,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = NULL,
               sample_overview = list(
                 c("215 Americans with OCD"),
                 c("477 American non-anxious university students")
               ),
               journal_references = list(
                 c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                   Development and validation of a short version. Psychological Assessment, 14(4), 485."),
                 c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                   Development and validation of a short version. Psychological Assessment, 14(4), 485.")
               )

                )


OCI_R_Washing<- list(  title = "OCI-R Washing", #Title can contain white space. For insertion into widget headings, plot titles etc.
              brief_title = "OCI-R Washing",
              measure = "OCI_R", #The overal measure (which may contain subscales)
              subscale = "OCI_R_Washing", #The specific subscale of the measure.
              population_quantity = 2,
              populations = list("OCD", "University_Student"),
              means = list(4.35, 2.41),
              sds = list(4.31, 2.5),
              mean_sd_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
              reliabilities = list(.91, .91),
              reliability_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
              cutoff_values = list(
                c(5.35 - 4.31, 4.35, 4.35 + (0.5 *4.31), 4.35 + 4.31, 4.35 + (1.5 *4.31), 4.35 + (1.7 *4.31)),
                c(2.41, 2.41 + 2.5, 2.41 + (1.5 *2.5), 2.41 + (2 * 2.5), 2.41 + (3 * 2.5), 2.41 + (4 * 2.5))

              ),
              cutoff_labels = list(
                c("Mean - Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 1.7 Sd"),
                c("Mean", "Mean + Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd", "Mean + 4 Sd")

              ),
              cutoff_references = list(
                c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                  "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                  "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                  "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                  "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)")
              ),
              cutoff_quantity = 6,
              items = c(5,11,17),
              max_score = 12,
              min_score = 0,
              plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
              plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
              plot_cutoff_label_size = 3,
              description = NULL,
              sample_overview = list(
                c("215 Americans with OCD"),
                c("478 American non-anxious university students")
              ),
              journal_references = list(
                c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                  Development and validation of a short version. Psychological Assessment, 14(4), 485."),
                c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                  Development and validation of a short version. Psychological Assessment, 14(4), 485.")
                )

                )



OCI_R_Checking<- list(  title = "OCI-R Checking", #Title can contain white space. For insertion into widget headings, plot titles etc.
                       brief_title = "OCI-R Checking",
                       measure = "OCI_R", #The overal measure (which may contain subscales)
                       subscale = "OCI_R_Checking", #The specific subscale of the measure.
                       population_quantity = 2,
                       populations = list("OCD", "University_Student"),
                       means = list(4.83, 2.91),
                       sds = list(3.86, 2.56),
                       mean_sd_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                       reliabilities = list(.74, .74),
                       reliability_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                       cutoff_values = list(
                         c(4.83 - 3.86, 4.83, 4.83 + (0.5 *3.86), 4.83 + (1 * 3.86), 4.83 + (1.5 * 3.86), 4.83 + (1.8 * 3.86)),
                         c(2.91 - 2.56, 2.91, 2.91 + (1* 2.56), 2.91 + (1.5 * 2.56), 2.91 + (2 * 2.56), 2.91 + (3 * 2.56))

                       ),
                       cutoff_labels = list(
                         c("Mean - 1 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 1.8 Sd"),
                         c("Mean - 1 Sd", "Mean", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd")

                       ),
                       cutoff_references = list(
                         c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                           "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                           "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                         c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                           "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                           "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)")
                       ),
                       cutoff_quantity = 6,
                       items = c(2,8,14),
                       max_score = 12,
                       min_score = 0,
                       plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
                       plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
                       plot_cutoff_label_size = 3,
                       description = NULL,
                       sample_overview = list(
                         c("215 Americans with OCD"),
                         c("479 American non-anxious university students")
                       ),
                       journal_references = list(
                         c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                           Development and validation of a short version. Psychological Assessment, 14(4), 485."),
                         c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                           Development and validation of a short version. Psychological Assessment, 14(4), 485.")
                         )

                    )



OCI_R_Ordering<- list(  title = "OCI-R Ordering", #Title can contain white space. For insertion into widget headings, plot titles etc.
                        brief_title = "OCI-R Ordering",
                        measure = "OCI_R", #The overal measure (which may contain subscales)
                        subscale = "OCI_R_Ordering", #The specific subscale of the measure.
                        population_quantity = 2,
                        populations = list("OCD", "University_Student"),
                        means = list(4.76, 4.4),
                        sds = list(4, 3.03),
                        mean_sd_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                        reliabilities = list(.84, .84),
                        reliability_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                        cutoff_values = list(
                          c(4.76 - 4, 4.76, 4.76 + (0.5 * 4), 4.76 + 4, 4.76 + (1.5 * 4), 4.76 + (1.8 * 4)),
                          c(4.4 - 3.03, 4.4, 4.4 + (0.5 * 3.03), 4.4 + 3.03, 4.4 + (1.5 * 3.03), 4.4 + (2 * 3.03))

                        ),
                        cutoff_labels = list(
                          c("Mean - Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 1.8 Sd"),
                          c("Mean - Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd")

                        ),
                        cutoff_references = list(
                          c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                            "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                            "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                          c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                            "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                            "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)")
                        ),
                        cutoff_quantity = 6,
                        items = c(3,9,15),
                        max_score = 12,
                        min_score = 0,
                        plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
                        plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
                        plot_cutoff_label_size = 3,
                        description = NULL,
                        sample_overview = list(
                          c("215 Americans with OCD"),
                          c("480 American non-anxious university students")
                        ),
                        journal_references = list(
                          c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                            Development and validation of a short version. Psychological Assessment, 14(4), 485."),
                          c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                            Development and validation of a short version. Psychological Assessment, 14(4), 485.")
                          )

                          )



OCI_R_Obsessing<- list(  title = "OCI-R Obsessing", #Title can contain white space. For insertion into widget headings, plot titles etc.
                        brief_title = "OCI-R Obsessing",
                        measure = "OCI_R", #The overal measure (which may contain subscales)
                        subscale = "OCI_R_Obsessing", #The specific subscale of the measure.
                        population_quantity = 2,
                        populations = list("OCD", "University_Student"),
                        means = list(7.23, 2.86),
                        sds = list(3.84, 2.72),
                        mean_sd_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                        reliabilities = list(.84, .84),
                        reliability_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                        cutoff_values = list(
                          c(7.23 - 3.84, 7.23 - (0.5 * 3.84), 7.23, 7.23 + (0.5 * 3.84), 7.23 + (0.75 * 3.84), 7.23 + 3.84),
                          c(2.86 - 2.72, 2.86, 2.86 + 2.72, 2.86 + (1.5 * 2.72), 2.86 + (2 * 2.72), 2.86 + (3 * 2.72))

                        ),
                        cutoff_labels = list(
                          c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 0.75 Sd", "Mean + 1 Sd"),
                          c("Mean - 1 Sd", "Mean", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd")

                        ),
                        cutoff_references = list(
                          c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                            "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                            "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                          c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                            "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                            "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)")
                        ),
                        cutoff_quantity = 6,
                        items = c(6,12,18),
                        max_score = 12,
                        min_score = 0,
                        plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
                        plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
                        plot_cutoff_label_size = 3,
                        description = NULL,
                        sample_overview = list(
                          c("215 Americans with OCD"),
                          c("481 American non-anxious university students")
                        ),
                        journal_references = list(
                          c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                            Development and validation of a short version. Psychological Assessment, 14(4), 485."),
                          c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                            Development and validation of a short version. Psychological Assessment, 14(4), 485.")
                          )

                          )



OCI_R_Hoarding<- list(  title = "OCI-R Hoarding", #Title can contain white space. For insertion into widget headings, plot titles etc.
                         brief_title = "OCI-R Hoarding",
                         measure = "OCI_R", #The overal measure (which may contain subscales)
                         subscale = "OCI_R_Hoarding", #The specific subscale of the measure.
                         population_quantity = 2,
                         populations = list("OCD", "University_Student"),
                         means = list(3.67, 4.41),
                         sds = list(3.87, 2.67),
                         mean_sd_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                         reliabilities = list(.79, .79),
                         reliability_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                         cutoff_values = list(
                           c(3.67 - (0.5 * 3.87), 3.67, 3.67 + (0.5 * 3.87), 6, 3.67 + 3.87, 3.67 + (1.5 * 3.87)),
                           c(4.41 - 2.67, 4.41, 6, 4.41 + (1 * 2.67), 4.41 + (2 * 2.67), 4.41 + (2.5 * 2.67))

                         ),
                         cutoff_labels = list(
                           c("Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Hoarding Disorder", "Mean + 1 Sd", "Mean + 1.6 Sd"),
                           c("Mean - 1 Sd", "Mean", "Hoarding Disorder", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd")

                         ),
                         cutoff_references = list(
                           c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                             "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                             "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                           c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                             "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                             "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)")
                         ),
                         cutoff_quantity = 6,
                         items = c(1,7,13),
                         max_score = 12,
                         min_score = 0,
                         plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
                         plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
                         plot_cutoff_label_size = 3,
                         description = NULL,
                         sample_overview = list(
                           c("215 Americans with OCD"),
                           c("482 American non-anxious university students")
                         ),
                         journal_references = list(
                           c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                             Development and validation of a short version. Psychological Assessment, 14(4), 485."),
                           c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                             Development and validation of a short version. Psychological Assessment, 14(4), 485.")
                           )

                           )




OCI_R_Neutralizing<- list(  title = "OCI-R Neutralizing", #Title can contain white space. For insertion into widget headings, plot titles etc.
                         brief_title = "OCI-R Neutralizing",
                         measure = "OCI_R", #The overal measure (which may contain subscales)
                         subscale = "OCI_R_Neutralizing", #The specific subscale of the measure.
                         population_quantity = 2,
                         populations = list("OCD", "University_Student"),
                         means = list(3.18, 1.82),
                         sds = list(3.81, 2.2),
                         mean_sd_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                         reliabilities = list(.82, .82),
                         reliability_references = list("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                         cutoff_values = list(
                           c(3.18 - (0.5 * 3.81), 3.18, 3.18 + (0.5 * 3.81), 3.18 + 3.81, 3.18 + (1.5 * 3.81), 3.18 + (2 * 3.81)),
                           c(1.82, 1.82 + 2.2, 1.82 + (2 * 2.2), 1.82 + (3 * 2.2), 1.82 + (4 * 2.2), 1.82 + (4.5 * 2.2))

                         ),
                         cutoff_labels = list(
                           c("Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd"),
                           c("Mean", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd", "Mean + 4 Sd", "Mean + 4.5 Sd")

                         ),
                         cutoff_references = list(
                           c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                             "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                             "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)"),
                           c("Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                             "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)",
                             "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)", "Foa, Huppert, Leiberg, Langner, Kichic et al. (2002)")
                         ),
                         cutoff_quantity = 6,
                         items = c(4,10,16),
                         max_score = 12,
                         min_score = 0,
                         plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
                         plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
                         plot_cutoff_label_size = 3,
                         description = readr::read_file(
                           "OCI_R.md"
                         ),
                         sample_overview = list(
                           c("215 Americans with OCD"),
                           c("483 American non-anxious university students")
                         ),
                         journal_references = list(
                           c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                             Development and validation of a short version. Psychological Assessment, 14(4), 485."),
                           c("Foa, E. B., Huppert, J. D., Leiberg, S., Langner, R., Kichic, R., Hajcak, G., & Salkovskis, P. M. (2002). The obsessive-compulsive inventory:
                             Development and validation of a short version. Psychological Assessment, 14(4), 485.")
                           )

                           )


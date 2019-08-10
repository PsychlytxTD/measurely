SPS<- list(  title = "Social Phobia Scale (SPS)", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "SPS",
               measure = "SPS", #The overal measure (which may contain subscales)
               subscale = "SPS", #The specific subscale of the measure.
               population_quantity = 3,
               populations = list("Social Anxiety Disorder", "General Population", "University Student"),
               means = list(40, 14.4, 15.85),
               sds = list(16, 16, 12.93),
               mean_sd_references = list("Mattick & Clarke (1998)", "Mattick & Clarke (1998)", "Boyers, Broman-Fulks, Valentiner, McCraw, Curtin et al. (2017)"),
               reliabilities = list(0.96, 0.96, 0.96),
               reliability_references = list("Stangier, Heidenreich, Berardi, Golbs & Hoyer (1999)", "Stangier, Heidenreich, Berardi, Golbs & Hoyer (1999)",
                                             "Stangier, Heidenreich, Berardi, Golbs & Hoyer (1999)"),
               cutoff_values = list(c(24, 40, 40 + 16, 40 + (1.5 * 16), 40 + (2 * 16), 40 + (3 * 16)),
                                    c(14.4, 24, 14.4 + 16, 14.4 + (1.5 * 16), 14.4 + (2 * 16), 14.4 + (3 * 16)),
                                    c(15.85, 24, 14.85 + 12.93, 15.85 + (1.5 * 12.93), 15.85 + (2 * 12.93), 15.85 + (3 * 12.93))
                                    ),
               cutoff_labels = list(
                 c("Social Phobia", "Mean", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
                 c("Mean", "Social Phobia", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
                 c("Mean", "Social Phobia", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd")
               ),
               cutoff_references = list(
                 c("Heimberg et al. (1992)", "Mattick & Clarke (1998)", "Mattick & Clarke (1998)", "Mattick & Clarke (1998)", "Mattick & Clarke (1998)",
                   "Mattick & Clarke (1998)"),
                 c("Mattick & Clarke (1998)", "Heimberg et al. (1992)", "Mattick & Clarke (1998)", "Mattick & Clarke (1998)", "Mattick & Clarke (1998)",
                   "Mattick & Clarke (1998)"),
                 c("Boyers, Broman-Fulks, Valentiner, McCraw, Curtin et al. (2017)", "Heimberg et al. (1992)",
                   "Boyers, Broman-Fulks, Valentiner, McCraw, Curtin et al. (2017)", "Boyers, Broman-Fulks, Valentiner, McCraw, Curtin et al. (2017)",
                   "Boyers, Broman-Fulks, Valentiner, McCraw, Curtin et al. (2017)", "Boyers, Broman-Fulks, Valentiner, McCraw, Curtin et al. (2017)")

               ),
               cutoff_quantity = 6,
               items = 20,
               max_score = 80,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = readr::read_file(
                 "SPS.md"
               ),
               sample_overview = list(
                 c("243 American participants with Social Phobia"),
                 c("315 American community participants"),
                 c("2019 American university students")
               ),
               journal_references = list(
                 c("Mattick, R. P., & Clarke, J. C. (1998). Development and validation of measures of social phobia scrutiny fear and social interaction anxiety.
                   Behaviour Research and Therapy, 36(4), 455-470."),
                 c("Mattick, R. P., & Clarke, J. C. (1998). Development and validation of measures of social phobia scrutiny fear and social interaction anxiety.
                   Behaviour Research and Therapy, 36(4), 455-470."),
                 c("Boyers, G. B., Broman-Fulks, J. J., Valentiner, D. P., McCraw, K., Curtin, L., & Michael, K. D. (2017). The latent structure of social anxiety disorder
                    and the performance only specifier: A taxometric analysis. Cognitive Behaviour Therapy, 46(6), 507-521.")
                  )

                )

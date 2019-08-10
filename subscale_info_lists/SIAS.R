SIAS<- list(  title = "Social Interaction Anxiety Scale (SIAS)", #Title can contain white space. For insertion into widget headings, plot titles etc.
             brief_title = "SIAS",
             measure = "SIAS", #The overal measure (which may contain subscales)
             subscale = "SIAS", #The specific subscale of the measure.
             population_quantity = 3,
             populations = list("Social Anxiety Disorder", "General Population", "University Student"),
             means = list(34.6, 18.8, 17.17),
             sds = list(16.4, 11.8, 12.01),
             mean_sd_references = list("Mattick & Clarke (1998)", "Mattick & Clarke (1998)", "Boyers, Broman-Fulks, Valentiner, McCraw, Curtin et al. (2017)"),
             reliabilities = list(0.96, 0.96, 0.96),
             reliability_references = list("Stangier, Heidenreich, Berardi, Golbs & Hoyer (1999)", "Stangier, Heidenreich, Berardi, Golbs & Hoyer (1999)",
                                           "Stangier, Heidenreich, Berardi, Golbs & Hoyer (1999)"),
             cutoff_values = list(c(34, 34.6 + 16.4, 34.6 + (1.5 * 16.4), 34.6 + (2 * 16.4), 34.6 + (2.5 * 16.4), 34.6 + (2.75 * 16.4)),
                                  c(18.8, 34, 18.8 + 11.8, 18.8 + (2 * 11.8), 18.8 + (3 * 11.8), 18.8 + (4 * 11.8)),
                                  c(17.17, 34, 17.17 + 12.01, 17.17 + (2 * 12.01), 17.17 + (3 * 12.01), 17.17 + (4 * 12.01))
             ),
             cutoff_labels = list(
               c("Social Phobia", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 2.5 Sd", "Mean + 2.75 Sd"),
               c("Mean", "Social Phobia", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
               c("Mean", "Social Phobia", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd", "Mean + 4 Sd")
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
               "SIAS.md"
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
               c( "Boyers, G. B., Broman-Fulks, J. J., Valentiner, D. P., McCraw, K., Curtin, L., & Michael, K. D. (2017). The latent structure of social anxiety disorder
                  and the performance only specifier: A taxometric analysis. Cognitive Behaviour Therapy, 46(6), 507-521.")
               )

               )


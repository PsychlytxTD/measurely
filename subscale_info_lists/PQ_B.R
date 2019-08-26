PQ_B<- list(  title = "Prodromal Questionnaire - Brief Version", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "PQ-B",
               measure = "PQ_B", #The overal measure (which may contain subscales)
               subscale = "PQ_B", #The specific subscale of the measure.
               population_quantity = 1,
               populations = list("Adolescent/Young Adult"),
               means = list(5.26),
               sds = list(4.39),
               mean_sd_references = list("Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)"),
               reliabilities = list(.81),
               reliability_references = list("Kline, Wilson, Ereshefsky, Tsuji, Schiffman et al. (2012)"),
               cutoff_values = list(
                 c(5.26 - 4.39, 5.26, 9, 5.26 + (1.5 * 4.39), 5.26 + (2* 4.39), 5.26 + (2.5 * 4.39))
               ),
               cutoff_labels = list(
                 c("Mean - 1 Sd", "Mean", "Clinical High Risk Status", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 2.5 Sd")
               ),
               cutoff_references = list(
                 c("Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)", "Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)",
                    "Kline, Thompson, Pitts, Reeves & Schiffman (2014)", "Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)",
                   "Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)", "Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)")
               ),
               cutoff_quantity = 6,
               items = 1:21,
               max_score = 21,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = readr::read_file(
                 "PQ_B.md"
               ),
               sample_overview = list(
                 c("449 Spanish high-school students aged 12-19.")
               ),
               journal_references = list(
                 c("Fonseca-Pedrero, E., Gooding, D. C., Ortuno-Sierra, J., Pflum, M., Paino, M., & Muniz, J. (2016).
                   Classifying risk status of non-clinical adolescents using psychometric indicators for psychosis
                   spectrum disorders. Psychiatry Research, 243, 246-254. doi:10.1016/j.psychres.2016.06.049")
               )

                )


PQ_B_Distress<- list(  title = "PQ-B Distress", #Title can contain white space. For insertion into widget headings, plot titles etc.
              brief_title = "PQ-B Distress",
              measure = "PQ_B", #The overal measure (which may contain subscales)
              subscale = "PQ_B_Distress", #The specific subscale of the measure.
              population_quantity = 1,
              populations = list("Adolescent/Young Adult"),
              means = list(14.04),
              sds = list(13.74),
              mean_sd_references = list("Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)"),
              reliabilities = list(.89),
              reliability_references = list("Cicero, Krief & Martin (2017)"),
              cutoff_values = list(
                c(14.04 - 13.74, 14.04, 18, 14.4 + 13.74, 14.4 + (2 *13.74), 14.4 + (3 *13.74))
              ),
              cutoff_labels = list(
                c("Mean - 1 Sd", "Mean", "Clinical High Risk", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd")
              ),
              cutoff_references = list(
                c("Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)", "Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)",
                  "Kline, Thompson, Pitts, Reeves & Schiffman (2014)", "Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)",
                  "Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)", "Fonseca-Pedrero, Gooding, Ortuño-Sierra, Pflum, Paino et al. (2016)")
              ),
              cutoff_quantity = 6,
              items = 22:42,
              max_score = 105,
              min_score = 0,
              plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
              plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
              plot_cutoff_label_size = 3,
              description = readr::read_file(
                "PQ_B.md"
              ),
              sample_overview = list(
                c("449 Spanish high-school students aged 12-19.")
              ),
              journal_references = list(
                c("Fonseca-Pedrero, E., Gooding, D. C., Ortuno-Sierra, J., Pflum, M., Paino, M., & Muniz, J. (2016).
                  Classifying risk status of non-clinical adolescents using psychometric indicators for psychosis
                  spectrum disorders. Psychiatry Research, 243, 246-254. doi:10.1016/j.psychres.2016.06.049")
                )

                )

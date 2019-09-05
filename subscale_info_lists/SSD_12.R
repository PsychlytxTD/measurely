SSD_12<- list(  title = "Somatic Symptom Disorder - B Criteria Scale (SSD-12)", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "SSD-12",
               measure = "SSD_12", #The overal measure (which may contain subscales)
               subscale = "SSD_12", #The specific subscale of the measure.
               population_quantity = 7,
               populations = list("General_Population:_14-24_Years", "General_Population:_25-34_Years", "General_Population:_35-44_Years",
                                  "General_Population:_45-54_Years", "General_Population:_55-64_Years", "General_Population:_65-74_Years",
                                  "General_Population:_Above_74_Years", "Primary_Care", "Psychosomatic_Outpatient"),
               means = list(7.85, 7.85, 7.85, 7.85, 7.85, 7.85, 7.85),
               sds = list(9.3, 9.3, 9.3, 9.3, 9.3, 9.3, 9.3),
               mean_sd_references = list("Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                                         "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                                         "Toussaint, Löwe, Brähler & Jordan (2017)"),
               reliabilities = list(.95, .95, .95, .95, .95, .95, .95),
               reliability_references = list("Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                                             "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                                             "Toussaint, Löwe, Brähler & Jordan (2017)"),
               cutoff_values = list(
                 c(6, 9, 12, 15, 17, 20),
                 c(9, 12, 14, 18, 20, 23),
                 c(11, 14, 17, 20, 22, 25),
                 c(13, 16, 19, 22, 25, 28),
                 c(15, 18, 21, 25, 27, 30),
                 c(17, 20, 24, 27, 29, 32),
                 c(20, 23, 26, 29, 32, 35)
               ),
               cutoff_labels = list(
                 c("Medium Psychological Burden (Male)", "Medium Psychological Burden (Female)", "High Psychological Burden (Male)",
                   "High Psychological Burden (Female)", "Very High Psychological Burden (Male)", "Very High Psychological Burden (Female)"),
                 c("Medium Psychological Burden (Male)", "Medium Psychological Burden (Female)", "High Psychological Burden (Male)",
                   "High Psychological Burden (Female)", "Very High Psychological Burden (Male)", "Very High Psychological Burden (Female)"),
                 c("Medium Psychological Burden (Male)", "Medium Psychological Burden (Female)", "High Psychological Burden (Male)",
                   "High Psychological Burden (Female)", "Very High Psychological Burden (Male)", "Very High Psychological Burden (Female)"),
                 c("Medium Psychological Burden (Male)", "Medium Psychological Burden (Female)", "High Psychological Burden (Male)",
                   "High Psychological Burden (Female)", "Very High Psychological Burden (Male)", "Very High Psychological Burden (Female)"),
                 c("Medium Psychological Burden (Male)", "Medium Psychological Burden (Female)", "High Psychological Burden (Male)",
                   "High Psychological Burden (Female)", "Very High Psychological Burden (Male)", "Very High Psychological Burden (Female)"),
                 c("Medium Psychological Burden (Male)", "Medium Psychological Burden (Female)", "High Psychological Burden (Male)",
                   "High Psychological Burden (Female)", "Very High Psychological Burden (Male)", "Very High Psychological Burden (Female)"),
                 c("Medium Psychological Burden (Male)", "Medium Psychological Burden (Female)", "High Psychological Burden (Male)",
                   "High Psychological Burden (Female)", "Very High Psychological Burden (Male)", "Very High Psychological Burden (Female)")

               ),
               cutoff_references = list(
                 c("Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                   "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)"),
                 c("Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                   "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)"),
                 c("Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                   "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)"),
                 c("Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                   "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)"),
                 c("Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                   "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)"),
                 c("Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                   "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)"),
                 c("Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)",
                   "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)", "Toussaint, Löwe, Brähler & Jordan (2017)")
               ),
               cutoff_quantity = 6,
               items = 1:12,
               max_score = 48 ,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = readr::read_file(
                 "SSD_12.md"
               ),
               sample_overview = list(
                 c("282 Germans aged 14-24 years, representative of the general population."),
                 c("366 Germans aged 25-34 years, representative of the general population."),
                 c("373 Germans aged 35-44 years, representative of the general population."),
                 c("488 Germans aged 45-54 years, representative of the general population."),
                 c("462 Germans aged 55-64 years, representative of the general population."),
                 c("335 Germans aged 65-74 years, representative of the general population."),
                 c("218 Germans aged above 74 years, representative of the general population.")
               ),
               journal_references = list(
                 c("Toussaint, A., Löwe, B, Bräler, E., & Jordan, P. (2017). The Somatic Symptom Disorder - B Criteria Scale (SSD-12): Factorial structure,
                   validity and population-based norms. Journal of Psychosomatic Research, 97, 9-17."),
                 c("Toussaint, A., Löwe, B, Bräler, E., & Jordan, P. (2017). The Somatic Symptom Disorder - B Criteria Scale (SSD-12): Factorial structure,
                   validity and population-based norms. Journal of Psychosomatic Research, 97, 9-17."),
                 c("Toussaint, A., Löwe, B, Bräler, E., & Jordan, P. (2017). The Somatic Symptom Disorder - B Criteria Scale (SSD-12): Factorial structure,
                   validity and population-based norms. Journal of Psychosomatic Research, 97, 9-17."),
                 c("Toussaint, A., Löwe, B, Bräler, E., & Jordan, P. (2017). The Somatic Symptom Disorder - B Criteria Scale (SSD-12): Factorial structure,
                   validity and population-based norms. Journal of Psychosomatic Research, 97, 9-17."),
                 c("Toussaint, A., Löwe, B, Bräler, E., & Jordan, P. (2017). The Somatic Symptom Disorder - B Criteria Scale (SSD-12): Factorial structure,
                   validity and population-based norms. Journal of Psychosomatic Research, 97, 9-17."),
                 c("Toussaint, A., Löwe, B, Bräler, E., & Jordan, P. (2017). The Somatic Symptom Disorder - B Criteria Scale (SSD-12): Factorial structure,
                   validity and population-based norms. Journal of Psychosomatic Research, 97, 9-17."),
                 c("Toussaint, A., Löwe, B, Bräler, E., & Jordan, P. (2017). The Somatic Symptom Disorder - B Criteria Scale (SSD-12): Factorial structure,
                   validity and population-based norms. Journal of Psychosomatic Research, 97, 9-17.")
               )

                )

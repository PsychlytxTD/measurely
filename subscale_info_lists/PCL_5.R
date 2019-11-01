PCL_5<- list(  title = "PTSD Checklist for DSM-5 (PCL-5)", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "PCL-5",
               measure = "PCL_5", #The overal measure (which may contain subscales)
               subscale = "PCL_5", #The specific subscale of the measure.
               population_quantity = 5,
               populations = list("Psychiatric_Inpatient", "University_Student", "Active_Military_Service", "Veteran",
                                  "Institutional_Abuse", "Other"),
               means = list(39.98, 20.9, 42.41, 36.97, 28.28, 0),
               sds = list(21.11, 17.7, 15.06, 21.16, 18.19, 0),
               mean_sd_references = list("Vujanovic, Dutcher, & Berenz (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                         "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                                         "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Define Value"),
               reliabilities = list(.89, .89, .89, .89, .89, 0),
               reliability_references = list("Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                             "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                             "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Define Value"),
               cutoff_values = list(
                 c(33, 38, 39.98, 39.98 + 21.11, 39.98 + (2 *21.11), 39.98 + (3 *21.11)),
                 c(20.9, 20.9 + (0.5 * 17.7), 33, 38,  20.9 + (1.5 * 17.7), 20.9 + (2 * 17.7)),
                 c(33, 38, 42.41, 42.41 + 15.06, 42.41 + (2 * 15.06), 42.41 + (3 * 15.06)),
                 c(33, 36.97, 38, 36.97 + 21.16, 36.97 + (2 *21.16), 36.97 + (3 *21.16)),
                 c(28.28, 33, 38, 28.28 + 18.19, 28.28 + (2 *18.19), 28.28 + (3 *18.19)),
                 c(0, 0, 0, 0, 0, 0)
               ),
               cutoff_labels = list(
                 c("PTSD (Bovin et al., 2015)", "PTSD (Scale Developers)", "Mean", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
                 c("Mean", "Mean + 0.5 Sd", "PTSD (Bovin et al., 2015)", "PTSD (Scale Developers)", "Mean + 1.5 Sd", "Mean + 2 Sd"),
                 c("PTSD (Bovin et al., 2015)", "PTSD (Scale Developers)", "Mean", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
                 c("PTSD (Bovin et al., 2015)", "Mean", "PTSD (Scale Developers)", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
                 c("Mean", "PTSD (Bovin et al., 2015)", "PTSD (Scale Developers)", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
                 c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                   "Define Value")
               ),
               cutoff_references = list(
                 c("Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Weathers, Litz, Keane, Palmieri, Marx et al (2013)",
                   "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)",
                   "Vujanovic, Dutcher, & Berenz (2016)"),
                 c("Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                   "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Weathers, Litz, Keane, Palmieri, Marx et al (2013)",
                   "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)"),
                 c("Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Weathers, Litz, Keane, Palmieri, Marx et al (2013)",
                   "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)",
                   "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)"),
                 c("Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                   "Weathers, Litz, Keane, Palmieri, Marx et al (2013)","Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                   "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)"),
                 c("Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                   "Weathers, Litz, Keane, Palmieri, Marx et al (2013)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)",
                   "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)"),
                 c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                   "Define Value")
               ),
               cutoff_quantity = 6,
               items = 1:20,
               max_score = 80,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = NULL,
               sample_overview = list(
                 c("103 American psychiatric inpatients"),
                 c("838 English-speaking Canadian university students"),
                 c("912 American military service members seeking PTSD treatment while stationed in garrison"),
                 c("468 American military service veterans"),
                 c("220 Austrian survivors of institutional abuse"),
                 c("No sample information to provide.")
               ),
               journal_references = list(
                 c("Vujanovic, A. A., Dutcher, C. D., & Berenz, E. C. (2017). Multimodal examination of distress tolerance and posttraumatic stress disorder
                   symptoms in acute-care psychiatric inpatients. Journal of Anxiety Disorders, 48, 45-53."),
                 c("Ashbaugh, A. R., Houle-Johnson, S., Herbert, C., El-Hage, W., & Brunet, A. (2016). Psychometric validation of the English and French
                   versions of the posttraumatic stress disorder checklist for DSM-5 (PCL-5). PloS One, 11(10)."),
                 c("Wortmann, J. H., Jordan, A. H., Weathers, F. W., Resick, P. A., Dondanville, K. A., Hall-Clark, B., . . . Hembree, E. A. (2016).
                   Psychometric analysis of the PTSD checklist-5 (PCL-5) among treatment-seeking military service members. Psychological Assessment, 28(11), 1392."),
                 c("Bovin, M. J., Marx, B. P., Weathers, F. W., Gallagher, M. W., Rodriguez, P., Schnurr, P. P., & Keane, T. M. (2016). Psychometric properties of
                   the PTSD checklist for diagnostic and statistical manual of mental Disorders–Fifth edition (PCL-5) in veterans. Psychological Assessment,
                   28(11), 1379."),
                 c("Lueger-Schuster, B., Knefel, M., Glück, T. M., Jagsch, R., Kantor, V., & Weindl, D. (2018). Child abuse and neglect in institutional settings,
                   cumulative lifetime traumatization, and psychopathological long-term correlates in adult survivors: The vienna institutional abuse study.
                   Child Abuse & Neglect, 76, 488-501."),
                 c("No sample information to provide.")
               )

                )




PCL_5_Intrusion<- list(  title = "PCL-5 Intrusion", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "PCL-5 Intrusion",
               measure = "PCL_5", #The overal measure (which may contain subscales)
               subscale = "PCL_5_Intrusion", #The specific subscale of the measure.
               population_quantity = 6,
               populations = list("Psychiatric_Inpatient", "University_Student", "Active_Military_Service", "Veteran", "Institutional_Abuse",
                                  "Other"),
               means = list(9.93, 5.6, 10.57, 9.28, 7.92, 0),
               sds = list(5.99, 4.9, 4.45, 5.87, 6.35, 0),
               mean_sd_references = list("Vujanovic, Dutcher, & Berenz (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                         "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                                         "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Define Value"),
               reliabilities = list(.80, .80, .80, .80, .80, 0),
               reliability_references = list("Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                             "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                             "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Define Value"),
               cutoff_values = list(
                 c(9.93 - 5.99, 9.93 - (0.5 * 5.99), 9.93, 9.93 + (0.5 * 5.99), 9.93 + 5.99, 9.93 + (1.5 *5.99)),
                 c(5.6 - 4.9, 5.6 - (0.5 * 4.9), 5.6, 5.6 + (0.5 * 4.9), 5.6 + 4.9, 5.6 + (2 * 4.9)),
                 c(10.57 - 4.45, 10.57 - (0.5 * 4.45), 10.57, 10.57 + (0.5 * 4.45), 10.57 + 4.45, 10.57 + (1.5 * 4.45)),
                 c(9.28 - 5.87, 9.28 - (0.5 * 5.87), 9.28, 9.28 + (0.5 * 5.87), 9.28 + 5.87, 9.28 + (1.5 * 5.87)),
                 c(7.92 - 6.35, 7.92 - (0.5 * 6.35), 7.92, 7.92 + (0.5 * 6.35), 7.92 + 6.35, 7.92 + (1.5 * 6.35)),
                 c(0, 0, 0, 0, 0, 0)
               ),
               cutoff_labels = list(
                 c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd"),
                 c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 2 Sd"),
                 c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd"),
                 c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd"),
                 c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd"),
                 c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                   "Define Value")
               ),
               cutoff_references = list(
                 c("Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)",
                   "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)"),
                 c("Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                   "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                   "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)"),
                 c("Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)",
                   "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)",
                   "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)"),
                 c("Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                   "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                   "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)"),
                 c("Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)",
                   "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)",
                   "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)"),
                 c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                   "Define Value")
               ),
               cutoff_quantity = 6,
               items = 1:5,
               max_score = 20,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = NULL,
               sample_overview = list(
                 c("103 American psychiatric inpatients"),
                 c("42 French-speaking Candian university students"),
                 c("912 American military service members seeking PTSD treatment while stationed in garrison"),
                 c("468 American military service veterans"),
                 c("220 Austrian survivors of institutional abuse"),
                 c("No sample information to provide.")
               ),
               journal_references = list(
                 c("Vujanovic, A. A., Dutcher, C. D., & Berenz, E. C. (2017). Multimodal examination of distress tolerance and posttraumatic stress disorder
                   symptoms in acute-care psychiatric inpatients. Journal of Anxiety Disorders, 48, 45-53."),
                 c("Ashbaugh, A. R., Houle-Johnson, S., Herbert, C., El-Hage, W., & Brunet, A. (2016). Psychometric validation of the English and French
                   versions of the posttraumatic stress disorder checklist for DSM-5 (PCL-5). PloS One, 11(10)."),
                 c("Wortmann, J. H., Jordan, A. H., Weathers, F. W., Resick, P. A., Dondanville, K. A., Hall-Clark, B., . . . Hembree, E. A. (2016).
                   Psychometric analysis of the PTSD checklist-5 (PCL-5) among treatment-seeking military service members. Psychological Assessment, 28(11), 1392."),
                 c("Bovin, M. J., Marx, B. P., Weathers, F. W., Gallagher, M. W., Rodriguez, P., Schnurr, P. P., & Keane, T. M. (2016). Psychometric properties of
                   the PTSD checklist for diagnostic and statistical manual of mental Disorders–Fifth edition (PCL-5) in veterans. Psychological Assessment,
                   28(11), 1379."),
                 c("Lueger-Schuster, B., Knefel, M., Glück, T. M., Jagsch, R., Kantor, V., & Weindl, D. (2018). Child abuse and neglect in institutional settings,
                   cumulative lifetime traumatization, and psychopathological long-term correlates in adult survivors: The vienna institutional abuse study.
                   Child Abuse & Neglect, 76, 488-501."),
                 c("No sample information to provide.")
               )

)




PCL_5_Cognition_Mood<- list(  title = "PCL-5 Negative Cognition/Mood", #Title can contain white space. For insertion into widget headings, plot titles etc.
                         brief_title = "PCL-5 Negative Cognition/Mood",
                         measure = "PCL_5", #The overal measure (which may contain subscales)
                         subscale = "PCL_5_Cognition_Mood", #The specific subscale of the measure.
                         population_quantity = 6,
                         populations = list("Psychiatric_Inpatient", "University_Student", "Active_Military_Service", "Veteran",
                                            "Institutional_Abuse", "Other"),
                         means = list(13.61, 7.1, 12.91, 12.54, 8.26, 0),
                         sds = list(8.71, 6.9, 6.59, 8.15, 6.8, 0),
                         mean_sd_references = list("Vujanovic, Dutcher, & Berenz (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                                   "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                                                   "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Define Value"),
                         reliabilities = list(.92, .92, .92, .92, .92, 0),
                         reliability_references = list("Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                                       "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                                       "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Define Value"),
                         cutoff_values = list(
                           c(13.61 - 8.71, 13.61 - (0.5 * 8.71),  13.61, 13.61 + (0.5 * 8.71), 13.61 +  8.71, 13.61 + (1.5 * 8.71)),
                           c(7.1 - 6.9, 7.1 - (0.5 *6.9), 7.1, 7.1 + 6.9, 7.1 + (1.5 *6.9), 7.1 + (2 *6.9), 7.1 + (2.5 * 6.9)),
                           c(12.91 - (1.5 * 6.59), 12.91 - 6.59, 12.91, 12.91 + (0.5 * 6.59), 12.91 + 6.59, 12.91 + (1.5 * 6.59)),
                           c(12.54 - 8.15, 12.54 - (0.5 * 8.15), 12.54, 12.54 + (0.5 * 8.15), 12.54 + 8.15, 12.54 + (1.5 * 8.15)),
                           c(8.26 - 6.8, 8.26, 8.26 + (0.5 * 6.8), 8.26 + 6.8, 8.26 + (2 * 6.8), 8.26 + (2.5 * 6.8)),
                           c(0, 0, 0, 0, 0, 0)
                         ),
                         cutoff_labels = list(
                           c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd"),
                           c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 2.5 Sd"),
                           c("Mean - 1.5 Sd", "Mean - 1 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd"),
                           c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd"),
                           c("Mean - 1 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 2.5 Sd"),
                           c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                             "Define Value")
                         ),
                         cutoff_references = list(
                           c("Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)",
                             "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)"),
                           c("Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                             "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                             "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)"),
                           c("Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)",
                             "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)",
                             "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)"),
                           c("Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                             "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                             "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)"),
                           c("Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)",
                             "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)",
                             "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)"),
                           c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                             "Define Value")
                         ),
                         cutoff_quantity = 6,
                         items = 8:14,
                         max_score = 28,
                         min_score = 0,
                         plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
                         plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
                         plot_cutoff_label_size = 3,
                         description = NULL,
                         sample_overview = list(
                           c("103 American psychiatric inpatients"),
                           c("42 French-speaking Candian university students"),
                           c("912 American military service members seeking PTSD treatment while stationed in garrison"),
                           c("468 American military service veterans"),
                           c("220 Austrian survivors of institutional abuse"),
                           c("No sample information to provide.")
                         ),
                         journal_references = list(
                           c("Vujanovic, A. A., Dutcher, C. D., & Berenz, E. C. (2017). Multimodal examination of distress tolerance and posttraumatic stress disorder
                             symptoms in acute-care psychiatric inpatients. Journal of Anxiety Disorders, 48, 45-53."),
                           c("Ashbaugh, A. R., Houle-Johnson, S., Herbert, C., El-Hage, W., & Brunet, A. (2016). Psychometric validation of the English and French
                             versions of the posttraumatic stress disorder checklist for DSM-5 (PCL-5). PloS One, 11(10)."),
                           c("Wortmann, J. H., Jordan, A. H., Weathers, F. W., Resick, P. A., Dondanville, K. A., Hall-Clark, B., . . . Hembree, E. A. (2016).
                             Psychometric analysis of the PTSD checklist-5 (PCL-5) among treatment-seeking military service members. Psychological Assessment, 28(11), 1392."),
                           c("Bovin, M. J., Marx, B. P., Weathers, F. W., Gallagher, M. W., Rodriguez, P., Schnurr, P. P., & Keane, T. M. (2016). Psychometric properties of
                             the PTSD checklist for diagnostic and statistical manual of mental Disorders–Fifth edition (PCL-5) in veterans. Psychological Assessment,
                             28(11), 1379."),
                           c("Lueger-Schuster, B., Knefel, M., Glück, T. M., Jagsch, R., Kantor, V., & Weindl, D. (2018). Child abuse and neglect in institutional settings,
                             cumulative lifetime traumatization, and psychopathological long-term correlates in adult survivors: The vienna institutional abuse study.
                             Child Abuse & Neglect, 76, 488-501."),
                           c("No sample information to provide.")

                           ))


PCL_5_Hyperarousal<- list(  title = "PCL-5 Hyperarousal", #Title can contain white space. For insertion into widget headings, plot titles etc.
                         brief_title = "PCL-5 Hyperarousal",
                         measure = "PCL_5", #The overal measure (which may contain subscales)
                         subscale = "PCL_5_Hyperarousal", #The specific subscale of the measure.
                         population_quantity = 6,
                         populations = list("Psychiatric_Inpatient", "University_Student", "Active_Military_Service",
                                            "Veteran", "Institutional_Abuse", "Other"),
                         means = list(12.3, 5.5, 14.07, 11.09, 8.91, 0),
                         sds = list(6.42, 5.3, 4.68, 6.75, 5.43, 0),
                         mean_sd_references = list("Vujanovic, Dutcher, & Berenz (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                                   "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                                                   "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Define Value"),
                         reliabilities = list(.78, .78, .78, .78, .78, 0),
                         reliability_references = list("Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                                       "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                                       "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Define Value"),
                         cutoff_values = list(
                           c(12.3 - 6.42, 12.3 - (0.5 * 6.42), 12.3, 12.3 + (0.5 * 6.42), 12.3 + 6.42, 12.3 + (1.5 * 6.42)),
                           c(5.5 - 5.3, 5.5, 5.5 + 5.3, 5.5 + (1.5 * 5.3), 5.5 + (2 * 5.3),  5.5 + (3 * 5.3)),
                           c(14.07 - (2 * 4.68), 14.07 - 4.68, 14.07, 14.07 + 4.68, 14.07 + (1.5 * 4.68), 14.07 + (2 * 4.68)),
                           c(11.09 - 6.75, 11.09 - (0.5 * 6.75), 11.09, 11.09 + (0.5 * 6.75), 11.09 + 6.75, 11.09 + (1.5 * 6.75)),
                           c(8.91 - 5.43, 8.91, 8.91 + 5.43, 8.91 + (1.5 * 5.43), 8.91 + (2 * 5.43), 8.91 + (2.5 * 5.43)),
                           c(0, 0, 0, 0, 0, 0)
                         ),
                         cutoff_labels = list(
                           c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd"),
                           c("Mean - 1 Sd", "Mean", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
                           c("Mean - 2 Sd", "Mean - 1 Sd", "Mean", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd"),
                           c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd"),
                           c("Mean - 1 Sd", "Mean", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 2.5 Sd"),
                           c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                             "Define Value")
                         ),
                         cutoff_references = list(
                           c("Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)",
                             "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)"),
                           c("Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                             "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                             "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)"),
                           c("Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)",
                             "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)",
                             "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)"),
                           c("Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                             "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                             "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)"),
                           c("Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)",
                             "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)",
                             "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)"),
                           c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                             "Define Value")
                         ),
                         cutoff_quantity = 6,
                         items = 15:20,
                         max_score = 24,
                         min_score = 0,
                         plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
                         plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
                         plot_cutoff_label_size = 3,
                         description = NULL,
                         sample_overview = list(
                           c("103 American psychiatric inpatients"),
                           c("42 French-speaking Candian university students"),
                           c("912 American military service members seeking PTSD treatment while stationed in garrison"),
                           c("468 American military service veterans"),
                           c("220 Austrian survivors of institutional abuse"),
                           c("No sample information to provide.")
                         ),
                         journal_references = list(
                           c("Vujanovic, A. A., Dutcher, C. D., & Berenz, E. C. (2017). Multimodal examination of distress tolerance and posttraumatic stress disorder
                             symptoms in acute-care psychiatric inpatients. Journal of Anxiety Disorders, 48, 45-53."),
                           c("Ashbaugh, A. R., Houle-Johnson, S., Herbert, C., El-Hage, W., & Brunet, A. (2016). Psychometric validation of the English and French
                             versions of the posttraumatic stress disorder checklist for DSM-5 (PCL-5). PloS One, 11(10)."),
                           c("Wortmann, J. H., Jordan, A. H., Weathers, F. W., Resick, P. A., Dondanville, K. A., Hall-Clark, B., . . . Hembree, E. A. (2016).
                             Psychometric analysis of the PTSD checklist-5 (PCL-5) among treatment-seeking military service members. Psychological Assessment, 28(11), 1392."),
                           c("Bovin, M. J., Marx, B. P., Weathers, F. W., Gallagher, M. W., Rodriguez, P., Schnurr, P. P., & Keane, T. M. (2016). Psychometric properties of
                             the PTSD checklist for diagnostic and statistical manual of mental Disorders–Fifth edition (PCL-5) in veterans. Psychological Assessment,
                             28(11), 1379."),
                           c("Lueger-Schuster, B., Knefel, M., Glück, T. M., Jagsch, R., Kantor, V., & Weindl, D. (2018). Child abuse and neglect in institutional settings,
                             cumulative lifetime traumatization, and psychopathological long-term correlates in adult survivors: The vienna institutional abuse study.
                             Child Abuse & Neglect, 76, 488-501."),
                           c("No sample information to provide.")

                           ))



PCL_5_Avoidance<- list(  title = "PCL-5 Avoidance", #Title can contain white space. For insertion into widget headings, plot titles etc.
                         brief_title = "PCL-5 Avoidance",
                         measure = "PCL_5", #The overal measure (which may contain subscales)
                         subscale = "PCL_5_Avoidance", #The specific subscale of the measure.
                         population_quantity = 6,
                         populations = list("Psychiatric_Inpatient", "University_Student", "Active_Military_Service",
                                            "Veteran", "Institutional_Abuse", "Other"),
                         means = list(4.13, 2.7, 4.88, 4.06, 3.19, 0),
                         sds = list(2.63, 2.4, 2.35, 2.6, 2.72, 0),
                         mean_sd_references = list("Vujanovic, Dutcher, & Berenz (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                                   "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                                                   "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Define Value"),
                         reliabilities = list(.66, .66, .66, .66, .66, 0),
                         reliability_references = list("Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                                       "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                                                       "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Define Value"),
                         cutoff_values = list(
                           c(4.13 - (1.5 * 2.63), 4.13 - 2.63, 4.13, 4.13 + (0.5 * 2.63), 4.13 + 2.63, 4.13 + (1.4 * 2.63)),
                           c(2.7 - 2.4, 2.7 - (0.5 * 2.4), 2.7, 2.7 + 2.4, 2.7 + (1.5 * 2.4), 2.7 + (2 * 2.4)),
                           c(4.88 - (2 * 2.35), 4.88 - 2.35, 4.88, 4.88 + (0.5 * 2.35), 4.88 + 2.35, 4.88 + (1.3 * 2.35)),
                           c(4.06 - 2.6, 4.06 - (0.5 * 2.6), 4.06, 4.06 + (0.5 * 2.6), 4.06 + 2.6, 4.06 + (1.5 * 2.6)),
                           c(3.19 - 2.72, 3.19 - (0.5 * 2.72), 3.19, 3.19 + (0.5 * 2.72), 3.19 + 2.72, 3.19 + (1.5 * 2.72)),
                           c(0, 0, 0, 0, 0, 0)
                         ),
                         cutoff_labels = list(
                           c("Mean - 1.5 Sd", "Mean - 1 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.4 Sd"),
                           c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd"),
                           c("Mean - 2 Sd", "Mean - 1 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.3 Sd"),
                           c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + Sd", "Mean + 1.5 Sd"),
                           c("Mean - 1 Sd", "Mean - 0.5 Sd", "Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd"),
                           c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                             "Define Value")
                         ),
                         cutoff_references = list(
                           c("Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)",
                             "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)", "Vujanovic, Dutcher, & Berenz (2016)"),
                           c("Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                             "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)",
                             "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)", "Ashbaugh, Houle-Johnson, El-Hage & Brunet (2016)"),
                           c("Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)",
                             "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)",
                             "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)", "Wortmann, Jordan, Resick, Foa, Yarvis et al (2016)"),
                           c("Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                             "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)",
                             "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)", "Bovin, Marx, Gallagher, Schnurr, Weathers et al (2015)"),
                           c("Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)",
                             "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)",
                             "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)", "Lueger-Schuster, Knefel, Glück, Jagsch, Kantor et al (2018)"),
                           c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                             "Define Value")
                         ),
                         cutoff_quantity = 6,
                         items = 6:7,
                         max_score = 20,
                         min_score = 0,
                         plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
                         plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
                         plot_cutoff_label_size = 3,
                         description = readr::read_file(
                           "PCL_5.md"
                         ),
                         sample_overview = list(
                           c("103 American psychiatric inpatients"),
                           c("42 French-speaking Candian university students"),
                           c("912 American military service members seeking PTSD treatment while stationed in garrison"),
                           c("468 American military service veterans"),
                           c("220 Austrian survivors of institutional abuse"),
                           c("No sample information to provide.")
                         ),
                         journal_references = list(
                           c("Vujanovic, A. A., Dutcher, C. D., & Berenz, E. C. (2017). Multimodal examination of distress tolerance and posttraumatic stress disorder
                   symptoms in acute-care psychiatric inpatients. Journal of Anxiety Disorders, 48, 45-53."),
                           c("Ashbaugh, A. R., Houle-Johnson, S., Herbert, C., El-Hage, W., & Brunet, A. (2016). Psychometric validation of the English and French
                   versions of the posttraumatic stress disorder checklist for DSM-5 (PCL-5). PloS One, 11(10)."),
                           c("Wortmann, J. H., Jordan, A. H., Weathers, F. W., Resick, P. A., Dondanville, K. A., Hall-Clark, B., . . . Hembree, E. A. (2016).
                   Psychometric analysis of the PTSD checklist-5 (PCL-5) among treatment-seeking military service members. Psychological Assessment, 28(11), 1392."),
                           c("Bovin, M. J., Marx, B. P., Weathers, F. W., Gallagher, M. W., Rodriguez, P., Schnurr, P. P., & Keane, T. M. (2016). Psychometric properties of
                   the PTSD checklist for diagnostic and statistical manual of mental Disorders–Fifth edition (PCL-5) in veterans. Psychological Assessment,
                   28(11), 1379."),
                           c("Lueger-Schuster, B., Knefel, M., Glück, T. M., Jagsch, R., Kantor, V., & Weindl, D. (2018). Child abuse and neglect in institutional settings,
                   cumulative lifetime traumatization, and psychopathological long-term correlates in adult survivors: The vienna institutional abuse study.
                   Child Abuse & Neglect, 76, 488-501."),
                           c("No sample information to provide.")

                         ))


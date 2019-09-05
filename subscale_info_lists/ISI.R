ISI<- list(  title = "Insomnia Severity Index (ISI)", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "ISI",
               measure = "ISI", #The overal measure (which may contain subscales)
               subscale = "ISI", #The specific subscale of the measure.
               population_quantity = 4,
               populations = list("Insomnia", "Primary_Care", "Chronic_Pain", "Cancer"),
               means = list(19.7, 8.27, 9.93, 7.3),
               sds = list(14.1, 6.33, 4.1, 6.3),
               mean_sd_references = list("Bastien, Vallières & Morin (2001)", "Gagnon, Bélanger, Ivers & Morin (2013)", "Dragioti, Wiklund, Alföldi & Gerdle (2015)",
                                         "Savard, Savard, Simard & Ivers (2005)"),
               reliabilities = list(.91, .91, .91, .91),
               reliability_references = list("Morin, Belleville, Bélanger & Ivers (2011)", "Morin, Belleville, Bélanger & Ivers (2011)",
                                             "Morin, Belleville, Bélanger & Ivers (2011)", "Morin, Belleville, Bélanger & Ivers (2011)"),
               cutoff_values = list(
                 c(8, 15, 19.7, 22, 19.7 + 14.1, 19.7 + (2 * 14.1)),
                 c(8, 15, 8.27 + (1.5 * 6.33), 8.27 + (2 * 6.33), 22, 8.27 + (3 * 6.33)),
                 c(8, 9.93, 9.93 + 4.1, 15, 9.93 + (2 * 4.1), 22),
                 c(8, 15, 7.3 + (2 * 6.3), 22, 7.3 + (3* 6.3), 7.3 + (4 * 6.3))
               ),
               cutoff_labels = list(
                 c("Subthreshold Insomnia", "Clinical Insomnia (Moderate)", "Mean", "Clinical Insomnia (Severe)", "Mean + 1 Sd", "Mean + 2 Sd"),
                 c("Subthreshold Insomnia", "Clinical Insomnia (Moderate)", "Mean + 1.5 Sd", "Mean + 2 Sd", "Clinical Insomnia (Severe)",
                   "Mean + 3 Sd"),
                 c("Subthreshold Insomnia", "Mean", "Mean + 1 Sd", "Clinical Insomnia (Moderate)", "Mean + 2 Sd", "Clinical Insomnia (Severe)"),
                 c("Subthreshold Insomnia", "Clinical Insomnia (Moderate)", "Mean + 2 Sd", "Clinical Insomnia (Severe)", "Mean + 3 Sd", "Mean + 4 Sd")
               ),
               cutoff_references = list(
                 c("Bastien, Vallières & Morin (2001)", "Bastien, Vallières & Morin (2001)", "Bastien, Vallières & Morin (2001)", "Bastien, Vallières & Morin (2001)",
                   "Bastien, Vallières & Morin (2001)", "Bastien, Vallières & Morin (2001)"),
                 c("Bastien, Vallières & Morin (2001)", "Bastien, Vallières & Morin (2001)", "Gagnon, Bélanger, Ivers & Morin (2013)",
                   "Gagnon, Bélanger, Ivers & Morin (2013)", "Bastien, Vallières & Morin (2001)", "Gagnon, Bélanger, Ivers & Morin (2013)"),
                 c("Bastien, Vallières & Morin (2001)", "Dragioti, Wiklund, Alföldi & Gerdle (2015)", "Bastien, Vallières & Morin (2001)",
                   "Dragioti, Wiklund, Alföldi & Gerdle (2015)", "Dragioti, Wiklund, Alföldi & Gerdle (2015)", "Bastien, Vallières & Morin (2001)"),
                 c("Bastien, Vallières & Morin (2001)", "Bastien, Vallières & Morin (2001)", "Savard, Savard, Simard & Ivers (2005)",
                   "Bastien, Vallières & Morin (2001)", "Savard, Savard, Simard & Ivers (2005)", "Savard, Savard, Simard & Ivers (2005)")
               ),
               cutoff_quantity = 6,
               items = 1:7,
               max_score = 28,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = readr::read_file(
                 "ISI.md"
               ),
               sample_overview = list(
                 c("145 Canadian patients presenting to sleep disorder centre with compain of insomnia."),
                 c("410 Canadian primary care patients."),
                 c("836 Swedish chronic pain patients."),
                 c("1670 Canadian cancer patients.")
               ),
               journal_references = list(
                 c("Bastien, C. H., Vallières, A., & Morin, C. M. (2001). Validation of the insomnia severity index as an outcome measure for insomnia
                    research. Sleep Medicine, 2(4), 297-307."),
                 c("Gagnon, C., Belanger, L., Ivers, H., & Morin, C. M. (2013). Validation of the insomnia severity index in primary care.
                   Journal of the American Board of Family Medicine : JABFM, 26(6), 701-710."),
                 c("Dragioti, E., Wiklund, T., Alföldi, P., & Gerdle, B. (2015). The Swedish version of the Insomnia Severity Index: Factor structure analysis and
                   psychometric properties in chronic pain patients. Scandinavian Journal of Pain, 9(1), 22-27."),
                 c("Savard, M., Savard, J., Simard, S., & Ivers, H. (2005). Empirical validation of the insomnia severity index in cancer patients. Psycho‐Oncology:
                   Journal of the Psychological, Social and Behavioral Dimensions of Cancer, 14(6), 429-441.")
               )

                )

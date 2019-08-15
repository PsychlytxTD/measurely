PDSS_SR<- list(  title = "Panic Disorder Severity Scale-Self-Report (PDSS-SR)", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "PDSS-SR",
               measure = "PDSS_SR", #The overal measure (which may contain subscales)
               subscale = "PDSS_SR", #The specific subscale of the measure.
               population_quantity = 2,
               populations = list("Panic_Disorder", "Psychiatric_Outpatient"),
               means = list(12.9, 9),
               sds = list(3.8, 6.6),
               mean_sd_references = list("Furukawa, Shear, Barlow, Gorman, Woods et al. (2009)", "Houck, Spiegel, Shear, Rucci & Stat (2002)"),
               reliabilities = list(.88, .88),
               reliability_references = list("Shear, Brown, Barlow, Money, Sholomskas et al. (1997)", "Shear, Brown, Barlow, Money, Sholomskas et al. (1997)"),
               cutoff_values = list(
                 c(4, 6, 10, 12.9, 17, 22),
                 c(4, 6, 9, 10, 17, 22)
               ),
               cutoff_labels = list(
                 c("Borderline Ill", "Mildly Ill", "Moderately Ill", "Mean", "Markedly Ill", "Severely Ill"),
                 c("Borderline Ill", "Mildly Ill", "Mean", "Moderately Ill", "Markedly Ill", "Severely Ill")
               ),
               cutoff_references = list(
                 c("Keough, Hoge, Pollack & Shear (2012)", "Keough, Hoge, Pollack & Shear (2012)", "Keough, Hoge, Pollack & Shear (2012)",
                   "Furukawa, Shear, Barlow, Gorman, Woods et al. (2009)", "Keough, Hoge, Pollack & Shear (2012)", "Keough, Hoge, Pollack & Shear (2012)"),
                 c("Keough, Hoge, Pollack & Shear (2012)", "Keough, Hoge, Pollack & Shear (2012)", "Houck, Spiegel, Shear, Rucci & Stat (2002)",
                   "Keough, Hoge, Pollack & Shear (2012)", "Keough, Hoge, Pollack & Shear (2012)", "Keough, Hoge, Pollack & Shear (2012)")
               ),
               cutoff_quantity = 6,
               items = 7,
               max_score = 28,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = readr::read_file(
                 "PDSS_SR.md"
               ),
               sample_overview = list(
                 c("568 American patients with Panic Disorder (with or without Agoraphobia) taking part in two large treatment trials."),
                 c("108 American psychiatric outpatients with and without Panic Disorder.")
               ),
               journal_references = list(
                 c("Furukawa, T. A., Katherine Shear, M., Barlow, D. H., Gorman, J. M., Woods, S. W., Money, R., . . . Leucht, S. (2009). Evidence‐based guidelines
                   for interpretation of the panic disorder severity scale. Depression and Anxiety, 26(10), 922-929."),
                 c("Houck, P. R., Spiegel, D. A., Shear, M. K., & Rucci, P. (2002). Reliability of the self‐report version of the panic disorder severity scale.
                   Depression and Anxiety, 15(4), 183-185.")
               )

                )

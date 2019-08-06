scale<- list(  title = "", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "",
               measure = "", #The overal measure (which may contain subscales)
               subscale = "", #The specific subscale of the measure.
               population_quantity = ,
               populations = list(),
               means = list(),
               sds = list(),
               mean_sd_references = list(),
               reliabilities = list(),
               reliability_references = list(),
               cutoff_values = list(),
               cutoff_labels = list(),
               cutoff_references = list(),
               cutoff_quantity = ,
               items = ,
               max_score = ,
               min_score = ,
               plot_shading_gap = c(), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = ,
               description = readr::read_file(
                 ".md"
               ),
               sample_overview = list(
               ),
               journal_references = list()

                )

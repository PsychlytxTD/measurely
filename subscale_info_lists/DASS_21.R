scale<- list(  title = "Depression Anxiety Stress Scales - 21 (DASS-21)", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "DASS-21",
               measure = "DASS_21", #The overal measure (which may contain subscales)
               subscale = "DASS_21", #The specific subscale of the measure.
               population_quantity = 1,
               populations = list("General_Population"),
               means = list(10.59),
               sds = list(10.61),
               mean_sd_references = list("Crawford, Garthwaite, Lawrie, Henry, MacDonald et al. (2009)"),
               reliabilities = list(.94),
               reliability_references = list("Crawford, Garthwaite, Lawrie, Henry, MacDonald et al. (2009)"),
               cutoff_values = list(c(7, 10, 13, 18, 28, 43)),
               cutoff_labels = list(c("51st Percentile", "65th Percentile", "76th Percentile",
                                      "87th Percentile", "95th Percentile", "99th Percentile")),
               cutoff_references = list(c("(Henry & Crawford, 2005)", "(Henry & Crawford, 2005)",
                                          "(Henry & Crawford, 2005)", "(Henry & Crawford, 2005)",
                                          "(Henry & Crawford, 2005)", "(Henry & Crawford, 2005)")),
               cutoff_quantity = 6,
               items = 1:21,
               max_score = 63,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Redundant
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Redundant
               description = readr::read_file(
                 "DASS_21.md"
               ),
               sample_overview = list(
                 c("Combined samples from multiple studies providing normative data for the general UK population: 1171 + 2928 + 3822 + 2527 + 758")
               ),
               journal_references = list(
                 c("Crawford, J. R., Garthwaite, P. H., Lawrie, C. J., Henry, J. D., MacDonald, M. A., Sutherland, J., & Sinha, P. (2009). A convenient method of obtaining percentile norms and accompanying interval estimates for self‐report mood scales (DASS, DASS‐21, HADS, PANAS, and sAD). British Journal of Clinical Psychology, 48(2), 163-180.")
               )

                )



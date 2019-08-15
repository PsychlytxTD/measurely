EDPS<- list(  title = "Edinburgh Postnatal Depression Scale (EDPS)", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "EDPS",
               measure = "EDPS", #The overal measure (which may contain subscales)
               subscale = "EDPS", #The specific subscale of the measure.
               population_quantity = 3,
               populations = list("Female_Antepartum", "Female_Postpartum", "Male_Postpartum"),
               means = list(3.65, 3.77, 4.35),
               sds = list(2.62, 3.31, 3.72),
               mean_sd_references = list("Venkatesh, Kaimal, Castro & Perslis (2017)", "Venkatesh, Kaimal, Castro & Perslis (2017)",
                                         "Matthey, Barnett, Kavanagh & Howie (2001)"),
               reliabilities = list(.92, .92, .92),
               reliability_references = list("Kernot, Olds, Lewis & Maher (2015)", "Kernot, Olds, Lewis & Maher (2015)", "Kernot, Olds, Lewis & Maher (2015)"),
               cutoff_values = list(
                 c(3.65, 3.65 + 2.62, 3.65 + (2 * 2.62), 3.65 + (3 * 2.62), 13, 3.65 + (4 * 2.62)),
                 c(3.77, 3.77 + 3.31, 3.77 + (2 * 3.31), 13, 3.77 + (4 * 3.31), 3.77 + (5 * 3.31)),
                 c(4.35, 4.35 + 3.72, 10, 4.35 + (2 * 3.72), 4.35 + (3 * 3.72), 4.35 + (4 * 3.72))
               ),
               cutoff_labels = list(
                 c("Mean", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd", "Depression", "Mean + 4 Sd"),
                 c("Mean", "Mean + 1 Sd", "Mean + 2 Sd", "Depression", "Mean + 4 Sd", "Mean + 5 Sd"),
                 c("Mean", "Mean + 1 Sd", "Depression", "Mean + 2 Sd", "Mean + 3 Sd", "Mean + 4 Sd")
               ),
               cutoff_references = list(
                 c("Venkatesh, Kaimal, Castro & Perslis (2017)", "Venkatesh, Kaimal, Castro & Perslis (2017)", "Venkatesh, Kaimal, Castro & Perslis (2017)",
                   "Venkatesh, Kaimal, Castro & Perslis (2017)", "Venkatesh, Kaimal, Castro & Perslis (2017)", "Venkatesh, Kaimal, Castro & Perslis (2017)"),
                 c("Venkatesh, Kaimal, Castro & Perslis (2017)", "Venkatesh, Kaimal, Castro & Perslis (2017)", "Venkatesh, Kaimal, Castro & Perslis (2017)",
                   "Venkatesh, Kaimal, Castro & Perslis (2017)", "Venkatesh, Kaimal, Castro & Perslis (2017)", "Venkatesh, Kaimal, Castro & Perslis (2017)"),
                 c("Matthey, Barnett, Kavanagh & Howie (2001)", "Matthey, Barnett, Kavanagh & Howie (2001)", "Matthey, Barnett, Kavanagh & Howie (2001)",
                   "Matthey, Barnett, Kavanagh & Howie (2001)", "Matthey, Barnett, Kavanagh & Howie (2001)", "Matthey, Barnett, Kavanagh & Howie (2001)")
               ),
               cutoff_quantity = 6,
               items = 10,
               max_score = 30,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = readr::read_file(
                 "EDPS.md"
               ),
               sample_overview = list(
                 c("7267 American women screened antepartum (24-28 weeks)."),
                 c("9197 American women screened postpartum (2-6 weeks)."),
                 c("208 Australian fathers 6 weeks postpartum.")

               ),
               journal_references = list(
                 c("Venkatesh, K. K., Kaimal, A. J., Castro, V. M., & Perlis, R. H. (2017). Improving discrimination in antepartum depression screening using the
                   Edinburgh Postnatal Depression Scale. Journal of Affective Disorders, 214, 1-7. doi:S0165-0327(17)30217-3."),
                 c("Venkatesh, K. K., Kaimal, A. J., Castro, V. M., & Perlis, R. H. (2017). Improving discrimination in antepartum depression screening using the
                   Edinburgh Postnatal Depression Scale. Journal of Affective Disorders, 214, 1-7. doi:S0165-0327(17)30217-3."),
                 c("Matthey, S., Barnett, B., Kavanagh, D. J., & Howie, P. (2001). Validation of the Edinburgh Postnatal Depression Scale for men, and comparison of
                   item endorsement with their partners. Journal of Affective Disorders, 64(2-3), 175-184.")
               )

                )

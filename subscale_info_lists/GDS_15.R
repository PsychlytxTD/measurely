GDS_15<- list(  title = "Geriatric Depression Scale - 15 (GDS-15)", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "GDS-15",
               measure = "GDS_15", #The overal measure (which may contain subscales)
               subscale = "GDS_15", #The specific subscale of the measure.
               population_quantity = 4,
               populations = list("General Population", "Over 85 Years", "Experiencing Functional Impairment", "Dementia"),
               means = list(1.28, 3.7, 4.34, 3.11),
               sds = list(1.76, 2.6, 2.98, 2.64),
               mean_sd_references = list("Knight, McMahon, Green & Skeaff (2004)", "Conradsson, Rosendahl, Littbrand, Gustafson, Olofsson et al. (2014)",
                                         "Friedman, Heisel & Delavan (2005)", "Brown, Woods & Storandt (2007)"),
               reliabilities = list(.83, .83, .83, .83),
               reliability_references = list("Nyunt, Fones, Niti & Ng (2009)", "Nyunt, Fones, Niti & Ng (2009)", "Nyunt, Fones, Niti & Ng (2009)",
                                             "Nyunt, Fones, Niti & Ng (2009)"),
               cutoff_values = list(c(1.28, 1.28 + 1.76, 1.28 + (2 * 1.76), 6, 1.28 + (3 * 1.76), 1.28 + (4 * 1.76)),
                                    c(6, 3.7, 3.7 + 2.6, 3.7 + (2 * 2.6), 3.7 + (3 * 2.6), 3.7 + (4 * 2.6)),
                                    c(4.34, 6, 4.34 + 2.98, 4.34 + (1.5 * 2.98), 4.34 + (2 * 2.98), 4.34 + (3 * 2.98)),
                                    c(3.11, 3.11 + 2.64, 6, 3.11 + (2 * 2.64), 3.11 + (3 * 2.64), 3.11 + (4 * 2.64))
                                    ),
               cutoff_labels = list(c("Mean", "Mean + 1 Sd", "Mean + 2 Sd", "Depression", "Mean + 3 Sd", "Mean + 4 Sd"),
                                    c("Depression", "Mean", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd", "Mean + 4 Sd"),
                                    c("Mean", "Depression", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
                                    c("Mean", "Mean + 1 Sd", "Depression", "Mean + 2 Sd", "Mean + 3 Sd", "Mean + 4 Sd")
                                    ),
               cutoff_references = list(c("Knight, McMahon, Green & Skeaff (2004)", "Knight, McMahon, Green & Skeaff (2004)", "Knight, McMahon, Green & Skeaff (2004)",
                                          "Pocklington, Gilbody, Manea & McMillan (2016)", "Knight, McMahon, Green & Skeaff (2004)",
                                          "Knight, McMahon, Green & Skeaff (2004)"),
                                        c("Pocklington, Gilbody, Manea & McMillan (2016)", "Conradsson, Rosendahl, Littbrand, Gustafson, Olofsson et al. (2014)",
                                          "Conradsson, Rosendahl, Littbrand, Gustafson, Olofsson et al. (2014)", "Conradsson, Rosendahl, Littbrand, Gustafson, Olofsson et al. (2014)",
                                          "Conradsson, Rosendahl, Littbrand, Gustafson, Olofsson et al. (2014)", "Conradsson, Rosendahl, Littbrand, Gustafson, Olofsson et al. (2014)"),
                                        c("Friedman, Heisel & Delavan (2005)", "Pocklington, Gilbody, Manea & McMillan (2016)", "Friedman, Heisel & Delavan (2005)",
                                          "Friedman, Heisel & Delavan (2005)", "Friedman, Heisel & Delavan (2005)", "Friedman, Heisel & Delavan (2005)"),
                                        c("Brown, Woods & Storandt (2007)", "Brown, Woods & Storandt (2007)", "Pocklington, Gilbody, Manea & McMillan (2016)",
                                          "Brown, Woods & Storandt (2007)", "Brown, Woods & Storandt (2007)", "Brown, Woods & Storandt (2007)")
                                        ),
               cutoff_quantity = 6,
               items = 15,
               max_score = 15,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = readr::read_file(
                 "GDS_15.md"
               ),
               sample_overview = list(
                 c("268 healthy American volunteers."),
                 c("834 Swedish participants aged 85 years and older (39% of sample had dementia diagnosis)."),
                 c("960 functionally impaired, cognitively intact American community-dwelling primary care patients aged 65 years and older,"),
                 c("357 Americans aged with very mild to moderate dementia aged 47-102 years")
               ),
               journal_references = list(
                 c("Knight, R. G., McMahon, J., Green, T., & Skeaff, C. M. (2004). Some normative and psychometric data for the geriatric depression scale and the
                   cognitive failures questionnaire from a sample of healthy older persons. New Zealand Journal of Psychology, 33(3), 163-170."),
                 c("Conradsson, M., Rosendahl, E., Littbrand, H., Gustafson, Y., Olofsson, B., & Lövheim, H. (2013). Usefulness of the geriatric depression scale
                   15-item version among very old people with and without cognitive impairment. Aging & Mental Health, 17(5), 638-645."),
                 c("Friedman, B., Heisel, M. J., & Delavan, R. L. (2005). Psychometric properties of the 15‐item geriatric depression scale in functionally impaired,
                    cognitively intact, community‐dwelling elderly primary care patients. Journal of the American Geriatrics Society, 53(9), 1570-1576."),
                 c("Brown, P. J., Woods, C. M., & Storandt, M. (2007). Model stability of the 15-item geriatric depression scale across cognitive impairment and severe
                   depression. Psychology and Aging, 22(2), 372.")
               )

                )

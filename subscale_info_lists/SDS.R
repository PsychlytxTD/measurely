SDS<- list(   title = "Severity of Dependence Scale (SDS)", #Title can contain white space. For insertion into widget headings, plot titles etc.
               brief_title = "SDS",
               measure = "SDS", #The overal measure (which may contain subscales)
               subscale = "SDS", #The specific subscale of the measure.
               population_quantity = 8,
               populations = list("Alcohol Use", "Cannabis Use", "Heroin Use", "Cocaine Use", "Amphetamine Use", "Benzodiazepine Use", "Opiate Use",
                                  "Ketamine Use"),
               means = list(3.6, 3.4, 8.7, 4.2, 4.3, 6.4, 3.3, 7.7),
               sds = list(4.4, 3.7, 4, 3.3, 3.2, 3.8, 3.2, 3.8),
               mean_sd_references = list("Lawrinson, Copeland, Gerber & Gilmour (2000)", "Martin, Copeland, Gates & Gilmour (2006)",
                                         "Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Gossop, Darke, Griffiths, Hando, Powis et al (1995)",
                                         "Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "de las Cuevas, Sanz, de la Fuente, Padilla & Berenguer (2000)",
                                         "Castillo, Saiz, Rojas, Vázquez & Lerma (2010)", "Tang, Morgan, Lau, Liang, Tang et al. (2015)"),
               reliabilities = list(.89, .89, .89, .89, .89, .89, .89, .89),
               reliability_references = list("Reference: Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Reference: Gossop, Darke, Griffiths, Hando, Powis et al (1995)",
                                             "Reference: Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Reference: Gossop, Darke, Griffiths, Hando, Powis et al (1995)",
                                             "Reference: Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Reference: Gossop, Darke, Griffiths, Hando, Powis et al (1995)",
                                             "Reference: Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Reference: Gossop, Darke, Griffiths, Hando, Powis et al (1995)"),
               cutoff_values = list(c(3, 3.6, 3.6 + 4.4, 3.6 + (2 * 4.4), 3.6 + (3 * 4.4)), 3.6 + (4 * 4.4),
                                    c(3, 3.4, 7, 3.4 + (1.5 * 3.7), 3.4 + (2.5 * 3.7), 3.4 + (3.5 * 3.7)),
                                    c(8.7, 8.7 + (0.5 * 4), 8.7 + 4, 8.7 + (1.5 * 4), 8.7 + (2 * 4), 8.7 + (2.5 * 4)),
                                    c(3, 4.2, 4.2 + 3.3, 4.2 + (2 * 3.3), 4.2 + (3 * 3.3), 4.2 + (4 * 3.3)),
                                    c(4.3, 5, 4.3 + 3.2, 4.3 + (2 * 3.2), 4.3 + (3 * 3.2), 4.3 + (4 * 3.2)),
                                    c(6.4, 7, 6.4 + 3.8, 6.4 + (1.5 * 3.8), 6.4 + (2 * 3.8), 6.4 + (3 * 3.8)),
                                    c(3.3, 5, 3.3 + 3.2, 3.3 + (2 * 3.2), 3.3 + (3 * 3.2), 3.3 + (4 * 3.2)),
                                    c(4, 7.7, 7.7 + 3.8, 7.7 + (1.5 * 3.8), 7.7 + (2 * 3.8), 7.7 + (3 * 3.8))
                                    ),
               cutoff_labels = list(c("Alcohol Dependence", "Mean", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd", "Mean + 4 Sd"),
                                    c("Moderate Dependence", "Mean", "Severe Dependence", "Mean + 1.5 Sd", "Mean + 2.5 Sd", "Mean + 3.5 Sd"),
                                    c("Mean", "Mean + 0.5 Sd", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 2.5 Sd"),
                                    c("Cocaine Dependence", "Mean", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd", "Mean + 4 Sd"),
                                    c("Mean", "Amphetamine Dependence", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd", "Mean + 4 Sd"),
                                    c("Mean", "Benzodiazepine Dependence", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd"),
                                    c("Mean", "Opiate Dependence", "Mean + 1 Sd", "Mean + 2 Sd", "Mean + 3 Sd", "Mean + 4 Sd"),
                                    c("Ketamine Dependence", "Mean", "Mean + 1 Sd", "Mean + 1.5 Sd", "Mean + 2 Sd", "Mean + 3 Sd")
                                    ),
               cutoff_references = list(c("Lawrinson, Copeland, Gerber & Gilmour (2000)", "Lawrinson, Copeland, Gerber & Gilmour (2000)",
                                          "Lawrinson, Copeland, Gerber & Gilmour (2000)", "Lawrinson, Copeland, Gerber & Gilmour (2000)",
                                          "Lawrinson, Copeland, Gerber & Gilmour (2000)", "Lawrinson, Copeland, Gerber & Gilmour (2000)"),
                                        c("Cuenca-Royo, Sánchez-Niubó, Forero, Torrens, Suelves et al (2012)", "Martin, Copeland, Gates & Gilmour (2006)",
                                          "Cuenca-Royo, Sánchez-Niubó, Forero, Torrens, Suelves et al (2012)", "Martin, Copeland, Gates & Gilmour (2006)",
                                          "Martin, Copeland, Gates & Gilmour (2006)", "Martin, Copeland, Gates & Gilmour (2006)"),
                                        c("Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Gossop, Darke, Griffiths, Hando, Powis et al (1995)",
                                          "Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Gossop, Darke, Griffiths, Hando, Powis et al (1995)",
                                          "Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Gossop, Darke, Griffiths, Hando, Powis et al (1995)"),
                                        c("Kaye & Darke (2002)", "Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Gossop, Darke, Griffiths, Hando, Powis et al (1995)",
                                          "Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Gossop, Darke, Griffiths, Hando, Powis et al (1995)",
                                          "Gossop, Darke, Griffiths, Hando, Powis et al (1995)"),
                                        c("Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Topp & Mattick (1997)", "Gossop, Darke, Griffiths, Hando, Powis et al (1995)",
                                          "Gossop, Darke, Griffiths, Hando, Powis et al (1995)", "Gossop, Darke, Griffiths, Hando, Powis et al (1995)",
                                          "Gossop, Darke, Griffiths, Hando, Powis et al (1995)"),
                                        c("de las Cuevas, Sanz, de la Fuente, Padilla & Berenguer (2000)", "de las Cuevas, Sanz, de la Fuente, Padilla & Berenguer (2000)",
                                          "de las Cuevas, Sanz, de la Fuente, Padilla & Berenguer (2000)", "de las Cuevas, Sanz, de la Fuente, Padilla & Berenguer (2000)",
                                          "de las Cuevas, Sanz, de la Fuente, Padilla & Berenguer (2000)", "de las Cuevas, Sanz, de la Fuente, Padilla & Berenguer (2000)"),
                                        c("Castillo, Saiz, Rojas, Vázquez & Lerma (2010)", "Castillo, Saiz, Rojas, Vázquez & Lerma (2010)",
                                          "Castillo, Saiz, Rojas, Vázquez & Lerma (2010)", "Castillo, Saiz, Rojas, Vázquez & Lerma (2010)",
                                          "Castillo, Saiz, Rojas, Vázquez & Lerma (2010)", "Castillo, Saiz, Rojas, Vázquez & Lerma (2010)"),
                                        c("Fernández-Calderón, Vidal-Giné, López-Guerrero, Lozano-Rojas (2016)", "Tang, Morgan, Lau, Liang, Tang et al. (2015)",
                                          "Tang, Morgan, Lau, Liang, Tang et al. (2015)", "Tang, Morgan, Lau, Liang, Tang et al. (2015)",
                                          "Tang, Morgan, Lau, Liang, Tang et al. (2015)", "Tang, Morgan, Lau, Liang, Tang et al. (2015)")
               ),
               cutoff_quantity = 6,
               items = 5,
               max_score = 20,
               min_score = 0,
               plot_shading_gap = c(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1), #Gap = next cutoff minus plot_shading gap
               plot_cutoff_label_start = c(0.8, 0.8, 0.8, 0.8, 1, 0.8), #Indicates how far above the cutoff value the text cutoff label starts
               plot_cutoff_label_size = 3,
               description = readr::read_file(
                 "SDS.md"
               ),
               sample_overview = list(
                 c("90 Australian alcohol users"),
                 c("100 frequent cannabis-using Australians aged 14-18 years"),
                 c("408 English heroin users"),
                 c("150 English cocaine users"),
                 c("301 Australian amphetamine users"),
                 c("100 Canary Islands residents with a neurotic diagnosis, continuous use of benzodiazepines daily for 3 months or greater, &
                   stable maintenance dose of their benzodiazepine equivalent to 5-50mg/day of diazepam"),
                 c("89 Spanish opiate users"),
                 c("145 Hong Kong Ketamine users (youth)")
               ),
               journal_references = list(
                 c("Lawrinson, P., Copeland, J., Gerber, S., & Gilmour, S. (2007). Determining a cut-off on the severity of dependence scale (SDS) for alcohol
                   dependence. Addictive Behaviors, 32(7), 1474-1479."),
                 c("Martin, G., Copeland, J., Gates, P., & Gilmour, S. (2006). The severity of dependence scale (SDS) in an adolescent population of cannabis users:
                   Reliability, validity and diagnostic cut-off. Drug and Alcohol Dependence, 83(1), 90-93."),
                 c("Gossop, M., Darke, S., Griffiths, P., Hando, J., Powis, B., Hall, W., & Strang, J. (1995). The severity of dependence scale (SDS): Psychometric
                   properties of the SDS in english and australian samples of heroin, cocaine and amphetamine users. Addiction, 90(5), 607-614."),
                 c("Gossop, M., Darke, S., Griffiths, P., Hando, J., Powis, B., Hall, W., & Strang, J. (1995). The severity of dependence scale (SDS): Psychometric
                   properties of the SDS in english and australian samples of heroin, cocaine and amphetamine users. Addiction, 90(5), 607-614."),
                 c("Gossop, M., Darke, S., Griffiths, P., Hando, J., Powis, B., Hall, W., & Strang, J. (1995). The severity of dependence scale (SDS): Psychometric
                   properties of the SDS in english and australian samples of heroin, cocaine and amphetamine users. Addiction, 90(5), 607-614."),
                 c("Cuevas, C. D. L., Sanz, E. J., Fuente, Juan A De La, Padilla, J., & Berenguer, J. C. (2000). The severity of dependence scale (SDS) as screening
                   test for benzodiazepine dependence: SDS validation study. Addiction, 95(2), 245-250."),
                 c("Lerma, J. (2010). Estimation of cutoff for the severity of dependence scale (SDS) for opiate dependence by ROC analysis.
                   Actas Esp Psiquiatr, 38(5), 270-277."),
                 c("Tang, W. K., Morgan, C. J., Lau, G. C., Liang, H. J., Tang, A., & Ungvari, G. S. (2015). Psychiatric morbidity in ketamine users
                   attending counselling and youth outreach services. Substance Abuse, 36(1), 67-74.")
               )

                )

GAD_7<- list(  title = "Generalized Anxiety Disorder 7-Item Scale (GAD-7)", #Title can contain white space. For insertion into widget headings, plot titles etc.
                   brief_title = "GAD-7",
                   measure = "GAD_7", #The overal measure (which may contain subscales)
                   subscale = "GAD_7", #The specific subscale of the measure.
                   population_quantity = 11,
                   populations = list("Male_General_Population", "Female_General_Population", "Older_Adult", "Primary_Care", "Psychiatric", "Generalized_Anxiety_Disorder",
                                      "Chronic_Musculoskeletal_Pain", "Coronary_Heart_Disease", "Type_1_Diabetes", "Type_2_Diabetes", "Stroke", "Other"),
                   means = list(3.01, 4.07, 2, 5.75, 10.86, 12.59, 2.6, 11.9, 4.7, 4.5, 3.87, 0),
                   sds = list(3.12, 3.53, 2.88, 4.76, 5.62, 3.96, 2.3, 5.3, 4.6, 4.9, 4.52, 0),
                   mean_sd_references = list("Hinz, Klein, Brähler, Glaesmer et al. (2017)", "Hinz, Klein, Brähler, Glaesmer et al. (2017)", "Wild, Eckl, Herzog, Niehoff et al. (2012)",
                                             "Jordan, Shedden-Mora & Löwe (2017)", "Beard & Björgvinsson (2014)", "Dear, Titov, Sunderland, McMillan, Anderson et al. (2011)",
                                             "Bair, Wu, Damush, Sutherland & Kroenke (2008)", "Conventry, Lovell, Dickens, Bower et al. (2015)", "Fenwick, Rees, Homes-Truscott,
                                              Browne, Pouwer et al. (2016)",
                                             "Fenwick, Rees, Homes-Truscott, Browne, Pouwer et al. (2016)", "Schmid, Arnold, Jones, Ritter, Sapp et al. (2015)", "Define Value"),
                   reliabilities = list(.83, .83, .83, .83, .83, .83, .83, .83, .83, .83, .83, 0),
                   reliability_references = list("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                                 "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                                 "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                                 "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Define Value"),
                   cutoff_values = list(c(5, 10, 15, 3.01, 3.01 + 3.12, 3.01 + (2 * 3.12)), c(5, 10, 15, 4.07, 4.07 + 3.53, 4.07 + (2 * 3.53)),
                                        c(5, 10, 15, 2, 2 + 2.88, 2 + (2 * 2.88)), c(5, 10, 15, 6.75, 5.75 + 4.76, 5.75 + (2 *4.76)),
                                        c(5, 10, 15, 10.86, 10.86 + 5.62, 10.86 + (2 * 5.62)), c(5, 10, 15, 12.59, 12.59 + 3.96, 12.59 + (2 * 3.96)),
                                        c(5, 10, 15, 2.6, 2.6 + 2.3, 2.6 + (2 * 2.3)), c(5, 10, 15, 11.9, 11.9 + 5.3, 11.9 + (2 * 5.3)),
                                        c(5, 10, 15, 4.7, 4.7 + 4.6, 4.7 + (2 * 4.6)), c(5, 10, 15, 4.5, 4.5 + 4.9, 4.5 + (2 * 4.9)),
                                        c(5, 10, 15, 3.87, 3.87 + 4.52, 3.87 + (2 * 4.52)), c(0, 0, 0, 0, 0, 0)),
                   cutoff_labels = list(c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2 Sd"), c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2.5 Sd"),
                                        c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2 Sd"), c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2 Sd"),
                                        c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2 Sd"), c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2 Sd"),
                                        c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2 Sd"), c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2 Sd"),
                                        c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2 Sd"), c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2 Sd"),
                                        c("Mild", "Moderate", "Severe", "Mean", "Mean + 1 Sd", "Mean + 2 Sd"), c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value",
                                                                                                                 "Define Value")),
                   cutoff_references = list(c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Hinz, Klein, Brähler, Glaesmer et al. (2017)", "Hinz, Klein, Brähler, Glaesmer et al. (2017)",
                                              "Hinz, Klein, Brähler, Glaesmer et al. (2017)"),
                                            c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Hinz, Klein, Brähler, Glaesmer et al. (2017)", "Hinz, Klein, Brähler, Glaesmer et al. (2017)",
                                              "Hinz, Klein, Brähler, Glaesmer et al. (2017)"),
                                            c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Wild, Eckl, Herzog, Niehoff et al. (2012)", "Wild, Eckl, Herzog, Niehoff et al. (2012)", "Wild, Eckl, Herzog, Niehoff et al. (2012)"),
                                            c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Jordan, Shedden-Mora & Löwe (2017)", "Jordan, Shedden-Mora & Löwe (2017)", "Jordan, Shedden-Mora & Löwe (2017)"),
                                            c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Beard & Björgvinsson (2014)", "Beard & Björgvinsson (2014)", "Beard & Björgvinsson (2014)"),
                                            c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Dear, Titov, Sunderland, McMillan, Anderson et al. (2011)",
                                              "Dear, Titov, Sunderland, McMillan, Anderson et al. (2011)", "Dear, Titov, Sunderland, McMillan, Anderson et al. (2011)"),
                                            c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Bair, Wu, Damush, Sutherland & Kroenke (2008)", "Bair, Wu, Damush, Sutherland & Kroenke (2008)", "Bair, Wu, Damush, Sutherland & Kroenke (2008)"),
                                            c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Conventry, Lovell, Dickens, Bower et al. (2015)", "Conventry, Lovell, Dickens, Bower et al. (2015)", "Conventry, Lovell, Dickens, Bower et al. (2015)"),
                                            c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Fenwick, Rees, Homes-Truscott, Browne, Pouwer et al. (2016)", "Fenwick, Rees, Homes-Truscott, Browne, Pouwer et al. (2016)",
                                              "Fenwick, Rees, Homes-Truscott, Browne, Pouwer et al. (2016)"),
                                            c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Fenwick, Rees, Homes-Truscott, Browne, Pouwer et al. (2016)" , "Fenwick, Rees, Homes-Truscott, Browne, Pouwer et al. (2016)",
                                              "Fenwick, Rees, Homes-Truscott, Browne, Pouwer et al. (2016)"),
                                            c("Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)", "Spitzer, Kroenke, Williams & Löwe (2006)",
                                              "Schmid, Arnold, Jones, Ritter, Sapp et al. (2015)" , "Schmid, Arnold, Jones, Ritter, Sapp et al. (2015)",
                                              "Schmid, Arnold, Jones, Ritter, Sapp et al. (2015)"),
                                            c("Define Value", "Define Value", "Define Value", "Define Value", "Define Value", "Define Value")),
                   cutoff_quantity = 6,
                   items = 1:7,
                   max_score = 30,
                   min_score = 0,
                   plot_shading_gap = 0.1, #Gap = next cutoff minus plot_shading gap
                   plot_cutoff_label_start = 0.8, #Indicates how far above the cutoff value the text cutoff label starts
                   plot_cutoff_label_size = 3,
                   description = readr::read_file(
                     "gad7.md"
                   ),
                   sample_overview = list(c("4615 German males drawn from the general population."),
                                           c("5106 German females drawn from the general population."),
                                           c("438 older German participants aged 58-82."),
                                           c("3404 German primary care patients."),
                                           c("1082 American patients with heterogeneous diagnoses who undertook treatment at a psychiatric hospital."),
                                           c("125 Australian adults with Generalised Anxiety Disorder at baseline of an RCT."),
                                           c("271 American adults with musculoskeletal pain of the low back, hip or knee & nil depression or anxiety."),
                                           c("196 English participants with diabetes and/or coronary heart disase with a PHQ-9 score of 10 or greater."),
                                           c("693 Australian participants with Type 1 diabetes."),
                                           c("1012 Australian participants with Type 2 diabetes."),
                                           c("77 participants with chronic stroke > 6 months post-stroke."),
                                           c("No sample information to provide.")
                                           ),
                   journal_references = list(c("Hinz, A., Klein, A. M., Brähler, E., Glaesmer, H., Luck, T., Riedel-Heller, S. G., . . . Hilbert, A. (2017). Psychometric
                                               evaluation of the generalized anxiety disorder screener GAD-7, based on a large german general population sample.
                                               Journal of Affective Disorders, 210, 338-344."),
                                             c("Hinz, A., Klein, A. M., Brähler, E., Glaesmer, H., Luck, T., Riedel-Heller, S. G., . . . Hilbert, A. (2017). Psychometric
                                               evaluation of the generalized anxiety disorder screener GAD-7, based on a large german general population sample. Journal of
                                               Affective Disorders, 210, 338-344."),
                                             c("Wild, B., Eckl, A., Herzog, W., Niehoff, D., Lechner, S., Maatouk, I., . . . Löwe, B. (2014). Assessing generalized anxiety disorder
                                               in elderly people using the GAD-7 and GAD-2 scales: Results of a validation study. The American Journal of Geriatric Psychiatry, 22(10),
                                               1029-1038."),
                                             c("Jordan, P., Shedden-Mora, M. C., & Löwe, B. (2017). Psychometric analysis of the generalized anxiety disorder scale (GAD-7) in primary care using modern
                                               item response theory. PloS One, 12(8), e0182162."),
                                             c("Beard, C., & Björgvinsson, T. (2014). Beyond generalized anxiety disorder: Psychometric properties of the GAD-7 in a heterogeneous psychiatric sample.
                                               Journal of Anxiety Disorders, 28(6), 547-552."),
                                             c("Dear, B. F., Titov, N., Sunderland, M., McMillan, D., Anderson, T., Lorian, C., & Robinson, E. (2011). Psychometric comparison of the
                                               generalized anxiety disorder scale-7 and the penn state worry questionnaire for measuring response during treatment of generalised
                                               anxiety disorder. Cognitive Behaviour Therapy, 40(3), 216-227."),
                                             c("Bair, M. J., Wu, J., Damush, T. M., Sutherland, J. M., & Kroenke, K. (2008). Association of depression and anxiety alone and in combination with chronic
                                               musculoskeletal pain in primary care patients. Psychosomatic Medicine, 70(8), 890-897."),
                                             c("Coventry, P., Lovell, K., Dickens, C., Bower, P., Chew-Graham, C., McElvenny, D., . . . Gask, L. (2015). Integrated primary care
                                               for patients with mental and physical multimorbidity: Cluster randomised controlled trial of collaborative care for
                                               patients with depression comorbid with diabetes or cardiovascular disease. BMJ (Clinical Research Ed.), 350, h638."),
                                             c("Fenwick, E. K., Rees, G., Holmes-Truscott, E., Browne, J. L., Pouwer, F., & Speight, J. (2016). What is the best measure for
                                               assessing diabetes distress? A comparison of the problem areas in diabetes and diabetes distress scale: Results from
                                               diabetes MILES–Australia. Journal of Health Psychology"),
                                             c("Fenwick, E. K., Rees, G., Holmes-Truscott, E., Browne, J. L., Pouwer, F., & Speight, J. (2016). What is the best measure for
                                               assessing diabetes distress? A comparison of the problem areas in diabetes and diabetes distress scale: Results from
                                               diabetes MILES–Australia. Journal of Health Psychology"),
                                             c("Schmid, A. A., Arnold, S. E., Jones, V. A., Ritter, M. J., Sapp, S. A., & Van Puymbroeck, M. (2015). Fear of falling in people
                                               with chronic stroke. American Journal of Occupational Therapy, 69(3), 6903350020p1-6903350020p5."),
                                             c("No sample information to provide."))

                   )

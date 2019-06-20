#' List generator for population paramaters for a subscale
#'
#' Outputs the correct list of parameters for the population selected by the user (parameters are then available for default values.
#' of widgets).
#'
#' @param title A string indicating the title of the measure.
#'
#' @param brief_title A string indicating the abbreviated title of the measure.
#'
#' @param measure A string indicating the measure (no white space).
#'
#' @param subscale A string indicating the subscale (no white space).
#'
#' @param population_quantity A numeric value of possible populations from which the user can select.
#'
#' @param populations A list of strings (underscores should replace white space) indicating the possible range of populations.
#'
#' @param input_population A string indicating the population selected by the user.
#'
#' @param sds A list of numeric values representing the standard deviations for all populations on that subscale.
#'
#' @param means A list of numeric values representing the means for all populations on that subscale.
#'
#' @param mean_sd_references A list of strings indicating the references for each mean/standard deviation by population.
#'
#' @param reliabilities A list of numeric values representing the test-retest reliabilities for all populations on that subscale.
#'
#' @param reliability_references A list of strings indicating the references for each reliability value by population.
#'
#' @param cutoffs A list of concatenated numeric values representing the cutoff values on this subscale for each population.
#'
#' @param cutoff_names A list of concatenated strings indicating the cutoff value descriptors. Use rep() function to multiple by populations.
#'
#' @param cutoff_references A list of strings indicating the references for each reliability value by population.
#'
#' @param cutoff_quantity A numeric value indicating the number of cutoff scores for the subscale.
#'
#' @param items A numeric vector representing an item index for the subscale.
#'
#' @param max_score A numeric value indicating maximum possible score on the subscale.
#'
#' @param min_score A numeric value indicating minimum possible score on the subscale.
#'
#' @param plot_shading_gap A numeric value subtracted from a cutoff score to indicate the amount of white space between shaded rectangles.
#'
#' @param plot_cutoff_label_start A numeric value added to a cutoff score to indicate how far up the cutoff label appears.
#'
#' @param plot_cutoff_label_size A numeric value indicating the font size of the cutoff labels.
#'
#' @param description A description of subscale's properties, to display in report.
#'
#' @export

#The paramaters from the subscale list (some of which are themselves lists) are passed as arguments.

params_list_maker<- function(title, brief_title, measure, subscale, population_quantity, populations, input_population, sds, means, mean_sd_references, reliabilities, reliability_references,
                             cutoff_values, cutoff_labels, cutoff_references, cutoff_quantity, items, max_score, min_score, plot_shading_gap,
                             plot_cutoff_label_start, plot_cutoff_label_size, description) {

  req(input_population)

  if( !(input_population %in% populations )) {    #Need to make sure that stored settings for 'Other' are retrieved.

    input_population<- "Other"

  }

#Loop over each list stored in the subscale list

  params_list<- purrr::pmap(list(

    populations = populations,
    mean_sd_rel_ids = list("mean_sd_rel_value_id"), #Generate an id value for the mean, sd and reliability widgets
    means = means,
    sds = sds,
    mean_sd_references = mean_sd_references,
    reliabilities = reliabilities,
    reliability_references = reliability_references,
    cutoff_value_ids = list(paste("cutoff_value_id", "_", 1:cutoff_quantity, sep = "")), #Generate ids for the cutoff value widgets: 'cutoff_value_id_1' etc.
    cutoff_label_ids = list(paste("cutoff_label_id", "_", 1:cutoff_quantity, sep = "")), #Generate ids for the widgets containing cutoff names/labels: 'cutoff_name_id_1' etc.
    cutoff_values = cutoff_values,
    cutoff_labels = cutoff_labels,
    cutoff_references = cutoff_references,
    mean_sd_rel_reference_ids<- list("mean_sd_rel_reference_id"), #Generate ids for the widgets containing mean, sd and reliability references
    cutoff_reference_ids = list(paste("cutoff_reference_id", "_", 1:cutoff_quantity, sep = "")) #Generate id for the widgets cutaining cutoff reference strings:
  ),

  #Pass the lists used by pmap() as function arguments

  function(mean_sd_rel_ids, populations, means, sds, mean_sd_references, reliabilities, reliability_references, cutoff_values, cutoff_labels, cutoff_references,
           cutoff_value_ids, cutoff_label_ids, mean_sd_rel_reference_ids, cutoff_reference_ids) {


#Create a list of paramaters for each unique population

    list(mean_sd_rel_ids = mean_sd_rel_ids, populations = populations, means = means, sds = sds, mean_sd_references = mean_sd_references,
         reliabilities = reliabilities, reliability_references = reliability_references, cutoff_value_ids = cutoff_value_ids,
         cutoff_label_ids = cutoff_label_ids, cutoff_values = cutoff_values, cutoff_labels = cutoff_labels, cutoff_references = cutoff_references,
         mean_sd_rel_reference_ids = mean_sd_rel_reference_ids, cutoff_reference_ids = cutoff_reference_ids)

  }

  )

#Set the names of each list to be the population names (underscores replacing white space)

  names(params_list)<- populations


#Use the population_selected object to return the correct list (i.e. the one containing the values of the population selected by the user)

  params_list[[input_population]]

}

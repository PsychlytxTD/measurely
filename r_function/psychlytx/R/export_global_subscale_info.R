#' Export Global Subscale Info
#'
#' Export a global list to Amazon S3 containing the sublists of all subscale parameters.
#'
#' @export


export_global_subscale_info<- function() {

  aws.s3::get_bucket('measurely.subscale.parameters')

  aws.s3::put_object(file = "global_subscale_info_list.rds", object = "global_subscale_info_list",
           bucket = 'measurely.subscale.parameters', region = "ap-southeast-2")

}

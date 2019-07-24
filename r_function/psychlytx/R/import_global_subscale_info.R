#' Import Global Subscale Info
#'
#' Import a global list from Amazon S3 containing the sublists of all subscale parameters.
#'
#' @export



import_global_subscale_info<- function() {

  aws.s3::get_bucket('measurely.subscale.parameters')  #Function will automatically locate the AWS access key id and
                                                       #and the AWS secret access key from the .Renviron file.

  aws.s3::save_object(object = "global_subscale_info_list", bucket = 'measurely.subscale.parameters',
                      file = "global_subscale_info_list.rds", region = "ap-southeast-2") #Save the global_subscale_info_list
                                                                                         #to the working directory.


  while (!file.exists("global_subscale_info_list.rds")) {
    Sys.sleep(1) # Toavoid error, make sure we don't read in the file before it has been saved to working directory.
  }

  global_subscale_info<- readRDS("global_subscale_info_list.rds") #Read in and return the global_subscale_info_list


}


#Below is alternative way to import the global_subscale_info_list.


#global_subscale_info<- psychlytx::import_global_subscale_info() #Import the global subscale info list from the Amazon S3 bucket

#global_subscale_info<- aws.s3::save_object(object = "global_subscale_info_list", bucket = 'measurely.subscale.parameters',
                                           #file = "global_subscale_info_list.rds", key = Sys.getenv("AWS_ACCESS_KEY_ID"),
                                           #secret = Sys.getenv("AWS_SECRET_ACCESS_KEY"),
                                           #region = "ap-southeast-2") #Import the global_subscale_info_list from S3


#while (!file.exists("global_subscale_info_list.rds")) {  # Toavoid error, make sure we don't read in the file before it has been saved to wd
#  Sys.sleep(1)
#}

#global_subscale_info<- readRDS("global_subscale_info_list.rds") #Read in the global_subscale_info_list


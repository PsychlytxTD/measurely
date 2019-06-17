#' Add Statistically Reliable Change Variable
#'
#' Make new variable (change) that denotes score change and whether such change is statistically reliable
#'
#' @param subscale_df A dataframe containing only data for a particular subscale
#'
#' @export

make_change_variable<- function( subscale_df ) {


#Make logical vector indicating whether change is statistically reliable

status<- subscale_df$score > lag( subscale_df$ci_upper ) | subscale_df$score < lag( subscale_df$ci_lower )

#Calculate the raw change variable without adding it to subscale_df

change<- subscale_df$score - lag( subscale_df$score )

#Add significance stars to each cell of change variable, if change is statistically reliable

subscale_df$change<- ifelse( status == TRUE, paste( change, "*" ), change )

#Return the original subscale dataframe, with the new change variable added

subscale_df<- subscale_df %>% dplyr::select( date, score, change, everything() )

subscale_df

}

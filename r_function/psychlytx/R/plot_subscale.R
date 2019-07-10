#' Plot Subscale
#'
#' Plot an individual subscale
#'
#' @param subscale_df A dataframe containing only data for a particular subscale
#'
#' @param subscale_info A list of subscale parameters
#'
#' @export
#'
#' @examples plot_subscale(subscale_df = subscale_df, subscale_info= psychlytx::gad7_params)






plot_subscale <- function(subscale_df, subscale_info) {


  #Convert date variable to date class

  subscale_df <- transform(subscale_df, date = chron(date, format = "d/m/Y" ) )


  #Calculate the ymin and ymax values to use with cutoff shading

  ymin_cutoff_1 <- subscale_df$cutoff_value_1[1]

  ymax_cutoff_1 <- subscale_df$cutoff_value_2[1] - subscale_info$plot_shading_gap[1]

  ymin_cutoff_2 <- subscale_df$cutoff_value_2[1]

  ymax_cutoff_2 <- subscale_df$cutoff_value_3[1] - subscale_info$plot_shading_gap[1]

  ymin_cutoff_3 <- subscale_df$cutoff_value_3[1]

  ymax_cutoff_3 <- subscale_df$cutoff_value_4[1] - subscale_info$plot_shading_gap[1]

  ymin_cutoff_4 <- subscale_df$cutoff_value_4[1]

  ymax_cutoff_4 <- subscale_df$cutoff_value_5[1] - subscale_info$plot_shading_gap[1]

  ymin_cutoff_5 <- subscale_df$cutoff_value_5[1]

  ymax_cutoff_5 <- subscale_df$cutoff_value_6[1] - subscale_info$plot_shading_gap[1]

  ymin_cutoff_6 <- subscale_df$cutoff_value_6[1]

  ymax_cutoff_6 <- Inf


  #Need to make sure confidence intervals don't disappear from plot - so manually increase y-axis limits
  #to the max/min score plus/minus 10% (this should be enough)

  y_axis_upper_expansion<- subscale_info$max_score + ( subscale_info$max_score * 0.1 )

  y_axis_lower_expansion<- subscale_info$min_score - ( subscale_info$min_score * 0.1 )


  #Need to increase space between 0 and first tick on x-axis to make space for cutoff labels

  if(nrow(subscale_df) == 1) {

  x_axis_lower_expansion <- subscale_df$date[1] - 30

  } else {

    x_axis_expansion_factor<- (subscale_df$date[length(subscale_df$date)] - subscale_df$date[1]) * 0.3

    x_axis_lower_expansion<- subscale_df$date[1] - x_axis_expansion_factor

  }


  #Plot breaks & break labs - need to replace this with the minimum and maximum possible scores on the scale

  plotting_increment <- subscale_info$max_score * 0.2

  plotting_breaks <- seq( from = subscale_info$min_score, to = subscale_info$max_score, by = round(plotting_increment, 0 ) )

  plotting_break_labels <- paste( plotting_breaks )


  plot <-
    ggplot(subscale_df, aes(x = date, y = score, group = 1)) + theme_bw(base_family = "Linux Libertine") + annotate(
      "rect",
      xmin = -Inf,
      xmax = Inf,
      #Make the cutoff shading rectangles
      ymin = ymin_cutoff_1,
      ymax = ymax_cutoff_1,
      alpha = 0.8,
      fill = "#ffffd4"
    ) + annotate(
      "rect",
      xmin = -Inf,
      xmax = Inf,
      #Make the cutoff shading rectangles
      ymin = ymin_cutoff_2,
      ymax = ymax_cutoff_2,
      alpha = 0.8,
      fill = "#fee391"
    ) + annotate(
      "rect",
      xmin = -Inf,
      xmax = Inf,
      #Make the cutoff shading rectangles
      ymin = ymin_cutoff_3,
      ymax = ymax_cutoff_3,
      alpha = 0.8,
      fill = "#fec44f"
    ) + annotate(
      "rect",
      xmin = -Inf,
      xmax = Inf,
      #Make the cutoff shading rectangles
      ymin = ymin_cutoff_4,
      ymax = ymax_cutoff_4,
      alpha = 0.8,
      fill = "#fe9929"
    ) + annotate(
      "rect",
      xmin = -Inf,
      xmax = Inf,
      #Make the cutoff shading rectangles
      ymin = ymin_cutoff_5,
      ymax = ymax_cutoff_5,
      alpha = 0.8,
      fill = "#d95f0e"
    ) + annotate(
      "rect",
      xmin = -Inf,
      xmax = Inf,
      #Make the cutoff shading rectangles
      ymin = ymin_cutoff_6,
      ymax = ymax_cutoff_6,
      alpha = 0.8,
      fill = "#993404"
    ) + geom_errorbar(
      aes(ymin = ci_lower, ymax = ci_upper),
      #Make error bars
      width = 10,
      size = 1,
      color = "#00004c"
    ) + geom_line(color = "#00004c", size = 1.8) + geom_point(
      shape = 21,
      fill = "#00004c",
      color = "#00004c",
      #Make points and line
      size =
        4        #Expand y limits
    ) +
    expand_limits(y = c(y_axis_lower_expansion, y_axis_upper_expansion)) +
    theme(
      panel.border = element_rect(
        colour = "#00004c",
        fill = NA,
        #Style plot border
        size =
          3
      ),
      axis.text.x = element_text(
        angle = 70,
        hjust = 1,
        #Style x-axis labels
        size = 11,
        family = "Linux Libertine",
        colour = "black"
      ),
      axis.text.y = element_text(
        size = 11,
        #Style y-axis labels
        family = "Linux Libertine",
        colour = "black"
      )
    ) + theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),       #Remove gridlines from background
      panel.background = element_blank(),
      axis.line = element_line(colour = "black"), #Make axis lines black
      axis.title = element_text(family = "Linux Libertine", size = 12) #Set font of axis titles
    ) + ggrepel::geom_label_repel(aes(label = paste0(subscale_df$score)), #Make labels for scores
                                  size = 4, family = "Linux Libertine") +
    scale_y_continuous(breaks = plotting_breaks, #Customise y-axis breaks and labels
                       labels = plotting_break_labels) +
    scale_x_chron(breaks = subscale_df$date, #Customise x-axis date breaks and labels to be the same as the data
                  format = "%d/%m/%Y") +
    xlab(NULL) +
    ylab(paste(subscale_info$brief_title, "Score")) #Make x and y plot labels sentence case


  #Position cutoff labels

  plot <-
    plot + geom_text(
      aes(
        label = paste(cutoff_label_1, ":", cutoff_value_1),
        x = as.Date(x_axis_lower_expansion),
        y = cutoff_value_1
      ),
      #Position cutoff label 1
      hjust = 0,
      nudge_y = subscale_info$plot_cutoff_label_start[1],
      family = "Linux Libertine",
      size = subscale_info$plot_cutoff_label_size[1]
    ) + geom_text(
      aes(
        label = paste(cutoff_label_2, ":", cutoff_value_2),
        x = as.Date(x_axis_lower_expansion),
        y = cutoff_value_2
      ),
      #Position cutoff label 2
      hjust = 0,
      nudge_y = subscale_info$plot_cutoff_label_start[2],
      family = "Linux Libertine",
      size = subscale_info$plot_cutoff_label_size[1]
    ) + geom_text(
      aes(
        label = paste(cutoff_label_3, ":", cutoff_value_3),
        x = as.Date(x_axis_lower_expansion),
        y = cutoff_value_3
      ),
      #Position cutoff label 3
      hjust = 0,
      nudge_y = subscale_info$plot_cutoff_label_start[3],
      family = "Linux Libertine",
      size = subscale_info$plot_cutoff_label_size[1]
    ) + geom_text(
      aes(
        label = paste(cutoff_label_4, ":", cutoff_value_4),
        x = as.Date(x_axis_lower_expansion),
        y = cutoff_value_4
      ),
      #Position cutoff label 4
      hjust = 0,
      nudge_y = subscale_info$plot_cutoff_label_start[4],
      family = "Linux Libertine",
      size = subscale_info$plot_cutoff_label_size[1]
    ) + geom_text(
      aes(
        label = paste(cutoff_label_5, ":", cutoff_value_5),
        x = as.Date(x_axis_lower_expansion),
        y = cutoff_value_5
      ),
      #Position cutoff label 5
      hjust = 0,
      nudge_y = subscale_info$plot_cutoff_label_start[5],
      family = "Linux Libertine",
      size = subscale_info$plot_cutoff_label_size[1]
    ) + geom_text(
      aes(
        label = paste(cutoff_label_6, ":", cutoff_value_6),
        x = as.Date(x_axis_lower_expansion),
        y = cutoff_value_6
      ),
      #Position cutoff label 6
      hjust = 0,
      nudge_y = subscale_info$plot_cutoff_label_start[6],
      family = "Linux Libertine",
      size = subscale_info$plot_cutoff_label_size[1]
    )


  m_sd_sample_caption<- grid::grobTree(textGrob(paste("Mean & sd apply to the following client group:", subscale_df$population), x=0.05,  y=0.95, hjust=0,
                            gp=gpar(col = "white", fontsize=11, fontfamily = "Linux Libertine")))

  plot + annotation_custom(m_sd_sample_caption) #Print plot

}

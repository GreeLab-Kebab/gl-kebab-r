##
# Green lab 2019 - Team Kebab
# This R script refers to the Plots operations
##

source('scripts/subject.R')

KB_FIGURE_PATH_BOXPLOT <- "plots/boxplots/"
KB_FIGURE_PATH_HISTOGRAM <- "plots/histograms/"
KB_FIGURE_PATH_SCATTER <- "plots/scatter-plots/"

KB_LBL_OPT_LVL <- "Optimization Level"
KB_LBL_TIME <- "Load Time (ms)"
KB_LBL_ENERGY <- "Energy Consumption (J)"

KB_PLOT_HEIGHT_12 <- 360
KB_PLOT_WIDTH_12 <- 640

#
# BoxPlots
#

kb_plot_boxplot_all_subjects <- function(data) {
  plot_title <- paste("Boxplot for all subjects", sep="")
  file_name <- paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-all-subject.png", sep="")
  
  kb_plot_boxplot(
    data = data,
    plot_title = plot_title,
    file_name = file_name
  )
}

kb_plot_boxplot_per_subject <- function(data) {
  subjects_ids <- kb_get_subjects_data()$id
  
  for (subject_id in subjects_ids){
    subject_data <- kb_get_subject_by_id(subject_id)
    subject_rows <- kb_get_subject_rows_by_id(data, subject_id)
    
    plot_title <- paste("Boxplot for", subject_data$url, "- ID", subject_data$id, "- Rank", subject_data$rank)
    file_name <- paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-id-", subject_data$id, ".png", sep="")
    
    kb_plot_boxplot(
      data = subject_rows,
      plot_title = plot_title,
      file_name = file_name
    )
  }
}

kb_plot_boxplot <- function(data, plot_title="Boxplot", file_name="boxplot.png") { 
  png(file_name, 
      units="px", 
      width=KB_PLOT_WIDTH_12, 
      height=KB_PLOT_HEIGHT_12)
  par(mfrow=c(1,2))
  
  boxplot(data = data, 
          load_time ~ opt_level, 
          xlab = KB_LBL_OPT_LVL,
          ylab = KB_LBL_TIME)
  
  boxplot(data = data, 
          energy_consumed ~ opt_level, 
          xlab = KB_LBL_OPT_LVL,
          ylab = KB_LBL_ENERGY)
  title(plot_title, line = -2.5, outer = TRUE)
  dev.off()
  par(mfrow=c(1,1))
}

#
# Histogram
#

kb_plot_histogram_per_subject <- function(data) {
  subjects_ids <- kb_get_subjects_data()$id
  for (subject_id in subjects_ids){
    subject_data <- kb_get_subject_by_id(subject_id)
    subject_rows <- kb_get_subject_rows_by_id(data, subject_id)
    
    for (opt_lvl in 0:3){
      plot_title <- paste("Histogram for", subject_data$url, "- ID", subject_data$id, "- Rank", subject_data$rank, "- Optimization level", opt_lvl)
      file_name <- paste(KB_FIGURE_PATH_HISTOGRAM, "histogram-id-", subject_data$id, "-opt-lvl", opt_lvl, ".png", sep="")
      
      subject_opt_lvl_rows <- kb_get_subject_rows_by_opt_level(subject_rows, opt_lvl)
      
      kb_plot_histogram(
        data = subject_opt_lvl_rows,
        plot_title = plot_title,
        file_name = file_name
      )
    }
  }
}

kb_plot_histogram_all_subject <- function(data) {
  for (opt_level in 0:3){
    opt_lvl_rows <- kb_get_subject_rows_by_opt_level(data, opt_level)
    plot_title <- paste("Histogram for optimization level ", opt_level)
    file_name <- paste(KB_FIGURE_PATH_HISTOGRAM, "histogram-all-subejcts-opt-level-", opt_level, ".png", sep="")
    
    kb_plot_histogram(
      data = opt_lvl_rows,
      plot_title = plot_title,
      file_name = file_name
    )
  }

}

kb_plot_histogram <- function(data, plot_title="Histogram", file_name="hist.png") {
  png(file_name, 
      units="px", 
      width=KB_PLOT_WIDTH_12, 
      height=KB_PLOT_HEIGHT_12)
  par(mfrow=c(1,2))
  
  hist(data$load_time, 
       xlab = KB_LBL_TIME,
       main="")
  
  hist(data$energy_consumed, 
       xlab = KB_LBL_ENERGY,
       main="")
  
  title(plot_title, line = -2.5, outer = TRUE)
  dev.off()
  par(mfrow=c(1,1))
}

#
# Scatter
#

kb_plot_scatter_per_subject <- function(data) {
  subjects_ids <- kb_get_subjects_data()$id
  for (subject_id in subjects_ids){
    subject_data <- kb_get_subject_by_id(subject_id)
    subject_rows <- kb_get_subject_rows_by_id(data, subject_id)
    
    plot_title <- paste("Scatter Plots for", subject_data$url, "- ID", subject_data$id, "- Rank", subject_data$rank)
    file_name <- paste(KB_FIGURE_PATH_SCATTER, "scatter-id-", subject_data$id, ".png", sep="")
      
      
    kb_plot_scatter(
      data = subject_rows,
      plot_title = plot_title,
      file_name = file_name
    )
  }
}

kb_plot_scatter_per_subject2 <- function(data) {
  subjects_ids <- kb_get_subjects_data()$id
  for (subject_id in subjects_ids){
    subject_data <- kb_get_subject_by_id(subject_id)
    subject_rows <- kb_get_subject_rows_by_id(data, subject_id)
    
    for (opt_lvl in 0:3){
      plot_title <- paste("Scatter Plots for", subject_data$url, "- ID", subject_data$id, "- Rank", subject_data$rank, "- Optimization level", opt_lvl)
      file_name <- paste(KB_FIGURE_PATH_SCATTER, "scatter-id-", subject_data$id, "-opt-lvl", opt_lvl, ".png", sep="")
      
      subject_opt_lvl_rows <- kb_get_subject_rows_by_opt_level(subject_rows, opt_lvl)

      kb_plot_scatter2(
        data = subject_opt_lvl_rows,
        plot_title = plot_title,
        file_name = file_name
      )
    }
  }
}

kb_plot_scatter_all_subject <- function(data) {
  plot_title <- paste("Scatter Plots all subjects")
  file_name <- paste(KB_FIGURE_PATH_SCATTER, "scatter-all-subjects.png", sep="")
  
  kb_plot_scatter(
    data = data,
    plot_title = plot_title,
    file_name = file_name
  )
}

kb_plot_scatter_all_subject2 <- function(data) {
  for (opt_level in 0:3) {
    plot_title <- paste("Scatter Plots all subjects - Optimization Level", opt_level)
    file_name <- paste(KB_FIGURE_PATH_SCATTER, "scatter-all-subjects-opt-lvl", opt_level ,".png", sep="")
    
    rows <- kb_get_subject_rows_by_opt_level(data, opt_level)
    
    kb_plot_scatter2(
      data = rows,
      plot_title = plot_title,
      file_name = file_name
    )
  }
}

kb_plot_scatter <- function(data, plot_title="Scatter", file_name="scatter.png") {
  png(file_name, 
      units="px", 
      width=KB_PLOT_WIDTH_12, 
      height=KB_PLOT_HEIGHT_12)
  par(mfrow=c(2,2))
  
  for(opt_level in 0:3) {
    rows <- kb_get_subject_rows_by_opt_level(data, opt_level)
    subplot_title <- paste("Optimization Level", opt_level)
    plot(data = rows, 
         energy_consumed ~ load_time,
         xlab= KB_LBL_TIME,
         ylab = KB_LBL_ENERGY,
         main=subplot_title)
    abline(lm(data$energy_consumed ~ data$load_time), col="red") # regression line (y~x)
    lines(lowess(data$energy_consumed,data$load_time), col="blue") # lowess line (x,y)
  }
  
  title(plot_title, line = -2.5, outer = TRUE)
  dev.off()
  par(mfrow=c(1,1))
}

kb_plot_scatter2 <- function(data, plot_title="Scatter", file_name="scatter.png") {
  png(file_name, 
      units="px", 
      width=KB_PLOT_WIDTH_12, 
      height=KB_PLOT_HEIGHT_12)
  par(mfrow=c(1,1))

  plot(data = data, 
       energy_consumed ~ load_time,
       xlab= KB_LBL_TIME,
       ylab = KB_LBL_ENERGY,
       main="")
  abline(lm(data$energy_consumed ~ data$load_time), col="red") # regression line (y~x)
  lines(lowess(data$energy_consumed,data$load_time), col="blue") # lowess line (x,y)
  
  title(plot_title, line = -2.5, outer = TRUE)
  dev.off()
  par(mfrow=c(1,1))
}
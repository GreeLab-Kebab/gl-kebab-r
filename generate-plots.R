##
# Green lab 2019 - Team Kebab
# This R script generates basic plots for initial analysis of the data
##

# install.packages("tidyverse") ggplot

source('scripts/subject.R')
source('scripts/io.R')
source('scripts/plot.R')

#
# Read data and set column types
#

experiment_results  <- kb_read_csv_formated()
experiment_results_energy_50_100 <- experiment_results[experiment_results$energy_consumed < 100,]
columns <- c("load_time", "energy_consumed")

#
# Violin
# 

plot_violin_time <- kb_get_plot_violin(experiment_results, "load_time")
plot_violin_energy <- kb_get_plot_violin(experiment_results, "energy_consumed")
plot_violin_energy_50_100 <- kb_get_plot_violin(experiment_results_energy_50_100, "energy_consumed", ymin=50)

kb_write_ggplot(
  plot = plot_violin_time, 
  file_name = paste(KB_FIGURE_PATH_VIOLIN, "violin-time.png", sep=""))

kb_write_ggplot(
  plot = plot_violin_energy, 
  file_name = paste(KB_FIGURE_PATH_VIOLIN, "violin-energy.png", sep=""))

kb_write_ggplot(
  plot = plot_violin_energy_50_100, 
  file_name = paste(KB_FIGURE_PATH_VIOLIN, "violin-energy-0-100.png", sep=""))

#
# BoxPlots
# 

plot_box_time <- kb_get_plot_boxplot(experiment_results, "load_time")
plot_box_energy <- kb_get_plot_boxplot(experiment_results, "energy_consumed")
plot_box_energy_50_100 <- kb_get_plot_boxplot(experiment_results_energy_50_100, "energy_consumed", ymin=50)

kb_write_ggplot(
  plot = plot_box_time, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-time.png", sep=""))

kb_write_ggplot(
  plot = plot_box_energy, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-energy.png", sep=""))

kb_write_ggplot(
  plot = plot_box_energy_50_100, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-energy-0-100.png", sep=""))

#
# Histogram
# 

for (opt_lvl in 0:3) {
  for (column in columns) {
    plot <- kb_get_plot_histogram(
      kb_get_subject_rows_by_opt_level(experiment_results, opt_lvl), 
      column, 
      opt_lvl)
    
    columnm_lbl <- ifelse(column == "load_time", "time", "energy")
    
    kb_write_ggplot(
      plot = plot, 
      file_name = paste(KB_FIGURE_PATH_HISTOGRAM, "histogram-", columnm_lbl, "-opt_level-", opt_lvl, ".png", sep=""))
  }
}

#
# QQ-Plot
#
for (opt_lvl in 0:3) {
  for (column in columns) {
    plot <- kb_get_plot_qq(
      kb_get_subject_rows_by_opt_level(experiment_results, opt_lvl), 
      column, 
      opt_lvl)
    
    columnm_lbl <- ifelse(column == "load_time", "time", "energy")
    
    kb_write_ggplot(
      plot = plot, 
      file_name = paste(KB_FIGURE_PATH_QQ, "qqplot-", columnm_lbl, "-opt_level-", opt_lvl, ".png", sep=""))
  }
}

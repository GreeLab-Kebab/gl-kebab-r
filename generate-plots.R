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
kb_set_plot_base_colors(experiment_results)

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

kb_get_plot_histogram(
  kb_get_subject_rows_by_opt_level(experiment_results, 1), 
  "load_time")

kb_get_plot_histogram(
  experiment_results, 
  "load_time")

# QQ-Plot
kb_plot_qqplot_all_subjects(experiment_results)

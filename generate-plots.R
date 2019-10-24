##
# Green lab 2019 - Team Kebab
# This R script generates basic plots for initial analysis of the data
##

# install.packages("tidyverse")

source('scripts/subject.R')
source('scripts/io.R')
source('scripts/plot.R')

#
# Read data and set column types
#

experiment_results  <- kb_read_csv_formated()

#
# Violin
# 

plot_violin_time <- kb_get_plot_violin(experiment_results, "load_time")
plot_violin_energy <- kb_get_plot_violin(experiment_results, "energy_consumed")

kb_write_ggplot(
  plot = plot_violin_time, 
  file_name = paste(KB_FIGURE_PATH_VIOLIN, "violin-time.png", sep=""))

kb_write_ggplot(
  plot = plot_violin_energy, 
  file_name = paste(KB_FIGURE_PATH_VIOLIN, "violin-energy.png", sep=""))

#
# BoxPlots
# 
kb_get_plot_boxplot(experiment_results, "load_time")
plot_hist_time <- kb_get_plot_boxplot(experiment_results, "load_time")
plot_hist_energy <- kb_get_plot_boxplot(experiment_results, "energy_consumed")

kb_write_ggplot(
  plot = plot_hist_time, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-time.png", sep=""))

kb_write_ggplot(
  plot = plot_hist_energy, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-energy.png", sep=""))


# QQ-Plot
kb_plot_qqplot_all_subjects(experiment_results)

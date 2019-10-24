##
# Green lab 2019 - Team Kebab
# This R script generates basic plots for initial analysis of the data
##

# install.packages("tidyverse")

source('scripts/subject.R')
source('scripts/io.R')
source('scripts/plot.R')

# Read data and set column types
experiment_results  <- kb_read_csv_formated()

# Violin Plots
kb_get_plot_violin(experiment_results, "load_time")
kb_get_plot_violin(experiment_results, "energy_consumed")


# BoxPlots
kb_plot_boxplot_all_subjects(experiment_results)

# Histogram
kb_plot_histogram_all_subject(experiment_results)

# Scatter
kb_plot_scatter_all_subject(experiment_results)
kb_plot_scatter_all_subject2(experiment_results)

# QQ-Plot
kb_plot_qqplot_all_subjects(experiment_results)

##
# Green lab 2019 - Team Kebab
# This R script generates basic plots for initial analysis of the data
##

source('scripts/subject.R')
source('scripts/io.R')
source('scripts/plot.R')

# Read data and set column types
experiment_results  <- kb_read_csv_formated()

# Generate BoxPlots
kb_plot_boxplot_per_subject(experiment_results)
kb_plot_boxplot_all_subjects(experiment_results)

# Histogram
kb_plot_histogram_per_subject(experiment_results)
kb_plot_histogram_all_subject(experiment_results)

# Scatter
kb_plot_scatter_per_subject(experiment_results)
kb_plot_scatter_per_subject2(experiment_results)
kb_plot_scatter_all_subject(experiment_results)
kb_plot_scatter_all_subject2(experiment_results)
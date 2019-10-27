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
experiment_results_energy_0_100 <- experiment_results[experiment_results$energy_consumed < 100,]
columns <- c("load_time", "energy_consumed")

kb_dir_reset_plot()

#
# Violin
# 

plot_violin_time <- kb_get_plot_violin(experiment_results, "load_time")
plot_violin_energy <- kb_get_plot_violin(experiment_results, "energy_consumed")
plot_violin_energy_0_100 <- kb_get_plot_violin(experiment_results_energy_0_100, "energy_consumed", ymin=0)

kb_write_ggplot(
  plot = plot_violin_time, 
  file_name = paste(KB_FIGURE_PATH_VIOLIN, "violin-time.png", sep=""))

kb_write_ggplot(
  plot = plot_violin_energy, 
  file_name = paste(KB_FIGURE_PATH_VIOLIN, "violin-energy.png", sep=""))

kb_write_ggplot(
  plot = plot_violin_energy_0_100, 
  file_name = paste(KB_FIGURE_PATH_VIOLIN, "violin-energy-50-100.png", sep=""))

#
# BoxPlots per subject
# 


plot_box_time <- kb_get_plot_boxplot_per_subject(experiment_results, "load_time")
plot_box_energy <- kb_get_plot_boxplot_per_subject(experiment_results, "energy_consumed")
plot_box_energy_0_100 <- kb_get_plot_boxplot_per_subject(experiment_results_energy_0_100, "energy_consumed", ymin=0)

kb_write_ggplot(
  plot = plot_box_time, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-time-subject.png", sep=""))

kb_write_ggplot(
  plot = plot_box_energy, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-energy-subject.png", sep=""))

kb_write_ggplot(
  plot = plot_box_energy_0_100, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-energy-subject-50-100.png", sep=""))


#
# BoxPlots per treatment
# 

plot_box_time <- kb_get_plot_boxplot(experiment_results, "load_time")
plot_box_energy <- kb_get_plot_boxplot(experiment_results, "energy_consumed")
plot_box_energy_0_100 <- kb_get_plot_boxplot(experiment_results_energy_0_100, "energy_consumed", ymin=0)

kb_write_ggplot(
  plot = plot_box_time, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-time.png", sep=""))

kb_write_ggplot(
  plot = plot_box_energy, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-energy.png", sep=""))

kb_write_ggplot(
  plot = plot_box_energy_0_100, 
  file_name = paste(KB_FIGURE_PATH_BOXPLOT, "boxplot-energy-50-100.png", sep=""))

#
# Histogram
# 

# for (opt_lvl in 0:3) {
#   for (column in columns) {
#     plot <- kb_get_plot_histogram(
#       kb_get_subject_rows_by_opt_level(experiment_results, opt_lvl), 
#       column, 
#       opt_lvl)
#     
#     columnm_lbl <- ifelse(column == "load_time", "time", "energy")
#     
#     kb_write_ggplot(
#       plot = plot, 
#       file_name = paste(KB_FIGURE_PATH_HISTOGRAM, "histogram-", columnm_lbl, "-opt_level-", opt_lvl, ".png", sep=""))
#   }
# }

#
# Frequency Polygon
#

plot_freq_poly_time <- kb_get_plot_frequency_polygon(experiment_results, "load_time")
plot_freq_poly_energy <- kb_get_plot_frequency_polygon(experiment_results, "energy_consumed")
plot_freq_poly_energy_0_100 <- kb_get_plot_frequency_polygon(experiment_results_energy_0_100, "energy_consumed")

file_name_plot_freq_poly_time <- paste(KB_FIGURE_PATH_FREQ_POLY, "freqpoly-time.png", sep="")
file_name_plot_freq_poly_energy <- paste(KB_FIGURE_PATH_FREQ_POLY, "freqpoly-energy.png", sep="")
file_name_plot_freq_poly_energy_0_100 <- paste(KB_FIGURE_PATH_FREQ_POLY, "freqpoly-energy-50-100.png", sep="")

kb_write_ggplot(plot = plot_freq_poly_time, file_name = file_name_plot_freq_poly_time)
kb_write_ggplot(plot = plot_freq_poly_energy, file_name = file_name_plot_freq_poly_energy)
kb_write_ggplot(plot = plot_freq_poly_energy_0_100, file_name = file_name_plot_freq_poly_energy_0_100)

#
# QQ-Plot
#

treatments <- c("JSoriginal", "JSopt1", "JSopt2", "JSopt3")

# One per opt_level
for (opt_lvl in 0:3) {
  for (column in columns) {
    plot <- kb_get_plot_qq_per_treatment(
      kb_get_subject_rows_by_opt_level(experiment_results, opt_lvl), 
      column, 
      treatments[opt_lvl + 1])
    
    columnm_lbl <- ifelse(column == "load_time", "time", "energy")
    
    kb_write_ggplot(
      plot = plot, 
      file_name = paste(KB_FIGURE_PATH_QQ, "qqplot-", columnm_lbl, "-opt_level-", opt_lvl, ".png", sep=""))
  }
}

# All opt_level in one
plot_qq_time <- kb_get_plot_qq(experiment_results, "load_time")
plot_qq_energy <- kb_get_plot_qq(experiment_results, "energy_consumed")

file_name_plot_qq_time <- paste(KB_FIGURE_PATH_QQ, "qqplot-time.png", sep="")
file_name_plot_qq_energy <- paste(KB_FIGURE_PATH_QQ, "qqplot-energy.png", sep="")

kb_write_ggplot(plot = plot_qq_time, file_name = file_name_plot_qq_time)
kb_write_ggplot(plot = plot_qq_energy, file_name = file_name_plot_qq_energy)

#
# Scatter
#
plot_scatter <- kb_get_plot_scatter(experiment_results)
plot_scatter_zoom <- kb_get_plot_scatter(experiment_results[experiment_results$energy_consumed < 100,])

file_name_plot_scatter <- paste(KB_FIGURE_PATH_SCATTER, "scatter-energy-time.png", sep="")
file_name_plot_scatter_zoom <- paste(KB_FIGURE_PATH_SCATTER, "scatter-energy-time-zoom.png", sep="")

kb_write_ggplot(plot = plot_scatter, file_name = file_name_plot_scatter)
kb_write_ggplot(plot = plot_scatter_zoom, file_name = file_name_plot_scatter_zoom)

#
# Normallity check on transformed data
#
experiment_results$load_time_sqrt <- sqrt(experiment_results$load_time)
experiment_results$energy_consumed_sqrt <- sqrt(experiment_results$energy_consumed)
experiment_results$load_time_log <- log(experiment_results$load_time)
experiment_results$energy_consumed_log <- log(experiment_results$energy_consumed)

plot_qq_time_sqrt <- kb_get_plot_qq(experiment_results, "load_time_sqrt")
plot_qq_energy_sqrt <- kb_get_plot_qq(experiment_results, "energy_consumed_sqrt")
plot_qq_time_log <- kb_get_plot_qq(experiment_results, "load_time_log")
plot_qq_energy_log <- kb_get_plot_qq(experiment_results, "energy_consumed_log")

file_name_plot_qq_time_sqrt <- paste(KB_FIGURE_PATH_QQ, "qqplot-time-sqrt.png", sep="")
file_name_plot_qq_energy_sqrt <- paste(KB_FIGURE_PATH_QQ, "qqplot-energy-sqrt.png", sep="")
file_name_plot_qq_time_log <- paste(KB_FIGURE_PATH_QQ, "qqplot-time-log.png", sep="")
file_name_plot_qq_energy_log <- paste(KB_FIGURE_PATH_QQ, "qqplot-energy-log.png", sep="")

kb_write_ggplot(plot = plot_qq_time_sqrt, file_name = file_name_plot_qq_time_sqrt)
kb_write_ggplot(plot = plot_qq_energy_sqrt, file_name = file_name_plot_qq_energy_sqrt)
kb_write_ggplot(plot = plot_qq_time_log, file_name = file_name_plot_qq_time_log)
kb_write_ggplot(plot = plot_qq_energy_log, file_name = file_name_plot_qq_energy_log)


#
# Frequency Polygon Transformed data
#

plot_freq_poly_time_log <- kb_get_plot_frequency_polygon(experiment_results, "load_time_log")
plot_freq_poly_time_sqrt <- kb_get_plot_frequency_polygon(experiment_results, "load_time_sqrt")
plot_freq_poly_energy_log <- kb_get_plot_frequency_polygon(experiment_results, "energy_consumed_log")
plot_freq_poly_energy_sqrt <- kb_get_plot_frequency_polygon(experiment_results, "energy_consumed_sqrt")

file_name_plot_freq_poly_time_log <- paste(KB_FIGURE_PATH_FREQ_POLY, "freqpoly-time-log.png", sep="")
file_name_plot_freq_poly_time_sqrt <- paste(KB_FIGURE_PATH_FREQ_POLY, "freqpoly-time-sqrt.png", sep="")
file_name_plot_freq_poly_energy_log <- paste(KB_FIGURE_PATH_FREQ_POLY, "freqpoly-energy-log.png", sep="")
file_name_plot_freq_poly_energy_sqrt <- paste(KB_FIGURE_PATH_FREQ_POLY, "freqpoly-energy-sqrt.png", sep="")

kb_write_ggplot(plot = plot_freq_poly_time_log, file_name = file_name_plot_freq_poly_time_log)
kb_write_ggplot(plot = plot_freq_poly_time_sqrt, file_name = file_name_plot_freq_poly_time_sqrt)
kb_write_ggplot(plot = plot_freq_poly_energy_log, file_name = file_name_plot_freq_poly_energy_log)
kb_write_ggplot(plot = plot_freq_poly_energy_sqrt, file_name = file_name_plot_freq_poly_energy_sqrt)

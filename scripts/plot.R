##
# Green lab 2019 - Team Kebab
# This R script refers to the Plots operations
##

library(ggplot2)

source('scripts/const.R')
source('scripts/subject.R')

#
# ggplot base config
#

kb_get_plot_base_theme <- function() {
  theme(
    legend.position = "none", 
    plot.title = element_text(hjust=0.5, size = rel(1.5)),
    axis.text = element_text(size = rel(1)),
    axis.title = element_text(size = rel(1.25))
  )
}

kb_get_plot_base_labs <- function() {
  labs(
    colour = KB_LBL_OPT_LVL,
    x = KB_LBL_OPT_LVL
  )
}

kb_get_plot_base_aes <- function(){
  aes(
    x=opt_level, 
    colour = opt_level
  )
}

#
# Misc
#

kb_get_label <- function(column) {
  ifelse(column == "load_time", KB_LBL_TIME, KB_LBL_ENERGY)
}

#
# Violin Plot
#

kb_get_violin_plot_title <- function(column) {
  ifelse(column == "load_time", KB_TITLE_PLOT_VIOLIN_TIME, KB_TITLE_PLOT_VIOLIN_ENERGY)
}

kb_get_plot_violin <- function(data, column){
  aes <- modifyList(
    kb_get_plot_base_aes(),
    aes_string(
      y=column
    ))
  
  labs <- modifyList(
    kb_get_plot_base_labs(),
    labs(
      y = kb_get_label(column),
      title = kb_get_violin_plot_title(column)
    ))
  
  theme <- modifyList(
    kb_get_plot_base_theme(),
    theme())
  
  violin <- geom_violin(
    aes(
      fill = opt_level
    ),
    alpha = 1/10,
    draw_quantiles = c(0.25, 0.5, 0.75)
  )
  
  ggplot(data, aes) + 
    violin +
    labs +
    theme +
    expand_limits(y=0)
}

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
  
  title(plot_title, line = -1, outer = TRUE)
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

#
# QQ plot
#

kb_plot_qqplot_all_subjects <- function(data) {
  for (opt_level in 0:3){
    opt_lvl_rows <- kb_get_subject_rows_by_opt_level(data, opt_level)
    plot_title <- paste("QQ-Plot for optimization level ", opt_level)
    file_name <- paste(KB_FIGURE_PATH_QQ, "qq-all-subjects-opt-level-", opt_level, ".png", sep="")
    
    kb_plot_qq(
      data = opt_lvl_rows,
      plot_title = plot_title,
      file_name = file_name
    )
  }
}

kb_plot_qq <- function(data, plot_title="QQ-Plot", file_name="qq.png") {
  png(file_name, 
      units="px", 
      width=KB_PLOT_WIDTH_12, 
      height=KB_PLOT_HEIGHT_12)
  par(mfrow=c(1,2))
  
  qqnorm(data$load_time,
       main=KB_LBL_TIME)
  
  qqnorm(data$energy_consumed,
         main=KB_LBL_ENERGY)

  title(plot_title, line = -1.0, outer = TRUE)
  dev.off()
  par(mfrow=c(1,1))
}
##
# Green lab 2019 - Team Kebab
# This R script refers to the Plots operations
##

library(ggplot2)
library(RColorBrewer)

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
    colour = opt_level,
    fill = opt_level,
    alpha = KB_PLOT_ALPHA_FILL_RATIO
  )
}

kb_get_plot_base_scale <- function(column) {
  range <- 0
  ifelse(column == "load_time", 
         range <- seq(0, 1250, 1250/5),
         range <- seq(0, 250, 250/5))
  
  range
}

kb_get_plot_base_colors <- function() {
  myColors <- brewer.pal(4,"Set1")
  names(myColors) <- as.factor(c("0", "1", "2", "3"))
  plotColorsScale <- scale_colour_manual(name = "opt_level",values = myColors)
  
  plotColorsScale
}

#
# Misc
#

kb_get_label <- function(column) {
  ifelse(column == "load_time", KB_LBL_TIME, KB_LBL_ENERGY)
}

kb_get_plot_title_x_opt_level <- function(column) {
  ifelse(column == "load_time", KB_TITLE_PLOT_TIME_OPT_LEVEL, KB_TITLE_PLOT_ENERGY_OPT_LEVEL)
}

#
# Violin Plot
#

kb_get_plot_violin <- function(data, column, ymin = 0){
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
    draw_quantiles = c(0.25, 0.5, 0.75)
  )
  
  ggplot(data, aes) + 
    violin +
    labs +
    theme +
    expand_limits(y=ymin)
}

#
# BoxPlots
#

kb_get_plot_boxplot <- function(data, column, ymin=0){
  aes <- modifyList(
    kb_get_plot_base_aes(),
    aes_string(
      y=column
    ))
  
  labs <- modifyList(
    kb_get_plot_base_labs(),
    labs(
      y = kb_get_label(column),
      title = kb_get_plot_title_x_opt_level(column)
    ))
  
  theme <- modifyList(
    kb_get_plot_base_theme(),
    theme())
  
  boxplot <- geom_boxplot()
  
  ggplot(data, aes) + 
    boxplot +
    labs +
    theme +
    expand_limits(y=ymin)
}

#
# Histogram
#

kb_get_plot_histogram <- function(data, column){
  aes <- modifyList(
    kb_get_plot_base_aes(),
    aes_string(
      x=column,
      #fill = "opt_level"
    )
  )
  
  labs <- modifyList(
    kb_get_plot_base_labs(),
    labs(
      y = kb_get_label(column),
      title = kb_get_plot_title_x_opt_level(column)
    ))
  
  theme <- modifyList(
    kb_get_plot_base_theme(),
    theme())
  
  hist <- geom_histogram(
    aes(
      fill = factor(opt_level)
    ),
    bins = 30, # default level, set to avoid warning
    alpha = KB_PLOT_ALPHA_FILL_RATIO
  )
  
  ggplot(data, aes) + 
    hist +
    labs +
    #theme +
    scale_x_continuous(breaks = kb_get_plot_base_scale(column)) +
    kb_get_plot_base_colors()
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
##
# Green lab 2019 - Team Kebab
# This R script generates plots using the ggplot library
##

library(ggplot2)
library(RColorBrewer)

source('scripts/const.R')
source('scripts/subject.R')

#
# ggplot base config
#

kb_get_plot_base_theme <- function() {
  scale <- 1.5
  theme(
    legend.position = "none", 
    legend.text = element_text(size = rel(scale * 0.75)),
    legend.title = element_text(size = rel(scale * 0.75)),
    plot.title = element_text(hjust=0.5, size = rel(scale)),
    axis.text = element_text(size = rel(scale * 0.75)),
    axis.title = element_text(size = rel(scale))
  )
}

kb_get_plot_base_labs <- function() {
  labs(
    colour = KB_LBL_OPT_LVL
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

kb_get_plot_base_scale_value <- function(column) {
  range <- 0
  ifelse(column == "load_time", 
         range <- c(0, 1250),
         range <- c(0, 250))
  
  range
}

kb_get_plot_base_scale_count <- function(column) {
  range <- 0
  ifelse(column == "load_time", 
         range <- c(0, 30),
         range <- c(0, 100))
  
  range
}

kb_get_plot_base_colors <- function(n = 4) {
  # source https://stackoverflow.com/a/8197703/6934733
  hues <- seq(15, 375, length = n + 1)
  myColors <- hcl(h = hues, l = 65, c = 100)[1:n]
  
  myColors
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
      x = KB_LBL_OPT_LVL,
      y = kb_get_label(column),
      title = kb_get_plot_title_x_opt_level(column)
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
    theme #+
    #expand_limits(y=ymin)
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
      x = KB_LBL_OPT_LVL,
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
    theme #+
    #expand_limits(y=ymin)
}

#
# Histogram
#

kb_get_plot_histogram <- function(data, column, opt_level){
  .Deprecated("kb_get_plot_frequency_polygon")
  aes <- modifyList(
    kb_get_plot_base_aes(),
    aes_string(
      x=column
    )
  )
  
  labs <- modifyList(
    kb_get_plot_base_labs(),
    labs(
      title = paste(KB_LBL_OPT_LVL, opt_level),
      x = kb_get_label(column),
      y = "Count"
    )
  )
  
  theme <- modifyList(
    kb_get_plot_base_theme(),
    theme())
  
  hist <- geom_histogram(
    bins = 60, # default level = 30
    alpha = KB_PLOT_ALPHA_FILL_RATIO
  )
  
  ggplot(data, aes) + 
    hist +
    labs +
    theme +
    scale_x_continuous(limits = kb_get_plot_base_scale_value(column)) +
    scale_y_continuous(limits = kb_get_plot_base_scale_count(column)) +
    scale_colour_manual(name = "opt_level",values = kb_get_plot_base_colors()) +
    scale_fill_manual(name = "opt_level",values = kb_get_plot_base_colors())
}
# Currently, the histogram plot gives the folowwing warning
#   Removed 2 rows containing missing values (geom_bar). 
# This happens when `scale_x_continuous` is executed
# scale_x_continuous sets the scale for 0-1250 in load time and 0-250 in energy consumed
# However, the minimum and maximum values were checked both time and enery, and all values will fail within the proposed range. 
# > min(experiment_results$load_time)
#[1] 212
#> min(experiment_results$energy_consumed)
#[1] 52.0992
#> max(experiment_results$load_time)
#[1] 1205
#> max(experiment_results$energy_consumed)
#[1] 220.3783
# 
# Furthemore, even when setting the range for -1000 to 2000, the warning still shows.


#
# QQ plot
#

kb_get_plot_qq <- function(data, column) {
  aes <- aes_string(
    sample = column,
    colour = "opt_level"
  )
  
  labs <- modifyList(
    kb_get_plot_base_labs(),
    labs(
      title = paste(kb_get_label(column)),
      x = "Theoretical",
      y = "Sample",
      legend = "Optimization Level"
    )
  )
  
  theme <- modifyList(
    kb_get_plot_base_theme(),
    theme(
      legend.position = "bottom", 
    ))
  
  ggplot(data, aes) + 
    stat_qq() +
    stat_qq_line() +
    theme +
    labs
}

kb_get_plot_qq_per_opt_level <- function(data, column, opt_level){
  aes <- aes_string(
      sample = column,
      colour = "opt_level",
      fill = "opt_level"
  )
  labs <- modifyList(
    kb_get_plot_base_labs(),
    labs(
      title = paste(KB_LBL_OPT_LVL, opt_level, "and", kb_get_label(column)),
      x = "Theoretical",
      y = "Sample"
    )
  )
  
  theme <- modifyList(
    kb_get_plot_base_theme(),
    theme())
  
  ggplot(data, aes) + 
    stat_qq() +
    stat_qq_line() +
    labs +
    theme +
    scale_colour_manual(values = c(kb_get_plot_base_colors()[opt_level+1]))# +
    #scale_y_continuous(limits = kb_get_plot_base_scale_value(column))
}

#
# Frequency Polygon
#

kb_get_plot_frequency_polygon <- function(data, column, ymin=0){
  aes <- modifyList(
    kb_get_plot_base_aes(),
    aes_string(
      x=column,
      alpha = NULL
    )
  )
  
  labs <- modifyList(
    kb_get_plot_base_labs(),
    labs(
      title = paste("Subject frequency per ", kb_get_label(column)),
      x = kb_get_label(column),
      y = "Count"
    )
  )
  
  theme <- modifyList(
    kb_get_plot_base_theme(),
    theme()
  )
  
  freq_poly <- geom_freqpoly(
    bins = 30,
  )
  
  ggplot(data, aes) + 
    freq_poly +
    labs +
    theme #+
    #expand_limits(y=ymin)
}

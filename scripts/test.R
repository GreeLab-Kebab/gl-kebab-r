##
# Green lab 2019 - Team Kebab
# This R script provides warpers for the hypothesis tests
##

source('scripts/const.R')
source('scripts/io.R')

#
# Misc
#

kb_reject_null_hypothesis <- function(p_value) {
  !(p_value < 0.05)
}

kb_get_column_label <- function(column) {
  ifelse(column == "load_time", KB_LBL_TIME, KB_LBL_ENERGY)
}

#
# Shapiro - Normality test
#

kb_get_normality_summary_row <- function(result, opt_level, column) {
  c(
    opt_level, 
    column, 
    result$statistic, 
    result$p.value, 
    kb_reject_null_hypothesis(result$p.value))
}

kb_test_data_normality <- function(result, opt_level, column) {
  opt_level_rows = kb_get_subject_rows_by_opt_level(data, opt_level)
  result <- shapiro.test(opt_level_rows[, column])
}

kb_create_empty_normality_summary_dataframe <- function() {
  setNames(data.frame(
    matrix(ncol = 5, nrow = 0)), 
    c("opt_level", "column", "W", "p-value", "is_normal_dist"))
}

#
# Kruskal
#

kb_get_kruskal_summary_row <- function(result, column) {
  c(
    column, 
    result$statistic, 
    result$parameter,
    result$p.value, 
    kb_reject_null_hypothesis(result$p.value))
}

kb_create_empty_kruskal_summary_dataframe <- function() {
  setNames(data.frame(
    matrix(ncol = 5, nrow = 0)), 
    c("column", "W",  "df", "p-value", "is_null_hypothesis_true"))
}

#
# Wilcox
#


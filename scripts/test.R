##
# Green lab 2019 - Team Kebab
# This R script provides warpers for the hypothesis tests
##

source('scripts/const.R')
source('scripts/io.R')

kb_reject_null_hypothesis <- function(p_value) {
  !(p_value < 0.05)
}

kb_get_result_row_shapiro <- function(result, opt_level, property) {
  c(
    opt_level, 
    property, 
    result$statistic, 
    result$p.value, 
    kb_reject_null_hypothesis(result$p.value))
}

kb_test_data_normality_all <- function(data) {
  result_shapiro <- setNames(data.frame(
    matrix(ncol = 5, nrow = 0)), 
    c("opt_level", "property", "W", "p-value", "is_normal_dist"))
  
  for(opt_level in 0:3){
    opt_level_rows = kb_get_subject_rows_by_opt_level(data, opt_level)
    
    result_time = shapiro.test(opt_level_rows$load_time)
    result_energy = shapiro.test(opt_level_rows$energy_consumed)
    
    result_shapiro[nrow(result_shapiro) + 1,] = kb_get_result_row_shapiro(result_time, opt_level, "time")
    result_shapiro[nrow(result_shapiro) + 1,] = kb_get_result_row_shapiro(result_energy, opt_level, "energy")
    
    kb_print_test_result(
      test_result =  result_time, 
      title = paste("Optimization Level", opt_level, "-", KB_LBL_TIME))
    kb_print_test_result(
      test_result = result_energy, 
      title = paste("Optimization Level", opt_level, "-", KB_LBL_ENERGY))
    
    kb_write_txt_test_result(
      test_result = result_time,
      file_name = paste("test-shapiro-all-subject-opt-level-", opt_level, "-time.txt", sep = ""))
    kb_write_txt_test_result(
      test_result = result_energy,
      file_name = paste("test-shapiro-all-subject-opt-level-", opt_level, "-energy.txt", sep = ""))
  }
  print(result_shapiro)
  kb_write_csv_test_summary_shapiro(result_shapiro)
}

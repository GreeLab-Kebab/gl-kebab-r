##
# Green lab 2019 - Team Kebab
# This R script refers to the Input and Ouput operations
##

library('tidyverse') # dplyr
library('xtable')

source('scripts/const.R')
source('scripts/subject.R')

#
# CSV IO
#

kb_write_csv_formated_all <- function(data) {
  data_sorted <- data[order(data$subject_id, data$opt_level),]
  kb_write_csv(data_sorted, KB_CSV_FILE_ALL_RESULTS_FORMATTED_ALL)
}

kb_write_csv_formated <- function(data){
  data_sorted <- data[order(data$subject_id, data$opt_level),]
  kb_write_csv(data_sorted, KB_CSV_FILE_ALL_RESULTS_FORMATTED)
}

kb_write_csv_raw <- function(data){
  kb_write_csv(data, KB_CSV_FILE_ALL_RESULTS_RAW)
}

kb_write_csv_test_summary_shapiro <- function(data) {
  kb_write_csv(data, KB_CSV_FILE_TEST_SUMMARY_SHAPIRO)
}

kb_write_csv_test_summary_kruskal <- function(data) {
  kb_write_csv(data, KB_CSV_FILE_TEST_SUMMARY_KRUSKAL)
}

kb_write_csv_test_summary_wilcox <- function(data) {
  kb_write_csv(data, KB_CSV_FILE_TEST_SUMMARY_WILCOX)
}

kb_write_csv <- function(data, file_name) {
  write.csv(data, file=file_name, row.names = FALSE)
}

kb_read_csv_raw <- function() {
  file_list <- list.files(
    path = KB_CSV_PATH_OUTPUT,
    full.names = TRUE,
    recursive = TRUE,
    pattern=KB_CSV_FILE_AGGREGATED_RESULTS)
  data <- rbindlist(lapply(file_list, fread))
}

kb_read_csv_raw2 <- function() {
  data <- read.csv(
    KB_CSV_FILE_ALL_RESULTS_RAW, 
    header = TRUE)
}

kb_read_csv_formated <- function() {
  data <- read.csv(
    KB_CSV_FILE_ALL_RESULTS_FORMATTED, 
    header = TRUE)
  
  data <- kb_set_dataframe_column_types(data)
}

#
# Console IO
#
kb_print_count_per_subject_opt_level <- function(data, failed_only){
  if (failed_only){
    data %>% 
      group_by(subject_id, opt_level) %>%
      count() %>%
      filter(n !=  KB_RUNS_NUMBER) %>% 
      print(n=100)
  } else {
    data %>% 
      group_by(subject_id, opt_level) %>%
      count() %>%
      print(n=100)
  }
}

kb_print_test_result <- function(test_result, title) {
  print(paste("=========[ NORMALITY TEST FOR: '", title, "' ]=========", sep=''))
  is_normally_distributed = !(test_result$p.value < 0.05);
  print(test_result)
  print(paste("evidence for normal distribution: ", is_normally_distributed,sep=''))
  print(paste("=========[ END NORMALITY TEST FOR: '", title, "' ]=========", sep=''))
}

#
# Text File IO
#
kb_write_txt_test_result <- function(test_result, file_name, title="") {
  test_output <- capture.output(print(test_result))
  connection <- file(paste(KB_TXT_PATH_TEST, file_name, sep=""))
  writeLines(c(title, test_output), con = connection, sep="\n")
  close(connection)
}
#
# ggplot IO
#
kb_write_ggplot <- function(plot, file_name = "plot.png", height = KB_PLOT_HEIGHT, aspect_ratio = KB_PLOT_RATIO) {
  plot
  ggsave(file_name, plot = plot, height = height , width = height * aspect_ratio)
}
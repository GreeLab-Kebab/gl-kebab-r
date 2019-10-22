##
# Green lab 2019 - Team Kebab
# This R script refers to the Input and Ouput operations
##

library('tidyverse') # dplyr

KB_DATA_PATH_OUTPUT <- "data/androidrunner/output"
KB_DATA_FILE_AGGREGATED_RESULTS <- "\\Aggregated_Results_Batterystats.csv$"
KB_DATA_FILE_ALL_RESULTS_FORMATTED <- "data/androidrunner/experiment_all_results.csv"
KB_DATA_FILE_ALL_RESULTS_RAW <- "data/androidrunner/experiment_all_results_raw.csv"

KB_RUNS_NUMBER <- 10

#
# CSV IO
#

kb_write_csv_formated <- function(data){
  data_sorted <- data[order(data$subject_id, data$opt_level),]
  write.csv(
    data_sorted, 
    file=KB_DATA_FILE_ALL_RESULTS_FORMATTED, 
    row.names = FALSE)
}

kb_write_csv_raw <- function(data){
  write.csv(
    data, 
    file=KB_DATA_FILE_ALL_RESULTS_RAW, 
    row.names = FALSE)
}

kb_read_csv_raw <- function() {
  file_list <- list.files(
    path = KB_DATA_PATH_OUTPUT,
    full.names = TRUE,
    recursive = TRUE,
    pattern=KB_DATA_FILE_AGGREGATED_RESULTS)
  data <- rbindlist(lapply(file_list, fread))
}

kb_read_csv_formated <- function() {
  data <- read.csv(
    KB_DATA_FILE_ALL_RESULTS, 
    header = TRUE)
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

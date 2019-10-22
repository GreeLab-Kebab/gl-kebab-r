#install.packages("data.table")
#install.packages("tidyverse")
library('data.table') #
library('tidyverse') # dplyr
library('stringr') #str_replace_all

source('scripts/io.R')
source("scripts/subject.R")
source('scripts/preprocessing.R')

# Read Data
experiment_results_raw <- experiment_results <- kb_read_csv_raw()

# Keep relevant columns only
experiment_results <- kb_keep_revevant_columns_only(
  data = experiment_results, 
  columns = KB_COLUMNS_KEEP_RAW)

# Clean subject URL and extract optimization level
experiment_results <- kb_remove_text_from_subject_url(data = experiment_results)
experiment_results <- kb_extract_opt_level(data = experiment_results)
experiment_results <- kb_remove_subject_url_duplication(data = experiment_results)

# Obtain subject information
experiment_results <- kb_merge_subject_data(data = experiment_results)

# Set correct tyypes
experiment_results <- kb_set_dataframe_column_types(data = experiment_results)

# Print the count of occurances to find the missing rows
kb_print_count_per_subject_opt_level(data = experiment_results, failed_only = TRUE)

# Store dataframe as csv
kb_write_csv_formated(data = experiment_results)
kb_write_csv_raw(data = experiment_results_raw)

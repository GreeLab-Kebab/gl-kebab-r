##
# Green lab 2019 - Team Kebab
# This R script is used printing some basic descriptive analysis
##

source("scripts/subject.R")
source("scripts/IO.R")

experiment_results  <- kb_read_csv_formated()
subjects_number <- length(levels(experiment_results$subject_id))

print("Descriptive analysis summary")
print("Entire data")

print(summary(experiment_results, maxsum = subjects_number))

for(opt_level in 0:3) {
  data <- kb_get_subject_rows_by_opt_level(experiment_results, opt_level)
  data_summary <-summary(data, maxsum = subjects_number)
  
  print(strsplit(paste('Optimization level', opt_level, '\n'), '\n'))
  print(data_summary)
}


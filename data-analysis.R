FILE_EXPERIMENT_RESULTS <- "data/androidrunner/experiment_all_results.csv"

# Read data and set column types
experiment_results  <- read.csv(FILE_EXPERIMENT_RESULTS, header = TRUE)

experiment_results$subject_url <- as.factor(experiment_results$subject_url)
experiment_results$subject_rank <- as.factor(experiment_results$subject_rank)
experiment_results$subject_id <- as.factor(experiment_results$subject_id)
experiment_results$opt_level <- as.factor(experiment_results$opt_level)
experiment_results$energy_consumed <- as.numeric(as.character(experiment_results$energy_consumed))
experiment_results$load_time <- as.numeric(experiment_results$load_time)



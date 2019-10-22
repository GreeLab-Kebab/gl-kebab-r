FILE_EXPERIMENT_RESULTS <- "data/androidrunner/experiment_all_results.csv"

kb_test_normality <- function(data, name) {
  print(paste("=========[ NORMALITY TEST FOR: '", name, "' ]=========", sep=''))
  qqnorm(data, main=paste(name, "QQ plot"))
  test = shapiro.test(data);
  is_normally_distributed = !(test$p.value < 0.05);
  
  print(test)
  print(paste("evidence for normal distribution: ", is_normally_distributed,sep=''))
  print(paste("=========[ END NORMALITY TEST FOR: '", name, "' ]=========", sep=''))
}

kb_load_data <- function() {
  # Read data and set column types
  experiment_results  <- read.csv(FILE_EXPERIMENT_RESULTS, header = TRUE)
  
  experiment_results$subject_url <- as.factor(experiment_results$subject_url)
  experiment_results$subject_rank <- as.factor(experiment_results$subject_rank)
  experiment_results$subject_id <- as.factor(experiment_results$subject_id)
  experiment_results$opt_level <- as.factor(experiment_results$opt_level)
  experiment_results$energy_consumed <- as.numeric(as.character(experiment_results$energy_consumed))
  experiment_results$load_time <- as.numeric(experiment_results$load_time)
  
  experiment_results
}

data = kb_load_data()

data_opt_0 = data[data$opt_level == 0,]
data_opt_1 = data[data$opt_level == 1,]
data_opt_2 = data[data$opt_level == 2,]
data_opt_3 = data[data$opt_level == 3,]

# Verify normality
par(mfcol=c(4,2))

kb_test_normality(data_opt_0$load_time, "opt 0 - load time")
kb_test_normality(data_opt_1$load_time, "opt 1 - load time")
kb_test_normality(data_opt_2$load_time, "opt 2 - load time")
kb_test_normality(data_opt_3$load_time, "opt 3 - load time")

kb_test_normality(data_opt_0$energy_consumed, "opt 0 - energy consumption")
kb_test_normality(data_opt_1$energy_consumed, "opt 1 - energy consumption")
kb_test_normality(data_opt_2$energy_consumed, "opt 2 - energy consumption")
kb_test_normality(data_opt_3$energy_consumed, "opt 3 - energy consumption")

# Tests


wilcox.test(data_opt_0$load_time, data_opt_1$load_time)
wilcox.test(data_opt_0$load_time, data_opt_2$load_time)
wilcox.test(data_opt_0$load_time, data_opt_3$load_time)

wilcox.test(data_opt_0$energy_consumed, data_opt_1$energy_consumed)
wilcox.test(data_opt_0$energy_consumed, data_opt_2$energy_consumed)
wilcox.test(data_opt_0$energy_consumed, data_opt_3$energy_consumed)


kruskal.test(data$load_time, data$opt_level)
kruskal.test(data$energy_consumed, data$opt_level)



  

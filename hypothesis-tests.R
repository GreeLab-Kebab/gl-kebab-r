##
# Green lab 2019 - Team Kebab
# This R script validate the experiment hypothesis test
##

source('scripts/io.R')
source('scripts/subject.R')
source('scripts/test.R')

data  <- kb_read_csv_formated()

#
# Test Normality
#
columns <- c("load_time", "energy_consumed")

normality_summary <- kb_create_empty_normality_summary_dataframe()
for (opt_level in 0:3) {
  for (column in columns) {
    result <- kb_test_data_normality(data, opt_level, column)
    
    new_row <- kb_get_normality_summary_row(result, opt_level, column)
    normality_summary[nrow(normality_summary) + 1, ] <- new_row
    
    title <- paste("Optimization Level", opt_level, "-", kb_get_column_label(column))
    file_name <- paste("test-shapiro-all-subject-opt-level-", opt_level, "-", column, ".txt", sep = "")
    kb_print_test_result(result, title)
    kb_write_txt_test_result(result, file_name, title)
  }
}
kb_write_csv_test_summary_shapiro(normality_summary)

# 
# Test Hypothesis - Not normal - 4 treatment - Kruskal
#

kruskal_summary <- kb_create_empty_kruskal_summary_dataframe()
for (column in columns) {
  result <- kruskal.test(data[, column], data$opt_level)
  lm_summary <- summary(lm(data[, column]~data$opt_level))
  
  new_row <- kb_get_kruskal_summary_row(result, column)
  kruskal_summary[nrow(kruskal_summary) + 1, ] <- new_row
  
  title_test <- paste("Kruskal in ", kb_get_column_label(column))
  file_name_test <- paste("test-kruskal-all-subject-", column, ".txt", sep = "")
  kb_write_txt_test_result(result, file_name_test, title_test)
  
  title_lm <- paste("Kruskal linear model summary in ", kb_get_column_label(column))
  file_name_lm <- paste("test-kruskal-all-subject-summary-", column, "-lm.txt", sep = "")
  kb_write_txt_test_result(lm_summary, file_name_lm, title_lm)
}

kb_write_csv_test_summary_kruskal(kruskal_summary)

#
# Test Hypothesis - Not normal - 2 treatment - Wilcox 
#


data_opt_0 = data[data$opt_level == 0,]
data_opt_1 = data[data$opt_level == 1,]
data_opt_2 = data[data$opt_level == 2,]
data_opt_3 = data[data$opt_level == 3,]

# Tests


wilcox.test(data_opt_0$load_time, data_opt_1$load_time)
wilcox.test(data_opt_0$load_time, data_opt_2$load_time)
wilcox.test(data_opt_0$load_time, data_opt_3$load_time)

wilcox.test(data_opt_0$energy_consumed, data_opt_1$energy_consumed)
wilcox.test(data_opt_0$energy_consumed, data_opt_2$energy_consumed)
wilcox.test(data_opt_0$energy_consumed, data_opt_3$energy_consumed)


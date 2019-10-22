##
# Green lab 2019 - Team Kebab
# This R script validate the experiment hypothesis test
##

source('scripts/io.R')
source('scripts/subject.R')

kb_test_normality <- function(data, name) {
  print(paste("=========[ NORMALITY TEST FOR: '", name, "' ]=========", sep=''))
  qqnorm(data, main=paste(name, "QQ plot"))
  test = shapiro.test(data);
  is_normally_distributed = !(test$p.value < 0.05);
  
  print(test)
  print(paste("evidence for normal distribution: ", is_normally_distributed,sep=''))
  print(paste("=========[ END NORMALITY TEST FOR: '", name, "' ]=========", sep=''))
}

data  <- kb_read_csv_formated()

data_opt_0 = kb_get_subject_rows_by_opt_level(data, 0)
data_opt_1 = kb_get_subject_rows_by_opt_level(data, 1)
data_opt_2 = kb_get_subject_rows_by_opt_level(data, 2)
data_opt_3 = kb_get_subject_rows_by_opt_level(data, 3)

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





##
# Green lab 2019 - Team Kebab
# This R script validate the experiment hypothesis test
##

source('scripts/io.R')
source('scripts/subject.R')
source('scripts/test.R')

data  <- kb_read_csv_formated()

kb_test_data_normality_all(data)

data_opt_0 = data[data$opt_level == 0,]
data_opt_1 = data[data$opt_level == 1,]
data_opt_2 = data[data$opt_level == 2,]
data_opt_3 = data[data$opt_level == 3,]

# Verify normality
par(mfcol=c(4,2))

# Tests


wilcox.test(data_opt_0$load_time, data_opt_1$load_time)
wilcox.test(data_opt_0$load_time, data_opt_2$load_time)
wilcox.test(data_opt_0$load_time, data_opt_3$load_time)

wilcox.test(data_opt_0$energy_consumed, data_opt_1$energy_consumed)
wilcox.test(data_opt_0$energy_consumed, data_opt_2$energy_consumed)
wilcox.test(data_opt_0$energy_consumed, data_opt_3$energy_consumed)


kruskal.test(data$load_time, data$opt_level)
kruskal.test(data$energy_consumed, data$opt_level)



  

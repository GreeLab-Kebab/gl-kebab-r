##
# Green lab 2019 - Team Kebab
# This R script is used
##

library(ggplot2)

source('scripts/io.R')
source('scripts/subject.R')
source('scripts/preprocessing.R')
source('scripts/test.R')

data  <- kb_read_csv_formated()

data_1 <- data[data$energy_consumed < 100,]
par(mfrow=c(2,1))
#boxplot(data_1$energy_consumed~data_1$opt_level)
ggplot(data_1, aes(x=opt_level, y=energy_consumed)) + geom_violin()
ggplot(data_1, aes(x=opt_level, y=energy_consumed)) + geom_boxplot()


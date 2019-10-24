##
# Green lab 2019 - Team Kebab
# This R script is used for miscelaneos operations and free explorarition
##

install.packages("tidyverse")
library(ggplot2)

source('scripts/io.R')
source('scripts/subject.R')
source('scripts/preprocessing.R')
source('scripts/test.R')

data  <- kb_read_csv_formated()

data_1 <- data[data$energy_consumed < 100,]
par(mfrow=c(2,1))
#boxplot(data_1$energy_consumed~data_1$opt_level)
ggplot(data, aes(x=energy_consumed))
ggplot(data_1, aes(x=opt_level, y=energy_consumed)) + 
  geom_violin(aes(fill = opt_level)) 
ggplot(data_1, aes(x=opt_level, y=energy_consumed)) + 
  geom_violin(aes(fill = opt_level)) + 
  scale_alpha(range=c(0.5,0.75))
ggplot(data_1, aes(x=opt_level, y=energy_consumed)) + geom_boxplot()
plot <- ggplot(data_1, aes(x=opt_level, y=energy_consumed, colour = opt_level)) +
  geom_violin() +
  geom_boxplot(width=0.05)

aspect_ratio <- 2.5
height <- 5
file_name <- "test.png"
ggsave(file_name, plot = plot, height = 7 , width = 7 * aspect_ratio)

ggplot(data, aes(x=energy_consumed, color=opt_level)) +
  geom_histogram(fill="white", alpha=0.5, position="identity")

a =   theme(
  legend.position = "bottom", 
  plot.title = element_text(hjust=0.1))

b =   theme(
  legend.position = "top")
c = modifyList(a, b)

a1 = aes(
  x=opt_level, 
  colour = opt_level
)
b1 =   aes_string(
  y="loadtime", 
)
c1 = modifyList(a1, b1)

data$log_energy = log(data$energy_consumed)
ggplot(data, aes(x=opt_level, y=log_energy)) + 
  geom_violin(aes(fill = opt_level)) 

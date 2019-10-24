##
# Green lab 2019 - Team Kebab
# This R script is used for miscelaneos operations and free explorarition
##

install.packages("tidyverse")
library(ggplot2)

source('scripts/const.R')
source('scripts/io.R')
source('scripts/subject.R')
source('scripts/plot.R')
source('scripts/preprocessing.R')
source('scripts/test.R')

data  <- kb_read_csv_formated()



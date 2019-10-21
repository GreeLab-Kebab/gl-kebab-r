#install.packages("data.table")
#install.packages("tidyverse")
library(data.table) #
library(tidyverse) # dplyr

INDEX_SUBJECT <- 1
INDEX_RUN <- 2
INDEX_ENERGY <- 3
INDEX_TIME <- 4

PATH_OUTPUT <- "data/androidrunner/output"
FILE_AGGREGATED_RESULTS <- "\\Aggregated_Results_Batterystats.csv$"
FILE_ALL_RESULTS <- "data/androidrunner/experiment_all_results.csv"

TEXT_TO_IGNORE <- c(
  "http1042018080", 
  "indexhtml", 
  "homehtml", 
  "internationalhtml", 
  "en-us", 
  "www",
  "owa")

subjects <- data.frame(
  "id" = seq(1,23),
  "URL" = c("myoutubecom", "amazoncom", "linkedincom", "baiducom", "wikipediaorg", "applecom", "outlooklivecom", "awsamazoncom", "officecom", "buzzfeedcom", "nlgodaddycom", "dsalipaycom", "mozillaorg", "okezonecom", "stackoverflowcom", "apacheorg", "theguardiancom", "stackexchangecom", "paypalcomp", "forbescom", "bookingcom", "bbccom", "amazonin"),
  "rank" = c(4, 7, 9, 11, 12, 14, 17, 38, 42, 43, 52, 53, 56, 62, 67, 80, 84, 87, 88, 102, 104, 109, 143))

# Read Data
androidrunner_outputs <- list.files(path = PATH_OUTPUT, 
                                  full.names = TRUE, 
                                  recursive = TRUE, 
                                  pattern=FILE_AGGREGATED_RESULTS)

androidrunner_results <- rbindlist(lapply(androidrunner_outputs,fread))

# Keep relevant columns only
androidrunner_results <- androidrunner_results[, c("subject", "load_time", "energy_consumed")]


# Clean subject URL
for(ignore in TEXT_TO_IGNORE){
  androidrunner_results <- data.frame(lapply(androidrunner_results, 
                                             function(x){
                                               gsub(ignore, "", x)
                                             }))
}

# Extract the optimization level used and clean up subejct URL
androidrunner_results$opt_level <- -1
androidrunner_results$subject_size <- apply(androidrunner_results, 2, nchar)[, INDEX_SUBJECT]
androidrunner_results$opt_level <- substring(androidrunner_results$subject, androidrunner_results$subject_size)
androidrunner_results$subject <- substring(androidrunner_results$subject, 0, androidrunner_results$subject_size - 1)
androidrunner_results$subject <- substring(androidrunner_results$subject, 0, (androidrunner_results$subject_size - 1)/2)
androidrunner_results <- androidrunner_results[, -5]

# Obtain subject information
androidrunner_results$subject <- as.factor(androidrunner_results$subject)
androidrunner_results$subject_id <- subjects$id[match(androidrunner_results$subject, subjects$URL)]
androidrunner_results$subject_rank <- subjects$rank[match(androidrunner_results$subject, subjects$URL)]
colnames(androidrunner_results)[INDEX_SUBJECT] <- "subject_url"

# Set correct tyypes
androidrunner_results$subject_rank <- as.factor(androidrunner_results$subject_rank)
androidrunner_results$subject_id <- as.factor(androidrunner_results$subject_id)
androidrunner_results$opt_level <- as.factor(androidrunner_results$opt_level)
androidrunner_results$energy_consumed <- as.numeric(as.character(androidrunner_results$energy_consumed))
androidrunner_results$load_time <- as.numeric(androidrunner_results$load_time)

# Print the count of occurances to find the missing rows
androidrunner_results %>% 
  group_by(subject_id, opt_level) %>%
  count() %>%
  print(n=100)

# Store dataframe as csv
androidrunner_results <- androidrunner_results[
  order(
    androidrunner_results$subject_id, 
    androidrunner_results$opt_level),]
write.csv(androidrunner_results, file=FILE_ALL_RESULTS)

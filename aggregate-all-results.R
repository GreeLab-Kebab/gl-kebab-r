install.packages("data.table")
library(data.table)

PATH_OUTPUT <- "data/androidrunner/output"
FILE_AGGREGATED_RESULTS <- "\\Aggregated_Results_Batterystats.csv$"

#TEXT_TO_IGNORE <- [
#  
#]

INDEX_URL_PREFIX <- 15
  
androidrunner_outputs <- list.files(path = PATH_OUTPUT, 
                                  full.names = TRUE, 
                                  recursive = TRUE, 
                                  pattern=FILE_AGGREGATED_RESULTS)

androidrunner_results <- rbindlist(lapply(androidrunner_outputs,fread))

androidrunner_results[,2] <- substring(androidrunner_results[,2], INDEX_URL_PREFIX)
androidrunner_results <- data.frame(lapply(androidrunner_results, 
                                           function(x) {
                                             gsub("www", "", x)
                                             gsub("indexhtml", "", x)
                                           }))

androidrunner_results[,2]

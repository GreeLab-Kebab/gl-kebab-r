##
# Green lab 2019 - Team Kebab
# This R script refers to the data related to subjects
##

# 7 subjects were dropped after the team discovered that TAJS analyser didn't worked in them, thus failing criteria of working on Lacuna
#   failed_subjects <- c("forbescom", "dsalipaycom", "baiducom", "outlooklivecom", "okezonecom", "applecom", "linkedincom")
kb_get_subjects_data <- function() {
  subjects_url <- c("myoutubecom", "amazoncom", "linkedincom", "baiducom", "wikipediaorg", "applecom", "outlooklivecom", "awsamazoncom", "officecom", "buzzfeedcom", "nlgodaddycom", "dsalipaycom", "mozillaorg", "okezonecom", "stackoverflowcom", "apacheorg", "theguardiancom", "stackexchangecom", "paypalcomp", "forbescom", "bookingcom", "bbccom", "amazonin")
  subject_ranks <- c(4, 7, 9, 11, 12, 14, 17, 38, 42, 43, 52, 53, 56, 62, 67, 80, 84, 87, 88, 102, 104, 109, 143)
  subjects_ids <- c(1,2,3,3,3,4,4,4,5,6,7,8,8,9,9,10,11,12,13,14,14,15,16)
  
  subjects <- data.frame(
    "id" = subjects_ids,
    "url" = subjects_url,
    "rank" = subject_ranks)
}

kb_set_dataframe_column_types <- function(data, isFormatted = TRUE) {
  data$load_time <- as.numeric(data$load_time)
  data$energy_consumed <- as.numeric(as.character(data$energy_consumed))
  
  if (isFormatted) {
    data$subject_url <- as.factor(data$subject_url)
    data$subject_rank <- as.factor(data$subject_rank)
    data$subject_id <- as.factor(data$subject_id)
    data$opt_level <- as.factor(data$opt_level)
    data$treatment <- as.factor(data$treatment)
  } else {
    data$subject <- as.factor(data$subject)
  }
  
  data
}

kb_get_subject_rows_by_opt_level <- function(data, opt_lvl) {
  data[data$opt_level == opt_lvl,]
}

kb_get_subject_rows_by_id <- function(data, subject_id) {
  data[data$subject_id == subject_id,]
}

kb_get_subject_by_id <- function(subject_id) {
  subjects <- kb_get_subjects_data()
  
  subjects[subject_id,]
}

kb_get_treatment_id <- function(opt_level){
  switch(opt_level +1, 
         "1" = "JSoriginal", 
         "2" = "JSopt1",
         "3" = "JSopt2",
         "4" = "JSopt3",
         "NA")
}

kb_get_opt_level <- function(treatment){
  return <- switch(treatment, 
         "JSoriginal" = 0, 
         "JSopt1" = 1,
         "JSopt2" = 2,
         "JSopt3" = 3,
         "NA")
  return
}

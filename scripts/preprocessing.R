##
# Green lab 2019 - Team Kebab
# This R script refers to the the operations to clean up and format the data
##

source("scripts/subject.R")

KB_COLUMNS_KEEP_RAW <- c(
  "subject", 
  "load_time", 
  "energy_consumed")

KB_COLUMNS_KEEP_FORMATED <- c(
  "subject_id", 
  "subject_rank", 
  "subject_url", 
  "opt_level", 
  "load_time", 
  "energy_consumed")

kb_keep_revevant_columns_only <- function(data, columns){
  data[, ..columns]
}

kb_remove_text_from_subject_url <- function(data) {
  text_to_ignore <- c("http1042018080", "indexhtml", "homehtml", "internationalhtml", "en-us", "www", "owa")
  
  for(ignore in text_to_ignore){
    data$subject = str_replace_all(data$subject, ignore, "")
  }
  
  data
}

kb_remove_subject_url_duplication <- function(data) {
  data$url_len <- apply(data, 2, nchar)[, "subject"]
  data$subject <- substring(data$subject, 0, (data$url_len)/2)
  data <- data[, -"url_len"]
}

kb_extract_opt_level <- function(data) {
  data$opt_level <- -1
  
  data$url_len <- apply(data, 2, nchar)[, "subject"]
  data$opt_level <- substring(data$subject, data$url_len)
  data$subject <- substring(data$subject, 0, data$url_len - 1)
  
  data <- data[, -"url_len"]
}

kb_extract_treatment_id <- function(data) {
  data$treatment <- ifelse(
    data$opt_level == "0", "JSoriginal",
    ifelse(data$opt_level == "1", "JSopt1",
           ifelse(data$opt_level == "2", "JSopt2",
                  ifelse(data$opt_level == "3", "JSopt3", "NA"))))
  data
}

kb_merge_subject_data <- function(data) {
  subjects <- kb_get_subjects_data()
  idx_subject <- grep("subject", names(data))
  
  data$subject <- as.factor(data$subject)
  data$subject_id <- subjects$id[match(data$subject, subjects$url)]
  data$subject_rank <- subjects$rank[match(data$subject, subjects$url)]
  colnames(data)[idx_subject] <- "subject_url"
  
  data
}

kb_remove_subjects_in_which_tajs_failed <- function(data) {
  failed_subjects <- c("forbescom", "dsalipaycom", "baiducom", "outlooklivecom", "okezonecom", "applecom", "linkedincom")
  column_names <- names(data)
  columns_length <- length(column_names)
  
  new_data <- data
  for(subject in failed_subjects) {
    new_data <- new_data[new_data$subject_url != subject]
  }
  
  new_data
}


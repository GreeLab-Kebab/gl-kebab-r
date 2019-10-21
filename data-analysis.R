FILE_EXPERIMENT_RESULTS <- "data/androidrunner/experiment_all_results.csv"

INDEX_SUBJECT_ID = 5
INDEX_SUBJECT_URL = 1
INDEX_SUBJECT_RANK = 6
INDEX_LOAD_TIME = 2
INDEX_ENERGY = 3
INDEX_OPT_LEVEL = 4

PATH_PLOT_BOXPLOT = "plots/boxplots/"

subjects <- c("myoutubecom", "amazoncom", "linkedincom", "baiducom", "wikipediaorg", "applecom", "outlooklivecom", "awsamazoncom", "officecom", "buzzfeedcom", "nlgodaddycom", "dsalipaycom", "mozillaorg", "okezonecom", "stackoverflowcom", "apacheorg", "theguardiancom", "stackexchangecom", "paypalcomp", "forbescom", "bookingcom", "bbccom", "amazonin")

# Read data and set column types
experiment_results  <- read.csv(FILE_EXPERIMENT_RESULTS, header = TRUE)

experiment_results$subject_url <- as.factor(experiment_results$subject_url)
experiment_results$subject_rank <- as.factor(experiment_results$subject_rank)
experiment_results$subject_id <- as.factor(experiment_results$subject_id)
experiment_results$opt_level <- as.factor(experiment_results$opt_level)
experiment_results$energy_consumed <- as.numeric(as.character(experiment_results$energy_consumed))
experiment_results$load_time <- as.numeric(experiment_results$load_time)

# Generate boxplots
for (subject_id in 1:length(subjects)){
  subject_data <- experiment_results[experiment_results$subject_id == subject_id,]
  boxplot_title <- paste("Boxplot for", subjects[subject_id], "- ID", subject_id, "- Rank", subject_data[1,INDEX_SUBJECT_RANK])
  file_name <- paste(PATH_PLOT_BOXPLOT, "boxplot-id-", subject_id, "-rank-", subject_data[1,INDEX_SUBJECT_RANK], "-url-", subjects[subject_id],".png", sep="")
  label_x <- "Optimization Level"
  label_y_time <- "Load Time (ms)"
  label_y_energy <- "Energy Consumption (J)"
  
  png(file_name, units="px", width=640, height=360)
  par(mfrow=c(1,2))
  boxplot(data = subject_data, 
          load_time ~ opt_level, 
          xlab = label_x,
          ylab = label_y_time)
  boxplot(data = subject_data, 
          energy_consumed ~ opt_level, 
          xlab = label_x,
          ylab = label_y_energy)
  title(boxplot_title, line = -2.5, outer = TRUE)
  dev.off()
}
par(mfrow=c(1,1))

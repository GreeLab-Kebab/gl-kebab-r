##
# Green lab 2019 - Team Kebab
# This R script is a central place to define constants
##

KB_FIGURE_PATH_BOXPLOT <- "plots/boxplots/"
KB_FIGURE_PATH_HISTOGRAM <- "plots/histograms/"
KB_FIGURE_PATH_QQ <- "plots/qq-plots/"
KB_FIGURE_PATH_VIOLIN <- "plots/violin/"
KB_FIGURE_PATH_FREQ_POLY <- "plots/freqpoly/"

KB_LBL_OPT_LVL <- "Optimization Level"
KB_LBL_TIME <- "Load Time (ms)"
KB_LBL_ENERGY <- "Energy Consumption (J)"

KB_TITLE_PLOT_TIME_OPT_LEVEL <- paste(KB_LBL_TIME, "x", KB_LBL_OPT_LVL)
KB_TITLE_PLOT_ENERGY_OPT_LEVEL <- paste(KB_LBL_ENERGY, "x", KB_LBL_OPT_LVL)

# DEPRECIATED
KB_PLOT_HEIGHT_12 <- 360
KB_PLOT_WIDTH_12 <- 640
KB_PLOT_HEIGHT <- 5
KB_PLOT_RATIO <- 1.5
KB_PLOT_ALPHA_FILL_RATIO <- 0.1

KB_CSV_PATH_OUTPUT <- "data/androidrunner/output"
KB_CSV_FILE_AGGREGATED_RESULTS <- "\\Aggregated_Results_Batterystats.csv$"
KB_CSV_FILE_ALL_RESULTS_FORMATTED_ALL <- "data/androidrunner/experiment_all_results.csv"
KB_CSV_FILE_ALL_RESULTS_FORMATTED <- "data/androidrunner/experiment_sucess_results.csv"
KB_CSV_FILE_ALL_RESULTS_RAW <- "data/androidrunner/experiment_all_results_raw.csv"

KB_CSV_FILE_TEST_SUMMARY_SHAPIRO <- "data/tests/test-shapiro-all-subjects-summart.csv"
KB_CSV_FILE_TEST_SUMMARY_KRUSKAL <- "data/tests/test-kruskal-all-subjects-summart.csv"
KB_CSV_FILE_TEST_SUMMARY_WILCOX <- "data/tests/test-wilcox-all-subjects-summart.csv"

KB_TXT_PATH_TEST <- "data/tests/"

KB_RUNS_NUMBER <- 10
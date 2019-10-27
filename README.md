# Green Lab - Kebab Team - R Package

This repository is part of the project ``An Empirical Analysis of JavaScript Dead Code in the Wild``, described in [Kebab Team  Base Repository](https://github.com/GreeLab-Kebab/gl-kebab). This repository contains the R package responsible for the experiment design and data analysis. 


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for experiment replication purpose.

### Prerequisites

#### Tools

- [R project](https://www.r-project.org/)
- [R Studio IDE](https://rstudio.com/) (Optional)

#### R Libraries

- [Tidyverse &ndash; ggplot2](https://ggplot2.tidyverse.org/): Provides neat plots, with a more appealing visual and more options to configurate.
- [Data Table](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html): Provides more versatile operations with dataframes.

### Installation

After installing the tools, you can open and run the scripts in R Studio.

### Scripts

The data analysis was split in scripts by domain to improve readability. There are 5 main scripts with additional 6 helper scripts with auxiliary functions.

#### Main files

- [Aggregate all results](aggregate-all-results.R): Process the raw results from Android Runner located at `data/androidrunner/output`. It searches the directory for all CSV files in the format `Aggregated_Results_Batterystats.csv`. Unnecessary columns are dropped and new columns are created with information about the treatment and subject. The formating results are saved at `data/androidrunner`. All other scripts use the formatted CSV resulted from this script.
- [Descriptive Analysis](descriptive-analysis.R): Provide basic descriptive static of the data.
- [Generate Plots](generate-plots.R): Provide all plots used in the project and the data analysis. ALl generated plots are saved at `plots/`
- [Hypothesis Test](hypothesis-tests.R): Provide all tests used in this experiment: Shapiro and Kruskal. All results are saved at `data\tests\`, including a CSV containing a summary of the results. 
- [Sandbox](sandbox.R): Script used for open tests and exploration of the data. To make git stop tracking this file, run `git rm --cached sandbox.R`

#### Library scripts

- [Constants](scripts/const.R): Defines all constants used in the scripts.
- [IO](scripts/io.R): Defines all access to read and write data in the file system or the command line.
- [Plots](scripts/plot.R): Wraps ggplot2 functions with configurations relevant for this project.
- [Preprocessing](scripts/preprocessing.R): Wraps functions for the preprocessing phase, keeping the main file clean and clear.
- [Subject](scripts/subject.R): Provides information about subjects.
- [Test](scripts/test.R): Wraps functions for the hypothesis tests.

## Authors 

- *Azim AFroozeh* &ndash; [azimafroozeh](https://github.com/azimafroozeh);
- *Saliha Tabbassum* &ndash; [saalihairshad](https://github.com/saalihairshad); 
- *Stan Swanborn* &ndash; [StanSwanborn](https://github.com/StanSwanborn);
- *Thijmen Kurk* &ndash; [ThijmenKurk](https://github.com/ThijmenKurk);
- *Wesley Shann* &ndash; [sshann](https://github.com/sshann);

## License

This project is licensed under the GLP-3.0 License - see the [LICENSE](LICENSE) file for details.


# Package "xtable" is used to generate a latex table from the dataframe
# This package need to be installed and loaded.
# Uncomment the next line to install the package
# install.packages("xtable")
library(xtable)

# Variables
# df              Paired comparison table
# df$ID           ID of the the mobile web app
# df$treatment1   Treatment 1 - Original mobile web app
# df$treatment2   Treatment 2 - Mobile web app after JS removal
# treatmentOrder  Defines which orders are available to apply the treatments

# A new dataframe is generated with a column ID and 30 rows from 1 to 30
# The order in which the treatments are applied is randomly generated for each mobile web app
# Export the dataframe to a latex table

df <- data.frame(ID=c(1:30))
treatmentOrder <- c("1st","2sd")
df$treatment1 <- as.factor(sample(treatmentOrder, nrow(df), TRUE))
df$treatment2 <- as.factor(ifelse(df$treatment1 == "1st", "2sd", "1st"))

print(xtable(df, caption = "Paired Comparison Design.", label="tab:execution:experiment-design"), include.rownames=FALSE)

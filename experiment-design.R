# install.packages("xtable")
library(xtable)

df <- data.frame(ID=c(1:30))
treatments <- c("1st","2sd")
df$treatment1 <- as.factor(sample(treatments, nrow(df), TRUE))
df$treatment2 <- as.factor(ifelse(df$treatment1 == "1st", "2sd", "1st"))


print(xtable(df, caption = "Paired Comparison Design.", label="tab:execution:experiment-design"), include.rownames=FALSE)

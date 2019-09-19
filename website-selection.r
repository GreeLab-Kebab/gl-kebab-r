df <- read.table("data/top-1m.csv", header = FALSE, sep=",")
elements <- 30
sample <- df[sample(nrow(df), 30, replace = FALSE, prob = NULL),]
write.table(sample, "data/sample.csv", row.names = FALSE, col.names = FALSE, sep=",")


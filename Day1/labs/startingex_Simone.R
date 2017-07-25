## Looks OK, use Rmd to show and give some text for answers.
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv" 
download(url, destfile=filename)
data <- read.csv(filename)
data[12,2]
data$Bodyweight[11]
length(data$Diet)
mean(data[c(13:20),2])
set.seed(1)
data[sample(13:24,1),2]

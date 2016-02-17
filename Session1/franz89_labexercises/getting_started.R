library(downloader)

url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv"
download(url, destfile=filename)

data <- utils::read.csv(filename) # 1.1
summary(data)
data$Bodyweight # 1.2, does not make sense, but it could be interpreted in this way!
# data[,2]

data[12,2] # 2

data$Bodyweight # 3.1
data$Bodyweight[11] # 3.2

length(data$Bodyweight) # 4

diet.hf <- factor(data$Diet) == "hf"
mean(data[diet.hf==T,]$Bodyweight) # 5
# mean(data[13:24,]$Bodyweight) # 5

set.seed(1); data[base::sample(13:24, size=1),] # 6

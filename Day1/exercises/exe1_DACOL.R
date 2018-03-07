library(dplyr)
library(RCurl)

###--------------1--------------###

url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
x <- getURL(url)
csv.file <- read.csv(textConnection(x))
class(csv.file)

###--------------2--------------###

primates <- csv.file %>%
  filter(order == "Primates")
nrow(primates)

###--------------3--------------###

class(primates)

###--------------4--------------###

sleep.total <- primates %>%
  select(sleep_total)

###--------------5--------------###

mean.sleep.total <- mean(unlist(sleep.total))

###--------------6--------------###

final.summarise <- csv.file %>%
  filter(order=="Primates") %>%
  summarise(mean.sleep.total)

###RANDOM VARIABLES###

library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- basename(url)
download(url, destfile=filename)
x <- unlist(read.csv(filename))

###--------------1--------------###

average <- mean(x)

###--------------2--------------###

set.seed(1)
sample1 <- rnorm(5)
average.sample1 <- mean(sample1)
abs.average1 <- abs(average - average.sample1)

###--------------3--------------###

set.seed(5)
sample2 <- rnorm(5)
average.sample2 <- mean(sample2)
abs.average2 <- abs(average - average.sample2)

###--------------4--------------###

# Because the average of the samples is a random variable.

###--------------5--------------###

set.seed(1)
samples.1.1000.5 <- matrix(nrow = 1000)
for (i in (1:1000)) {
  samples.1.1000.5[i] <- mean(sample(x, 5))
}
percent.1.1000.5 <- sum(samples.1.1000.5 > average + 1) / 1000

###--------------6--------------###

set.seed(1)
samples.1.10000.5 <- matrix(nrow = 10000)
for (i in (1:10000)) {
  samples.1.10000.5[i] <- mean(sample(x, 5))
}
percent.1.10000.5 <- sum(samples.1.10000.5 > average + 1) / 10000

###--------------7--------------###

set.seed(1)
samples.1.1000.50 <- matrix(nrow = 1000)
for (i in (1:1000)) {
  samples.1.1000.50[i] <- mean(sample(x, 50))
}
percent.1.1000.50 <- sum(samples.1.1000.50 > average + 1) / 1000

###--------------8--------------###

hist(samples.1.1000.5, col = "grey")
hist(samples.1.1000.50, col = "grey")
#They both look roughly normal, but with a sample size of 50 the spread is smaller.

###--------------9--------------###

last_set <- sum(samples.1.1000.50 >= 23 & samples.1.1000.50 <= 25) / 1000

###--------------10--------------###

distro <- rnorm(1000, 23.9, 0.43)
last_set.1 <- sum(distro >= 23 & distro <= 25) / 1000

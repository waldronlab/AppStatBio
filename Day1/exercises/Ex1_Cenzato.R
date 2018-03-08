library(ggplot2)
library(dplyr)

#------------------------dplyrExercises--------------------------------------#
#------------------------------Ex1-------------------------------------------#

data <- msleep
head(data)
class(data)

#------------------------------Ex2-------------------------------------------#

primates <- data %>% 
  filter(order == "Primates") 
nrow(primates)

#------------------------------Ex3-------------------------------------------#

primates
class(primates)

#------------------------------Ex4-------------------------------------------#

primates <- data %>% 
  filter(order == "Primates") %>% 
  select(sleep_total)
primates
class(primates)

#------------------------------Ex5-------------------------------------------#

mean(unlist(primates))

#------------------------------Ex6-------------------------------------------#

primates <- data %>% 
  filter(order == "Primates") %>% 
  summarise(sleep_total = mean(sleep_total))
primates
class(primates)

#------------------------RandomVariablesExercises--------------------------------------#
#------------------------------Ex1-------------------------------------------#

library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- basename(url)
download(url, destfile=filename)
x <- unlist( read.csv(filename) )

mean(x)

#------------------------------Ex2-------------------------------------------#
set.seed(1)
samples <- x[sample(1:length(x),size=5,replace=FALSE)]
abs(mean(samples)-mean(x))

#------------------------------Ex3-------------------------------------------#
set.seed(5)
samples <- x[sample(1:length(x),size=5,replace=FALSE)]
abs(mean(samples)-mean(x))

#------------------------------Ex4-------------------------------------------#
#C: because the average of the samples is a random variable

#------------------------------Ex5-------------------------------------------#
set.seed(1)
nite = 1000
ssize = 5
averages <- rep(0,nite)
for(i in 1:nite){
  samples <- x[sample(1:length(x),size=ssize,replace=FALSE)]
  averages[i] <- mean(samples)
}
(length(which(averages > mean(x)+1))*100)/length(averages)
average5 <- averages

#------------------------------Ex6-------------------------------------------#
set.seed(1)
nite = 10000
ssize = 5
averages <- rep(0,nite)
for(i in 1:nite){
  samples <- x[sample(1:length(x),size=ssize,replace=FALSE)]
  averages[i] <- mean(samples)
}
(length(which(averages > mean(x)+1))*100)/length(averages)

#------------------------------Ex7-------------------------------------------#
set.seed(1)
nite = 1000
ssize = 50
averages <- rep(0,nite)
for(i in 1:nite){
  samples <- x[sample(1:length(x),size=ssize,replace=FALSE)]
  averages[i] <- mean(samples)
}
(length(which(averages > mean(x)+1))*100)/length(averages)
average50 <- averages
  
#------------------------------Ex8-------------------------------------------#
hist(average5, main="Averages sample-size = 5, distribution", xlab="Averages")
hist(average50, main="Averages sample-size = 50, distribution", xlab="Averages")

#B:They both look roughly normal, but with a sample size of 50 the spread is smaller.

#------------------------------Ex9-------------------------------------------#
(length(which(average50 > 23 & average50 < 25))*100)/length(averages)

#------------------------------Ex10-------------------------------------------#
norm <- rnorm(1000,mean=23.9,sd=0.43)
(length(which(norm > 23 & norm < 25))*100)/length(norm)
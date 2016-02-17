########### Female Mice Weights  ##################

library("dplyr")

library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv" 
download(url, destfile=filename)

#1. Read the file
dataset <- read.csv(filename) 

#2. To see the 12th entry of the weight column (2nd column)
dataset[12,2] 

#3. To vectorize the column Bodyweight and to later extract the entry of the 11th row
dataset$Bodyweight[11] 

#4. To count how many mice are involved in the study
length(dataset$Bodyweight) 

#5. What rows are associated with the high fat or hf diet? Then use the mean function to compute the average weight of these mice.
highfat <- dataset$Diet == "hf" 
mean(dataset[highfat == TRUE,]$Bodyweight) 

#6. Take a random sample of size 1 from the numbers 13 to 24 and report back the weight of the mouse represented by that row
set.seed(1);row <- sample(13:24, size=1)
dataset$Bodyweight[row]

# alternative   set.seed(1);dataset$Bodyweight[sample(13:24, size=1)]

# alternative   set.seed(1);dataset[sample(13:24, size=1),]



########### Sleep ##################
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- "msleep_ggplot2.csv" 
download(url, destfile=filename)

#1. Read the file and check the class
sleepdata <- read.csv(filename) 
class(sleepdata)

#2. Filter primates and count how many Primates are present
primates <- dplyr::filter(sleepdata, sleepdata$order == "Primates")
nrow(primates)

#3. What is the class of the object?
class(primates)

#4. Use select to extract the sleep_total for the primates
dplyr::select(primates, sleep_total)

# alternative   dplyr::filter(sleepdata, sleepdata$order == "Primates") %>% 
#                 dplyr::select(sleep_total)

#5. Calculate the mean of the sleep_total
sleepprim <- unlist(dplyr::select(primates, sleep_total))
mean(sleepprim)

#6. Calculate the mean by using dplyr::summarise
dplyr::summarise(primates, mean(primates$sleep_total))



########### Random variables ##################

library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- basename(url)
download(url, destfile=filename)
x <- unlist( read.csv(filename) )

#1. calculate the average weight
mean.mice <- mean(x)

#2. absolute value of the difference between the average of the sample and the average of all the values
set.seed(1);random1 <- sample(x, size=5)
abs.diff1 <- abs(mean(random1)-mean.mice)

#3. absolute value of the difference between the average of the sample and the average of all the values
set.seed(5);random5 <- sample(x, size=5)
abs.diff5 <- abs(mean(random5)-mean.mice)

#4. Why are the answers from 2 and 3 different? C) Because the average of the samples is a random variable

#5. What percent of these 1,000 averages are more than 1 ounce away from the average of x ?
set.seed(1);
mean.1000 <- c()
counter1 <- 0
for(w in 1:1000){
  mean.local1 <- mean(sample(x, size=5))
  mean.1000[w] <- mean.local1
  if(abs(mean.local1-mean.mice)>1) counter1 <- counter1+1
  }
perc.diff1 <- (counter1*100)/1000
perc.diff1

#6. What percent of these 10,000 averages are more than 1 ounce away from the average of x ?
set.seed(1);
mean.10000 <- c()
counter2 <- 0
for(w in 1:10000){
  mean.local2 <- mean(sample(x, size=5))
  mean.10000[w] <- mean.local2
  if(abs(mean.local2-mean.mice)>1) counter2 <- counter2+1
}
perc.diff2 <- (counter2*100)/10000
perc.diff2

#7. Enlarge sample size to 50 mice
set.seed(1);
mean.50 <- c()
counter3 <- 0
for(w in 1:10000){
  mean.local3 <- mean(sample(x, size=50))
  mean.50[w] <- mean.local3
  if(abs(mean.local3-mean.mice)>1) counter3 <- counter3+1
}
perc.diff3 <- (counter3*100)/10000
perc.diff3

#8. Histogram
hist(mean.10000)
hist(mean.50)
# B) They both look roughly normal, but with a sample size of 50 the spread is smaller.

#9. For the averages obtained from a sample size of 50, what percent are between 23 and 25?
set.seed(1);
mean.50 <- c()
counter4 <- 0
for(w in 1:10000){
  mean.local3 <- mean(sample(x, size=50))
  mean.50[w] <- mean.local3
  if(mean.local3>23 && mean.local3<25) counter4 <- counter4+1
}
perc.diff4 <- (counter4*100)/10000
perc.diff4

#10. Now ask the same question of a normal distribution with average 23.9 and standard deviation 0.43
normal.dist <- rnorm(n=10000, mean = 23.9, sd = 0.43)

set.seed(1);
mean.norm <- c()
counter5 <- 0
for(w in 1:10000){
  mean.local5 <- mean(sample(normal.dist, size=50))
  mean.norm[w] <- mean.local5
  if(mean.local5>23 && mean.local5<25) counter5 <- counter5+1
}
perc.diff.norm <- (counter5*100)/10000
perc.diff.norm
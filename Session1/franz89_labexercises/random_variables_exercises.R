library(downloader)

url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- basename(url)
download(url, destfile=filename)
x <- unlist(read.csv(filename))

#1
average.x <- mean(x)

#2
set.seed(1); rnd_smp <- sample(x, size=5)
abs(average - mean(rnd_smp))

#3
set.seed(5); rnd_smp <- sample(x, size=5)
abs(average - mean(rnd_smp))

#4
## answer: C) Because the average of the samples is a random variable.

#5
averages.5.1000 <- 0
set.seed(1)
for(i in 1:1000) {
  averages.5.1000[i] <- mean(sample(x, size=5))
}
sum(abs(averages.5.1000 - average.x) >= 1)/1000

#6
averages.5.10000 <- 0
set.seed(1)
for(i in 1:10000) {
  averages.5.10000[i] <- mean(sample(x, size=5))
}
sum(abs(averages.5.10000 - average.x) >= 1)/10000

#7
averages.50.1000 <- 0
set.seed(1)
for(i in 1:1000) {
  averages.50.1000[i] <- mean(sample(x, size=50))
}
sum(abs(averages.50.1000 - average.x) >= 1)/1000

#8
hist(averages.5.1000)
hist(averages.50.1000)
## answer: B) They both look roughly normal, but with a sample size of 50 the spread i smaller.

#9
ge.23 <- averages.50.1000 >= 23
le.25 <- averages.50.1000 <= 25
sum(ge.23*le.25) / length(ge.23)

#10
synthetic_normal_distribution <- rnorm(length(ge.23), mean=23.9, sd=0.43)
s.ge.23 <- synthetic_normal_distribution >= 23
s.le.25 <- synthetic_normal_distribution <= 25
sum(s.ge.23*s.le.25) / length(s.ge.23)

#RANDOM VARIABLES EXERCISE

library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- basename(url)
download(url, destfile=filename)
x <- unlist( read.csv(filename) )
Here x represents the weights for the entire population.

#What is the average of these weights?
mean(x)
[1] 23.89338

#After setting the seed at 1, set.seed(1) take a random sample of size 5. What is the absolute value (use abs) of the difference between the average of the sample and the average of all the values?
set.seed(1)
a<-rnorm(5)
[1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078

mean(a)
[1] 0.1292699

abs(mean(x)-mean(a))
[1] 23.76411


#After setting the seed at 5, set.seed(5) take a random sample of size 5. What is the absolute value of the difference between the average of the sample and the average of all the values?
set.seed(5)
b<-rnorm(5)

mean(b)
[1] 0.2139191

abs(mean(x)-mean(b))
[1] 23.67946


#Why are the answers from 2 and 3 different?
#A) Because we made a coding mistake.
#B) Because the average of the x is random.
C) Because the average of the samples is a random variable.
#D) All of the above.



#Set the seed at 1, then using a for-loop take a random sample of 5 mice 1,000 times. Save these averages. What percent of these 1,000 averages are more than 1 ounce away from the average of x ?
set.seed(1)
mean.mice <- vector("numeric",1000)

for(i in seq(from= 1, to=1000)) {
  X <- sample(x,5)
  mean.mice[i] <- mean(X)
}

mean( abs( mean.mice - mean(x) ) > 1)

#We are now going to increase the number of times we redo the sample from 1,000 to 10,000. Set the seed at 1, then using a for-loop take a random sample of 5 mice 10,000 times. Save these averages. What percent of these 10,000 averages are more than 1 ounce away from the average of x ?

set.seed(1)
mean.mice2 <- vector("numeric",10000)

for(i in seq(from=1000, to=10000)) {
  X <- sample(x,5)
  mean.mice2[i] <- mean(X)
}

mean( abs( mean.mice2 - mean(x) ) > 1)


#Note that the answers to 4 and 5 barely changed. This is expected. The way we think about the random value distributions is as the distribution of the list of values obtained if we repeated the experiment an infinite number of times. On a computer, we can’t perform an infinite number of iterations so instead, for our examples, we consider 1,000 to be large enough, thus 10,000 is as well. Now if instead we change the sample size, then we change the random variable and thus its distribution.

#Set the seed at 1, then using a for-loop take a random sample of 50 mice 1,000 times. Save these averages. What percent of these 1,000 averages are more than 1 ounce away from the average of x ?
set.seed(1)
mean.mice3 <- vector("numeric",1000)

for(i in seq(from=1, to=1000)) {
  X <- sample(x,50)
  mean.mice3[i] <- mean(X)
}

mean( abs( mean.mice3 - mean(x) ) > 1)

hist(mean.mice)
hist(mean.mice3)


#Use a histogram to “look” at the distribution of averages we get with a sample size of 5 and a sample size of 50. How would you say they differ?
#A) They are actually the same.
B) They both look roughly normal, but with a sample size of 50 the spread is smaller.
#C) They both look roughly normal, but with a sample size of 50 the spread is larger.
#D) The second distribution does not look normal at all.



#For the last set of averages, the ones obtained from a sample size of 50, what percent are between 23 and 25?

mean( abs( mean.mice3 - mean(x) ) < 25 & abs( mean.mice3 - mean(x) ) > 23 )


#Now ask the same question of a normal distribution with average 23.9 and standard deviation 0.43.
#The answer to 9 and 10 were very similar. This is because we can approximate the distribution of the sample average with a normal distribution. We will learn more about the reason for this next.
c<-rnorm(1000, 23.9, 0.43)
hist(c)
mean( abs( c - mean(x) ) < 25 & abs( c - mean(x) ) > 23 )



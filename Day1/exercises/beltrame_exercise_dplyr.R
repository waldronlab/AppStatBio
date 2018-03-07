# Lecture 1 by Levi Waldron - 06/03/18  
#-----------------------------------------

# Giovanni Alberto Beltrame

# EXERCISE: dplyr 

library(dplyr)
library(ggplot2)
library(tidyverse)

# 1.  Read in the msleep_ggplot2.csv file with the function read.csv and use
#     the function class to determine what type of object is returned.

msleep <- read.csv("https://github.com/genomicsclass/dagdata/blob/master/inst/extdata/msleep_ggplot2.csv")
data(msleep)
summary(msleep)
class(msleep)

# 2.  Now use the filter function to select only the primates. How many animals in the table are primates? 
#     Hint: the nrow function gives you the number of rows of a data frame or matrix.

prim <- msleep %>% 
    filter(order == "Primates")
nrow(prim)

# 3.  What is the class of the object you obtain after subsetting the table to only include primates?

class(prim)
  
# 4.  Now use the select function to extract the sleep (total) for the primates. What class is this object? 
#     Hint: use %>% to pipe the results of the filter function to select.

sleep <- prim %>%
    select(sleep_total)
class(sleep)

# 5.  Now we want to calculate the average amount of sleep for primates (the average of the numbers computed above). 
#     One challenge is that the mean function requires a vector so, if we simply apply it to the output above, we get an error. 
#     Look at the help file for unlist and use it to compute the desired average.

avg <- mean(unlist(sleep))

# 6.  For the last exercise, we could also use the dplyr summarize function.
#     We have not introduced this function, but you can read the help file and repeat exercise 5, this time using just 
#     filter and summarize to get the answer.

avg2 <- prim %>% 
    select(sleep_total) %>%
    filter(!is.na(sleep_total)) %>%
    summarize(mean_sleep = mean(sleep_total))



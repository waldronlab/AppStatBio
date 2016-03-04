library(downloader)
library(dplyr)

url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- "msleep_ggplot2.csv"
download(url, destfile=filename)

#1
dat <- read.csv(filename)
class(data)

#2
data.primates <- dplyr::filter(dat, order=="Primates")
nrow(data.primates)

#3
class(data.primates)

#4
# data.primates.sleep_total <- dplyr::select(data.primates, sleep_total)
class(data.primates.sleep_total)

dplyr::filter(data, data$order=="Primates") %>%
  dplyr::select(sleep_total)

#5
mean(unlist(dplyr::filter(data, data$order=="Primates") %>%
       dplyr::select(sleep_total)))

#6
summarize(dplyr::filter(data, data$order=="Primates"), mean(sleep_total))

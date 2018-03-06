## ---- eval = FALSE-------------------------------------------------------
## source("https://bioconductor.org/biocLite.R")
## packages <- c("packagename", "githubuser/repository", "biopackage")
## BiocInstaller::biocLite(packages)

## ------------------------------------------------------------------------
set.seed(1)
rnorm(5)

## ------------------------------------------------------------------------
sample( 1:5 )

## ------------------------------------------------------------------------
1:3 %in% 3

## ------------------------------------------------------------------------
c("yes", "no")

## ------------------------------------------------------------------------
factor(c("yes", "no"))

## ------------------------------------------------------------------------
c(NA, NaN, -Inf, Inf)

## ------------------------------------------------------------------------
matrix(1:9, nrow = 3)

## ------------------------------------------------------------------------
measurements <- c( 1.3, 1.6, 3.2, 9.8, 10.2 )
parents <- c( "Parent1.name", "Parent2.name" )
my.list <- list( measurements, parents)
my.list

## ------------------------------------------------------------------------
x <- 11:16
y <- seq(0,1,.2)
z <- c( "one", "two", "three", "four", "five", "six" )
a <- factor( z )
my.df <- data.frame(x,y,z,a, stringsAsFactors = FALSE)

## ------------------------------------------------------------------------
suppressPackageStartupMessages(library(S4Vectors))
df <- DataFrame(var1 = Rle(c("a", "a", "b")),
          var2 = 1:3)
metadata(df) <- list(father="Levi is my father")
df

## ------------------------------------------------------------------------
List(my.list)
str(List(my.list))

## ------------------------------------------------------------------------
suppressPackageStartupMessages(library(IRanges))
IntegerList(var1=1:26, var2=1:100)
CharacterList(var1=letters[1:100], var2=LETTERS[1:26])
LogicalList(var1=1:100 %in% 5, var2=1:100 %% 2)

## ------------------------------------------------------------------------
suppressPackageStartupMessages(library(Biostrings))
bstring = BString("I am a BString object")
bstring

## ------------------------------------------------------------------------
dnastring = DNAString("TTGAAA-CTC-N")
dnastring
str(dnastring)

## ------------------------------------------------------------------------
alphabetFrequency(dnastring, baseOnly=TRUE, as.prob=TRUE)

## ---- message=FALSE------------------------------------------------------
library(nycflights13)
library(dplyr)
delays <- flights %>% 
  filter(!is.na(dep_delay)) %>%
  group_by(year, month, day, hour) %>%
  summarise(delay = mean(dep_delay), n = n()) %>%
  filter(n > 10)

## ------------------------------------------------------------------------
hist(delays$delay, main="Mean hourly delay", xlab="Delay (hours)")

## ---- echo=FALSE---------------------------------------------------------
x=rnorm(100)
res=hist(x, main="Standard Normal Distribution\n mean 0, std. dev. 1", prob=TRUE)
xdens = seq(min(res$breaks), max(res$breaks), by=0.01)
lines(xdens, dnorm(xdens))

## ---- echo=FALSE---------------------------------------------------------
x=rpois(100, lambda=2)
res=hist(x, main="Poisson Distribution", prob=FALSE, col="lightgrey",
     breaks=seq(-0.5, round(max(x))+0.5, by=0.5))
xdens = seq(min(x), max(x), by=1)
lines(xdens, length(x) * dpois(xdens, lambda=2), lw=2)

## ---- echo=FALSE---------------------------------------------------------
x=rnbinom(100, size=30, mu=2)
res=hist(x, main="Negative Binomial Distribution", prob=FALSE, col="lightgrey",
     breaks=seq(-0.5, round(max(x))+0.5, by=0.5))
xdens = seq(min(x), max(x), by=1)
lines(xdens, length(x) * dnbinom(xdens, size=30, mu=2), lw=2)

## ---- echo=FALSE---------------------------------------------------------
x=rbinom(100, size=20, prob=0.25)
res=hist(x, main="Binomial Distribution", prob=FALSE, col="lightgrey",
     breaks=seq(-0.5, round(max(x))+0.5, by=0.5))
xdens = seq(min(x), max(x), by=1)
lines(xdens, length(x) * dbinom(xdens, size=20, prob=0.25), lw=2)

## ---- echo=TRUE----------------------------------------------------------
disease=factor(c(rep(0,180),rep(1,20),rep(0,40),rep(1,10)),
               labels=c("control","cases"))
genotype=factor(c(rep("AA/Aa",204),rep("aa",46)),
                levels=c("AA/Aa","aa"))
dat <- data.frame(disease, genotype)
dat <- dat[sample(nrow(dat)),] #shuffle them up 
summary(dat)

## ------------------------------------------------------------------------
table(disease, genotype)
chisq.test(disease, genotype)
chisq.test(disease, genotype, simulate.p.value = TRUE)

## ------------------------------------------------------------------------
library(epitools)
epitools::oddsratio(genotype, disease, method="wald")$measure


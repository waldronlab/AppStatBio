assignments = dir(recursive = TRUE, pattern = glob2rx("*.R*"))
assignments = grep("lecture", assignments, invert = TRUE, value = TRUE)

strata = sub("/.+", "", assignments)
strata = unique(strata)
strata = grep(".R", strata, invert=TRUE, value=TRUE, fixed=TRUE)

set.seed(1)
mysample = sapply(strata, function(stratum){
    stratumsamplingframe = grep(stratum, assignments, value=TRUE, fixed=TRUE)
    res = sample(stratumsamplingframe, 1)
    return(res)
})

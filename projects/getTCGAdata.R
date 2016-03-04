if( !require(RTCGAToolbox) ){
    library(devtools)
    install_github("LiNk-NY/RTCGAToolbox")
    library(RTCGAToolbox)
}

all.dates <- getFirehoseRunningDates()
all.datasets <- getFirehoseDatasets()

data.path <- "."
data.file <- file.path(data.path, "TCGA.rda")

if(file.exists(data.file)){
    load(data.file)
}else{
    tcga.res <- list()
    for (i in 1:length(all.datasets)){
        (ds.name <- all.datasets[i])
        if(!ds.name %in% names(tcga.res)){
            res <- try(getFirehoseData(ds.name, runDate=all.dates[1], RNAseq_Gene=TRUE, RNAseq2_Gene_Norm=TRUE, mRNA_Array=TRUE))
        }
        if(!is(res, "try-error")){
            tcga.res[[ds.name]] <- res
        }
    }
    save(tcga.res, file=data.file)
}


for (i in 1:length(tcga.res)) {
  print(names(tcga.res)[i])
  # ## use only primary tumors
  eset = try(extract(tcga.res[[i]], "RNAseq2_Gene_Norm"))
  if (is(eset, "try-error"))
    next
  eset = eset[, substr(sampleNames(eset), 14, 15) %in% c("01", "03", "09")]
  saveRDS(eset, file = paste0(names(tcga.res)[i], "_RNAseq2.rds"))
}

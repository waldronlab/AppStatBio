if( !require(RTCGAToolbox) ){
  library(BiocInstaller)
  biocLite("LiNk-NY/RTCGAToolbox")
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
  eset = eset[, as.integer(substr(sampleNames(eset), 14, 15)) %in% 1:9]
  saveRDS(eset, file = paste0(names(tcga.res)[i], "_RNAseq2.rds"))
}

res <- getFirehoseData("SKCM", runDate="20151101", RNAseq2_Gene_Norm=TRUE)
eset = extract(res, "RNAseq2_Gene_Norm")
devtools::session_info()

expdat <- res@RNASeq2GeneNorm
colnames(expdat) <- tolower(substr(colnames(expdat), 1, 12))
clindat <- res@Clinical
rownames(clindat) <- gsub(".", "-", rownames(clindat), fixed=TRUE)
clindat <- clindat[rownames(clindat) %in% colnames(expdat), ]
expdat <- expdat[, match(rownames(clindat), colnames(expdat))]

all.equal(colnames(expdat), rownames(clindat))
eset <- ExpressionSet(assayData=expdat, phenoData=AnnotatedDataFrame(clindat))

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

tcgacodes <-
  structure(list(Study.Abbreviation = c("GBM", "OV", "LUSC", "LAML",
                                        "COAD", "KIRC", "LUAD", "READ", "BRCA", "STAD", "UCEC", "KIRP",
                                        "HNSC", "LIHC", "LGG", "BLCA", "THCA", "CESC", "PRAD", "PAAD",
                                        "DLBC", "SKCM", "SARC", "KICH", "ESCA", "UCS", "ACC", "MESO",
                                        "PCPG", "UVM", "CHOL", "TGCT", "THYM"), Study.Name = c("Glioblastoma multiforme",
                                                                                               "Ovarian serous cystadenocarcinoma", "Lung squamous cell carcinoma",
                                                                                               "Acute Myeloid Leukemia", "Colon adenocarcinoma", "Kidney renal clear cell carcinoma",
                                                                                               "Lung adenocarcinoma", "Rectum adenocarcinoma", "Breast invasive carcinoma",
                                                                                               "Stomach adenocarcinoma", "Uterine Corpus Endometrial Carcinoma",
                                                                                               "Kidney renal papillary cell carcinoma", "Head and Neck squamous cell carcinoma",
                                                                                               "Liver hepatocellular carcinoma", "Brain Lower Grade Glioma",
                                                                                               "Bladder Urothelial Carcinoma", "Thyroid carcinoma", "Cervical SCC and endocervical AC",
                                                                                               "Prostate adenocarcinoma", "Pancreatic adenocarcinoma", "Diffuse Large B-cell Lymphoma",
                                                                                               "Skin Cutaneous Melanoma", "Sarcoma", "Kidney Chromophobe", "Esophageal carcinoma ",
                                                                                               "Uterine Carcinosarcoma", "Adrenocortical carcinoma", "Mesothelioma",
                                                                                               "Pheochromocytoma and Paraganglioma", "Uveal Melanoma", "Cholangiocarcinoma",
                                                                                               "Testicular Germ Cell Tumors", "Thymoma")), .Names = c("Study.Abbreviation",
                                                                                                                                                      "Study.Name"), row.names = c(2L, 10L, 24L, 26L, 29L, 33L, 35L,
                                                                                                                                                                                   43L, 48L, 49L, 50L, 52L, 55L, 56L, 79L, 87L, 88L, 89L, 92L, 107L,
                                                                                                                                                                                   136L, 180L, 218L, 226L, 254L, 302L, 304L, 353L, 366L, 416L, 427L,
                                                                                                                                                                                   429L, 430L), class = "data.frame")


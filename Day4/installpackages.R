## Try:
BiocManager::install("waldronlab/MultiAssayExperimentWorkshop")

## If that doesn't install a bunch of dependencies, try:

BiocManager::install( c( "MultiAssayExperiment", "GenomicRanges",
                         "RaggedExperiment", "curatedTCGAData", "GenomicDataCommons",
                         "SummarizedExperiment", "SingleCellExperiment", "TCGAutils",
                         "UpSetR", "mirbase.db", "AnnotationFilter", "EnsDb.Hsapiens.v86",
                         "survival", "survminer", "pheatmap" ) )

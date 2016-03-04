# Final Project

The final project is a study of cancer subtypes that have been identified by whole-transcriptome clustering and reported by The Cancer Genome Atlas (TCGA) project.  The primary objectives of your analysis will be to perform your own unsupervised clustering of the dataset and compare to the reported results, and to develop and assess your own subtype classifier.

Datasets have been posted as issues on the Github page – please assign one of  these issues to yourself to take on that cancer type.  The datasets includes two files:

*The first* is an “.rds” file, a serialized R data file, containing an object of class “ExpressionSet”. You will need to have Bioconductor installed to use this object. You can load this file and use the resulting data object by doing:

    > eset <- readRDS(“filename.rds”)   ## eset and filename are examples
    > library(Biobase)
    > exprs(eset)   ##provides the expression data
    > pData(eset)  ##provides “phenotype” data, in this case clinical data
    > sampleNames(eset) ##provides patient identifiers
    > featureNames(eset) ##provides gene symbols

This file contains expression values determined by the TCGA’s “RNASeqV2” RNA-seq pipeline, described at https://wiki.nci.nih.gov/display/TCGA/RNASeq+Version+2.  These “Transcripts per Million” (TPM) values are already normalized by transcript length and total read depth.

*The second* is a csv file, providing per-patient subtype calls reported by TCGA project analysts. The patient barcodes in the first column of this file will have to be matched to sampleNames(eset) for this analysis.

**First, introduce yourself to the dataset:**

1) How many genes and samples are there? 

2) For each gene, calculate the number of samples where it has at least one count.  How many genes have at least one count in at least 10% of the samples? Present a histogram of the % of samples in which each gene has 1 or more counts. 

3) Create a single boxplot showing the expression counts of 16 randomly selected genes. Do the data appear normally distributed?  

4) Create another boxplot for the same genes, after adding 1 and taking base-2 logarithm of the expression counts. Is this more normally distributed? If so, use this transformed version of the dataset for further exploratory analysis.

5) For another look at these gene expression distributions, make 16 histograms on a 4x4 grid.  

6) using whichever transformation between 4 and 5 resulted in a more nearly normal distribution, create a boxplot showing expression values for each sample.  Do any samples look like outliers?  

*Show any other exploratory analysis you try and find useful.*

**A visual look for cluster structure**

7) Remove any genes that have non-zero counts in fewer than 10% of the samples. Using the more normally distributed transformation of the data, perform a Principal Components Analysis (PCA).  A standard base R solution for PCA is the `prcomp()` function. Be sure to include variance scaling for the genes, which can be done manually or as an option to the `prcomp()` function. Show the screeplot of your PCA, and comment.

8) Make two side-by-side plots of PC2 vs PC1.  In the first, do not distinguish between subtypes.  In the second, use color and data point shapes to distinguish between the reported subtypes. Do you see any obvious structure or clustering of the samples?  Be VERY sure you have correctly aligned patient barcodes in the ExpressionSet and the barcodes file, for example using identical().

**Differential Expression**

9) Use the DESeq2 Bioconductor package to assess differential expression of each gene across the subtypes, using a one-way Analysis of Variance (ANOVA). Create a histogram of raw p-values. Create a second histogram of F-statistics, adding a vertical red line at the critical F-statistic corresponding to a Bonferroni-corrected p-value of 0.05. Repeat these two histograms, after permuting the subtype labels. Comment on the shapes of the histograms. 
Note that the DESeq2 differential expression should be performed on untransformed expression values. 

10) Create a clustered heatmap of the top 1000 differentially expressed genes, ranked by p-value, with rows (genes) scaled to unit variance (row scaling is an automatic option available in most heatmap plotting functions. Create a column sidebar, for example by using the annotation_col argument of `pheatmap::pheatmap()`.

**Unsupervised Clustering**

11) Attempt to reproduce the unsupervised clustering methods reported by the paper for your cancer type. Create a “confusion matrix” showing the concordance between subtype calls produced by your method, and as provided by TCGA. Report on the methods you used, and how similar your results are to those reported.


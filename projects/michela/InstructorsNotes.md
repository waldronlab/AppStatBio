Note 1
====================

Would be nice to have the source code file so I could re-run the script myself.

Note on Question 2
====================

In these lines:

```
phenotype <- pData(eset)[row.names(pData(eset)) %in% subtypes$sample.id,]
subt.eset <- exprs(eset)[,sampleNames(eset) %in% subtypes$sample.id]
```

Note these do not attempt to align the samples, only to make sure that each dataset has the same set of samples. Oh, but I see you did this later:

```
subtypes = subtypes[match(sampleNames(eset), subtypes$sample.id), ]
```

Would be better to do all this together, then add a check that the samples are correctly aligned, for example:

```
stopifnot(sampleNames(eset), subtypes$sample.id))
```

**Update** I see that you are using an element of an ExpressionSet to store the subtypes, which is *good*, a safe way to ensure pdata and expression data are always aligned.  You have some legacy code though that makes this confusing, and I'm not sure why you have these two different ExpressionSets and copy subtypes across them with this line?

```
eset$subtype = subtypes$Cluster
```


Questions 1-8 summary
====================

1-6 look good. Screeplot looks good, could comment that first PC accounts for 12% of variance.

8. side by side PCA plots might look less squashed with `par(mfrow=c(1, 2))`. Were you surprised that there is no separation of subtypes in the PCA plot, ie they are all mixed together?  I was.



Question 9 Differential Expression
====================

Note that DESeq2 will by default only contrast two of your conditions, e.g. see https://support.bioconductor.org/p/61563/.

I'm surprised the p-values show so little association with subtypes.  Did you ensure that the rounding-off line:

```
countData <- matrix(as.integer(subtypes10), ncol=151)
```

re-assembled your matrix in the correct configuration? It should work if ncol=151 is correct, but at the beginning `dim(eset)` showed 152 columns - what happened to the 152nd sample?

Conclusions
====================

Missing the permutation test, Bonferonni-corrected red line, clustered heatmap, and unsupervised clustering, but good efforts and results on the rest.

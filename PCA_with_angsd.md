### Running doGlf 2 which gives an output beagle file to use in PCAngsd. 
```
./angsd -bam ./prueba/bam.filelist -GL 2 -out ./prueba/beagle/genolike -nThreads 10 -doMajorMinor 1 -doMaf 2 -SNP_pval 1e-6 -doGlf 2 -ref reference.fasta
```
```
gunzip -c genolike.mafs.gz |head 
```
It worked and I could read the maf. Now running PCAngsd that it works only if it is inside a conda env and follow this intrusctions https://github.com/Rosemeis/pcangsd
```
pcangsd -b genolike.beagle.gz -e 2 -t 20 -o pcangsd
```
Check the outputs
```
gunzip -c genolike.beagle.gz | head -n 10 | cut -f 1-10 | column -t #In order to see the first 10 columns and 10 lines of the input file
```
```
gunzip -c genolike.beagle.gz | wc -l #To count the number of lines which indicates the number of loci for which there are GLs plus one (as the command includes the count of the header line)
```


PCAngsd make a covariance matrix but it reports that it did not converge using 2 eigenvectors indicating that the optimization process (used to calculate the eigenvectors and eigenvalues) didn't fully stabilize. It means that the iterative process didn't reach a point where the results stopped changing significantly with further iterations. This raises questions about the reliability of the results, but it's not necessarily a deal-breaker for interpreting your PCA. Here’s what to consider:

Non-convergence could indicate that the PCA couldn't find stable patterns in your data, possibly due to low genetic variation, high noise, or insufficient sample size

If there’s not enough genetic variation between the individuals or populations, the PCA may struggle to distinguish clear components, leading to non-convergence

# in R
```
cov_matrix <- as.matrix(read.table("C:/Users/Katta/Documents/HIMB/R scripts/pcangsd.cov"))
pca_result <- prcomp(cov_matrix)
```

### Plot first two principal components
```
plot(pca_result$x[,1], pca_result$x[,2], xlab="PC1", ylab="PC2", main="PCA plot")
```

### Load metadata file with the name of the populations
```
metadata <- read.table("C:/Users/Katta/Documents/HIMB/R scripts/metadata.csv", 
                       header = TRUE, sep = ",", col.names = c("Individual", "Population"))
```
### Plot the first two principal components
```
plot(pca_result$x[,1], pca_result$x[,2], 
     xlab = "PC1", ylab = "PC2", 
     col = as.factor(metadata$Population), # Color points by population
     pch = 19, # Solid circles for points
     main = "PCA plot by Population")
```
### Add a legend to indicate which color represents which population
```
legend("topright", legend = unique(metadata$Population), 
       col = unique(as.factor(metadata$Population)), pch = 19)
```

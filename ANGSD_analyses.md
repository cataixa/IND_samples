 #Create a list with the bam files and index them. Careful with the path, if I have my bam files in a different folder than angsd my bam.filelist have to include the path to the bam samples. I can
 always leave the bam files within angsd folder and then do a folder for the outputs

```
ls ./*.bam > bam.filelist
for i in *.bam;do samtools index $i;done
```

 ###Calculate Genotype Likelihoods, filtering parameters and call SNPs
 ```
 ./angsd -bam ../INDIVIDUAL_project/mapping/bam.filelist -GL 2 -out ../INDIVIDUAL_project/mapping/angsd_results/output -nThreads 8 -doMajorMinor 1 -doMaf 2 -SNP_pval 0.01 -uniqueOnly 1 -minMapQ 30 -minQ 20 -only_proper_pairs 1 -remove_bads 1 -skipTriallelic 1 -baq 1 -ref reference.fasta
 ```
NOTE: -doMajorMinor 1; From input for either sequencing data like bam files or from genotype likelihood data like glfv3 the major and minor allele can be inferred directly from likelihoods. We use a maximum likelihood approach to choose the major and minor alleles. Details of the method can be found in the theory section of this page and for citation use this publication Skotte2012 and is briefly described here.

Important to add doMaf to get the SNPs and being able to add the SNP_pval flag

-GL 2: Uses the GATK genotype likelihood model (GL = Genotype Likelihood).

-doMajorMinor 1: Estimates the major and minor alleles for each site.

-doMaf 2: Calculates the site frequency spectrum and produces the minor allele frequency (MAF) based on the inferred alleles.

-SNP_pval 0.01: Filters SNPs based on a p-value threshold of 0.01.

-uniqueOnly 1: Uses only uniquely mapped reads (reads that map to a single location in the genome).

-minMapQ 30: Filters out reads with a mapping quality score below 30.

-minQ 20: Filters out bases with a base quality score below 20.

-only_proper_pairs 1: Uses only properly paired reads (paired-end reads that align as expected).

-remove_bads 1: Removes reads flagged as "bad" by the aligner.

-skipTriallelic 1: Skips triallelic sites (sites with more than two alleles).

-baq 1: Performs BAQ (Base Alignment Quality) adjustment to reduce false positives due to misalignments near indels.

```
gunzip -c output.mafs.gz |head
```






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

```
gunzip -c output.mafs.gz |head
```






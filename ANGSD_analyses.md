 #Create a list with the bam files and index them

```
ls ./*.bam > bam.filelist
for i in *.bam;do samtools index $i;done
```

 ###Calculate Genotype Likelihoods, filtering parameters and call SNPs
 ```
 ./angsd -bam bam.filelist -GL 2 -out filtered_output -nThreads 8 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -only_proper_pairs 1 -remove_bads 1 -skipTriallelic 1 -baq 1 -ref reference.fasta
 ```
 -doMajorMinor 1

 From input for either sequencing data like bam files or from genotype likelihood data like glfv3 the major and minor allele can be inferred directly from likelihoods. We use a maximum likelihood approach to choose the major and minor alleles. Details of the method can be found in the theory section of this page and for citation use this publication Skotte2012 and is briefly described here. 

 It didnt recognize -SNP_pval 1e-6 -minMaf 0.05 why?? It did with less samples and less parametres; 
 ```
./angsd -bam ./prueba/bam.filelist -GL 2 -out ./prueba/output -nThreads 20 -doMajorMinor 1 -doMaf 2 -SNP_pval 1e-6 -ref reference.fasta
```
maybe incompatible parameters? maybe I was missing the doMaf?
 

 #Create a list with the bam files and index them. Careful with the path, if I have my bam files in a different folder than angsd my bam.filelist have to include the path to the bam samples. I can
 always leave the bam files within angsd folder and then do a folder for the outputs

```
ls ./*.bam > bam.filelist
for i in *.bam;do samtools index $i;done
```

 ###Calculate Genotype Likelihoods, filtering parameters and call SNPs
 ```
 ./angsd -bam bam.filelist -GL 2 -out filtered_output -nThreads 8 -doMajorMinor 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -only_proper_pairs 1 -remove_bads 1 -skipTriallelic 1 -baq 1 -ref reference.fasta
 ```
NOTE: -doMajorMinor 1; From input for either sequencing data like bam files or from genotype likelihood data like glfv3 the major and minor allele can be inferred directly from likelihoods. We use a maximum likelihood approach to choose the major and minor alleles. Details of the method can be found in the theory section of this page and for citation use this publication Skotte2012 and is briefly described here. 

It didnt recognize -SNP_pval 1e-6 -minMaf 0.05 why?? It did with less samples (35) and less parametres; 
```
./angsd -bam ./prueba/bam.filelist -GL 2 -out ./prueba/output -nThreads 20 -doMajorMinor 1 -doMaf 2 -SNP_pval 1e-6 -ref reference.fasta
```
maybe incompatible parameters? maybe I was missing the doMaf? snp_pvalue can be change, for example to 0.01.  When choosing a lenient p-value threshold (0.01) ANGSD infers more SNP sites than the other two methods when choosing a strict p-value threshold (10−6) fewer sites are called.

The maf.gz was corrupted, I wasn't able to open it but see below 

###Running the same command but adding doGlf 2 which gives an output beagle file to use in PCAngsd. 
```
./angsd -bam ./prueba/bam.filelist -GL 2 -out ./prueba/beagle/genolike -nThreads 10 -doMajorMinor 1 -doMaf 2 -SNP_pval 1e-6 -doGlf 2 -ref reference.fasta
gunzip -c genolike.mafs.gz |head 
```
It worked and I could read the maf. Now running PCAngsd that it works only if it is inside a conda env and follow this intrusctions https://github.com/Rosemeis/pcangsd
```
pcangsd -b genolike.beagle.gz -e 2 -t 20 -o pcangsd
```

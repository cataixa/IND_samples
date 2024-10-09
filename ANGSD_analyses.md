###Create a list with the bam files and index them

```
ls bams/*.bam > bam.filelist
for i in *.bam;do samtools index $i;done
```

###Calculate Genotype Likelihoods, filtering parameters and call SNPs
```
./angsd -bam bam_list.txt -GL 2 -out filtered_output -nThreads 20 -doGlf 2 -doMaf 1 -uniqueOnly 1 -minMapQ 30 -minQ 20 -only_proper_pairs 1 -remove_bads 1 -skipTriallelic 1 -baq 1  -SNP_pval 1e-6 -minMaf 0.05
```

 

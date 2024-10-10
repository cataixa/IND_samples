
### index multiple bam files
```
parallel -j $NUMPROC samtools index {} ::: ` ls *.sort.bam `
```

### caculate number of reads from bam files
```
```

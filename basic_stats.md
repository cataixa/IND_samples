
### index multiple bam files
```
parallel -j $NUMPROC samtools index {} ::: ` ls *.sort.bam `
```

### caculate number of reads from bam files
```
NUMPROC=55
parallel -j $NUMPROC \
	"samtools view -c {1} | awk -v pop={1/.} '{print pop\",\"\$1}' - >> readcounts.txt" ::: \
	` find ./mapping/ -name "*.bam" | sort `
```

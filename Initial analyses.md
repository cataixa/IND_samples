
# Loop to perform FASTQC analyses in all my files
#Define the directory where the fastq.gz files are located (change if necessary)
```
BASEDIR=~/path_to_your_fq_files
```

#Define output directory for FastQC reports (previously create it)
```
OUTPUT_DIR=$BASEDIR/fastqc_results
```

#Loop through all .fq.gz files in the base directory
```
for FILE in $BASEDIR/*.fq.gz; do
    echo "Running FastQC on $FILE"
    fastqc -o $OUTPUT_DIR $FILE
done
```
#Go to the folder and run multiqc
```
cd fastqc_results
multiqc .
```

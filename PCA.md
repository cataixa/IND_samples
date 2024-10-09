###Prepare PCA files:

```
module load plink/2.00-alpha

plink2 --vcf BXD_145ind_allchr_snps_nonref_id.vcf.gz --freq --make-bed --out PCA_plink_allchr
plink2 --bfile PCA_plink_allchr --read-freq PCA_plink_allchr.afreq --pca --out PCA_plink_allchr_result
```
###Plot percentage variance explained by each PC

```
###R
eigenval=read.table("PCA_plink_allchr_result.eigenval",header=FALSE)
###PVE = percentage variance explained by each PC
pve<-data.frame(PC = 1:10, V1 = eigenval/sum(eigenval)*100)
###Plot
ggplot(pve, aes(PC, V1)) + geom_bar(stat="identity") + ylab("Percentage variance explained")
```

###Plot PCA

```
###R GGPLOT

eigenvec=read.table("PCA_plink_allchr_result.eigenvec",header=FALSE)
#Add epoch labels to relevant rows of 1st column
eigenvec[1:24,"V1"]<-1
eigenvec[25:73,"V1"]<-3
eigenvec[74:96,"V1"]<-4
eigenvec[97:115,"V1"]<-5
eigenvec[116:145,"V1"]<-6
#Convert epochs to factor
eigenvec[,"V1"]<-as.factor(eigenvec[,"V1"])
#Adjust col names
names(eigenvec)[names(eigenvec) == "V1"] <- "Epoch"
names(eigenvec)[names(eigenvec) == "V2"] <- "Ind"
names(eigenvec)[names(eigenvec) == "V3"] <- "PCA1"
names(eigenvec)[names(eigenvec) == "V4"] <- "PCA2"
#Plot
library(RColorBrewer)
cc<-colorRampPalette(brewer.pal(7,"Blues"))(5)
ggplot(eigenvec, aes(PCA1, PCA2, color=Epoch)) + geom_point() + ggtitle("Genome-wide, filtered dataset") + scale_color_manual(values=cc) + labs(x="PCA1 (explains ~14 % variance)", y="PCA2 (explains ~12 % variance)")
```

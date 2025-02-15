####R packages (You might need to upgrade your base R to a version > 4.0 to be able to install these packages). Just type the following lines in your console to install

install.packages("tidyverse")
install.packages("LDheatmap")
install.packages("reshape2")
install.packages("gtools")
install.packages("methods")
install.packages("optparse")

####optional (to run all examples in ngsTools outside the workshop)
install.packages("ape")
install.packages("phangorn")
install.packages("plyr")
install.packages("plot3D")

####they're simply loaded via library()

library (tidyverse)
library(LDheatmap)
library(reshape2)
library(gtools)
library(methods)
library(optparse)
library(ape)
library(phangorn)
library(plyr)
library(plot3D)
library(snpStats)


mafs <- read.table("C:/Users/Katta/Documents/HIMB/Filezilla downloads/
                   output.mafs/output.mafs", header=TRUE)
mafs <- read.table(file.choose(), header=TRUE) #open a browser to find the file
head(mafs)
str(mafs)

# Take a random sample of 100,000 rows for faster plotting
sample_data <- mafs[sample(nrow(mafs), 100000), ]
# Adjust the margin sizes (bottom, left, top, right)
par(mar = c(4, 4, 2, 1))  # Smaller margins should avoid the error

# Create the histogram again
hist(sample_data$unknownEM, main="Histogram of unknownEM", xlab="unkownEM", breaks=50)


num_snps <- nrow(mafs)
unique_snps <- unique(mafs[, .(mafs$chromo, mafs$position)])
num_unique_snps <- nrow(unique_snps)

# Print the results
cat("Total SNPs:", num_snps, "\n")
cat("Unique SNPs (by chromo and position):", num_unique_snps, "\n")


###PCA CON COVMAT

covMat<- as.matrix(read.table("C:/Users/Katta/Documents/HIMB/Filezilla downloads/pcangsd.cov")) 
metadata <- read.table("C:/Users/Katta/Documents/HIMB/R scripts/poblaciones.csv", 
                       header = TRUE, sep = ",", col.names = c("Individual", "Population"))
dim(covMat)
nrow(covMat)
ncol(covMat)

e <- eigen(covMat)
plot(e$vectors[,1:2],lwd=2,ylab="PC 2",xlab="PC 1",main="Principal components",col=rep(1:3,each=10),pch=16)

# Create a color mapping for populations
unique_populations <- unique(metadata$Population)
population_colors <- rainbow(length(unique_populations))  # Generate a distinct color for each population
names(population_colors) <- unique_populations

#Assign colors to each individual based on their population
colors <- population_colors[as.factor(metadata$Population)]

plot(e$vectors[, 1:2], 
     lwd = 2, 
     ylab = "PC 2", 
     xlab = "PC 1", 
     main = "Principal components", 
     col = colors,  # Use the population colors
     pch = 16)

legend("topright",  # Position of the legend
       legend = unique_populations,  # Labels for populations
       col = population_colors,  # Colors corresponding to populations
       pch = 16,      # Same point type as in the plot
       title = "Populations",
       cex = 0.8)

#with ggplot
#Create a custom color palette for your populations
population_levels <- unique(metadata$Population)
custom_colors <- rainbow(length(population_levels)) 

pca_data <- data.frame(PC1 = e$vectors[, 1],
                       PC2 = e$vectors[, 2],
                       Population = as.factor(metadata$Population))
ggplot(pca_data, aes(x = PC1, y = PC2, color = Population)) +
  geom_point(size = 3) +
  labs(title = "Principal Components",
       x = "PC 1",
       y = "PC 2") +
  theme_minimal() +
  scale_color_manual(values = custom_colors) +  # Use custom colors
  theme(legend.title = element_blank())


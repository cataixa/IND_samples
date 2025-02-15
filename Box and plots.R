library(ggplot2)
library(dplyr)
library(viridis)
library(RColorBrewer)
install.packages("RColorBrewer")  # For color palettes
install.packages("viridis")

data<-Results_IND_samples

#### Group by population and calculate summary statistics
summary_data <- data %>%
  group_by(Population) %>%
  summarize(
    MeanCoverage = mean(Coverage),
    MinCoverage = min(Coverage),
    MaxCoverage = max(Coverage)
  )

ind_per_pop <- data %>%
  group_by(Population) %>%           
  summarise(Individual = n())

write.xlsx(ind_per_pop, "population_counts.xlsx")  # Requires openxlsx package



##### Create a basic plot
ggplot(summary_data, aes(x = Population, y = MeanCoverage)) +
  geom_point(size = 3, color = "blue") +  # Plot mean values
  geom_errorbar(aes(ymin = MinCoverage, ymax = MaxCoverage), width = 0.2) +  # Add range (min to max)
  theme_minimal() + 
  labs(
    title = "Coverage Range and Mean per Population",
    x = "Population",
    y = "Coverage"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels if needed

#### Box plots
ggplot(data, aes(x = Population, y = Coverage)) +
  geom_boxplot() +
  stat_summary(fun = mean, geom = "point", shape = 18, color = "red", size = 3) +  # Add mean points
  theme_minimal() +
  labs(
    title = "Coverage Distribution per Population with Mean",
    x = "Population",
    y = "Coverage"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels if needed

#### Your desired population order
desired_order <- c("MON", "WHC", "BIC", "CAM", "DIC", "JAL", 
                   "COJ", "NAP", "ISV", "HAR", "RII", "GUI", 
                   "YEL", "ANN", "POD", "PAV", "EAR", "DAP", 
                   "POL", "ITS", "ISM", "ISG", "ISR")

# Assuming your data frame is named 'data' and the Population column is called 'Population'
data$Population <- factor(data$Population, levels = desired_order)

# Check the updated levels to ensure they are in the desired order
levels(data$Population)


cov_box<-ggplot(data, aes(x = Population, y = Coverage, fill = Population)) +
  geom_boxplot() +
  scale_fill_manual(values = colorRampPalette(brewer.pal(9, "Set3"))(25)) +  # Color palette with 25 colors
  theme_minimal() +
  theme(legend.position = "none", axis.text.x = element_text(angle = 45, hjust = 0.5),
        axis.text.y = element_text(hjust = 2))
  labs(
    title = "Coverage Distribution per Population with Mean Line",
    x = "Population",
    y = "Coverage"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
  

  ggsave("coverage.jpg", cov_box, width = 10, height = 6, dpi = 300)
  ggsave("coverage.svg", cov_box, width = 10, height = 6, dpi = 300)
  

  ##Box plot read counts
  
  data<-readcounts
  summary_data <- data %>%
    group_by(Population) %>%
    summarize(
      Meanread = mean(Read_count),
      Minread = min(Read_count),
      Maxread = max(Read_count)
    )
  
  ind_per_pop <- data %>%
    group_by(Population) %>%           
    summarise(Individual = n())


  cov_box<-ggplot(data, aes(x = Population, y = Read_count, fill = Population)) +
    geom_boxplot() +
    scale_fill_manual(values = colorRampPalette(brewer.pal(9, "Set3"))(25)) +  # Color palette with 25 colors
    theme_minimal() +
    theme(legend.position = "none", axis.text.x = element_text(angle = 45, hjust = 0.5),
          axis.text.y = element_text(hjust = 2))+
    labs(
    title = "",
    x = "Population",
    y = "Number of reads"
  ) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  print(cov_box)
  
  ggsave("readcount.jpg", cov_box, width = 10, height = 6, dpi = 300)
  ggsave("readcount.svg", cov_box, width = 10, height = 6, dpi = 300)
  

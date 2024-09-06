# Bee Biodiversity Analysis - Comparison between the United States and China
# This script uses biodiversity data from BOLD (Barcode of Life Data System) for the taxon Apidae.
# The goal is to compare BIN (Barcode Index Number) richness between the United States and China 
# and explore potential links between biodiversity and bee colony loss rates.

# 1. Set Working Directory
# Set the working directory where your data and scripts are stored.
setwd("path/to/your/directory")
getwd()

# 2. Load Required Libraries
# Loading essential libraries for data manipulation and visualization
library(tidyverse)  # For data handling and visualization
library(dplyr)      # For data manipulation
library(ggplot2)    # For plotting
library(VennDiagram) # For creating a Venn diagram
library(vegan)      # For biodiversity analysis (e.g., species accumulation curve)

# 3. Load Data from BOLD
# Loading biodiversity data from BOLD for the Apidae family
dfBOLD <- read_tsv("http://www.boldsystems.org/index.php/API_Public/combined?taxon=Apidae&format=tsv")

# Check the structure and summary of the data
names(dfBOLD)    # Column names
summary(dfBOLD)  # Summary statistics
length(dfBOLD)   # Number of rows in the dataset

# 4. Subset Relevant Columns
# We will keep only important columns: "processid", "bin_uri", "species_name", and "country"
dfBOLD.sub <- dfBOLD[, c(1, 8, 22, 55)]
dfBOLD.test <- dfBOLD[, c(1, 8, 22, 55)]

# Ensure the two subsets are equal (sanity check)
stopifnot(all.equal(dfBOLD.sub, dfBOLD.test))

# 5. Create Country-Specific Subsets
# Subset the data for samples collected from China and the United States
China_data <- subset(dfBOLD.sub, country == "China")
US_data <- subset(dfBOLD.sub, country == "United States")

# 6. Calculate Unique Species and BINs
# Get the number of unique species and BINs for both countries
china_species_count <- length(unique(China_data$species_name))  # 66
us_species_count <- length(unique(US_data$species_name))        # 375
china_bin_count <- length(unique(China_data$bin_uri))           # 84
us_bin_count <- length(unique(US_data$bin_uri))                 # 346

# 7. Create a Summary DataFrame
# Data for unique species and BIN counts in both countries
Unique.df <- data.frame(
  Category = c("China_Species", "China_Bins", "US_Species", "US_Bins"),
  Frequency = c(china_species_count, china_bin_count, us_species_count, us_bin_count)
)

# 8. Create a Bar Plot
# Visualize the comparison of unique species and BIN counts between China and the United States
ggplot(Unique.df, aes(x = Category, y = Frequency)) +
  geom_bar(stat = "identity", fill = "green") +
  labs(
    title = "Unique Species and BIN Richness in China and United States",
    x = "Categories",
    y = "Count"
  )

# 9. Venn Diagram of Unique Species
# Identify unique species and plot a Venn diagram to show overlaps
# Remove duplicate species names and rows with missing species names
China_unique_species <- China_data %>%
  filter(!duplicated(species_name)) %>%
  filter(complete.cases(species_name))

US_unique_species <- US_data %>%
  filter(!duplicated(species_name)) %>%
  filter(complete.cases(species_name))

# Create a list of species for Venn diagram
sets_list <- list(
  China = China_unique_species$species_name,
  US = US_unique_species$species_name
)

# Generate and display the Venn diagram
Venn_plot <- venn.diagram(
  x = sets_list,
  category.names = c("China", "United States"),
  filename = NULL,
  output = TRUE
)
grid.draw(Venn_plot)

# 10. Species Accumulation Curve (China Only)
# Grouping the Chinese data by BIN URI and counting occurrences
df_China_Count.by.BIN <- China_unique_species %>%
  group_by(bin_uri) %>%
  count(bin_uri)

# Reshape the data using pivot_wider() for the species accumulation curve
dfBINs_China_spread <- df_China_Count.by.BIN %>%
  pivot_wider(names_from = bin_uri, values_from = n)

# Plot the species accumulation curve
rarecurve(dfBINs_China_spread, xlab = "Individuals Barcoded", ylab = "BIN Richness")

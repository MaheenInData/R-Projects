# Bee Biodiversity Analysis - BOLD Apidae Data

This project analyzes biodiversity data for the **Apidae** family (bees) from the Barcode of Life Data System (BOLD). The main goal is to compare the **BIN** (Barcode Index Number) richness between China and the United States and explore possible links between biodiversity and bee colony loss rates.

## Table of Contents
- [Background](#background)
- [Requirements](#requirements)
- [Data](#data)
- [Usage](#usage)
- [Analysis](#analysis)
- [Results](#results)
- [License](#license)

## Background
This project is part of an assignment where I use biodiversity data from BOLD. The specific focus is on comparing **species** and **BIN richness** between two major regions: the **United States** and **China**. This can help understand how biodiversity impacts factors like bee colony loss, which is a major concern in agriculture.

## Requirements
The following R packages are required for running this script:
- `tidyverse`: For data manipulation and visualization
- `ggplot2`: For creating bar plots
- `VennDiagram`: For creating Venn diagrams to compare species overlaps
- `vegan`: For species accumulation curves

You can install the packages using:
```r
install.packages(c("tidyverse", "ggplot2", "VennDiagram", "vegan"))
```

## Data
The data is fetched from the Barcode of Life Data System (BOLD) via an API request for the taxon Apidae.
```r
dfBOLD <- read_tsv("http://www.boldsystems.org/index.php/API_Public/combined?taxon=Apidae&format=tsv")
```

## Usage
+ Set your working directory to the folder where you want to save outputs:
setwd("/path/to/your/directory")
Run the R script Bee_Biodiversity_Analysis.R to perform the following:

+ Subset the data for the United States and China.
Calculate and visualize unique species and BIN richness.
Create a Venn diagram to show species overlap between the two regions.
Plot a species accumulation curve for China.

+ Output will include:

Bar plots comparing species and BIN counts.
A Venn diagram of species overlap.
A species accumulation curve for Chinese bee samples.

## Analysis
+ Species and BIN Counts: A summary of the unique species and BIN richness for both China and the United States.
+ Venn Diagram: Visualizes the overlap of species between the two countries.
+ Species Accumulation: Estimates the richness of bee species in China based on barcode data.

## Results
The results suggest that:
+ The United States has a higher number of unique species and BINs compared to China.
+ There is some overlap in species between the two countries, as shown in the Venn diagram.
+ The species accumulation curve shows the diversity trend for bee species in China.

## License
This project is licensed under the MIT License.

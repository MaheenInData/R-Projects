# RSV Genome Analysis

## Overview
This R script performs basic analysis of RSV genome data. It calculates the GC content and sequence lengths from FASTA files, plots the distribution of these statistics, and saves the results to files.

## Requirements
- R (version 4.0 or higher)
- Required R packages: `Biostrings`, `ggplot2`

## Installation
To install the required R packages, run the following command in R:
```r
install.packages(c("Biostrings", "ggplot2"))
```

## Usage
+ Prepare FASTA Files:
+ Place your FASTA files in a directory. Update the path in the script to point to this directory.

+ Run the Script
1. Open R or RStudio.
2. Load and run the script provided.

## Results

+ The script generates two plots:
1. sequence_lengths_distribution.png: Distribution of sequence lengths.
2. gc_content_distribution.png: Distribution of GC content.
+ The script also creates a CSV file:
1. viral_genome_statistics.csv: Contains the length and GC content of each sequence.

## File Descriptions
+ sequence_lengths_distribution.png: Histogram of sequence lengths.
+ gc_content_distribution.png: Histogram of GC content.
+ viral_genome_statistics.csv: CSV file with sequence statistics.

## License
+ This project is licensed under the MIT License.

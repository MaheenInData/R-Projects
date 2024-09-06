# Install required libraries if they are not already installed
install.packages(c("Biostrings", "ggplot2"))

# Load necessary libraries
library(Biostrings)  # For reading FASTA files and analyzing DNA sequences
library(ggplot2)     # For plotting data

# Define the path to your FASTA files
# Update the path to match the location where your FASTA files are stored
fasta_files <- list.files(path = "/Path/to/your/directory", pattern = "*.fasta", full.names = TRUE)

# Read the FASTA files into a list of DNAStringSet objects
sequences <- lapply(fasta_files, readDNAStringSet)

# Assign filenames as names for the list elements
names(sequences) <- basename(fasta_files)

# Function to calculate GC content
gc_content <- function(seq) {
  gc <- letterFrequency(seq, letters = c("G", "C")) # Count G and C nucleotides
  total <- width(seq) # Total length of the sequence
  gc / total * 100 # GC content as a percentage
}

# Extract statistics for each sequence
stats <- lapply(sequences, function(seq) {
  data.frame(
    Length = width(seq),               # Length of the sequence
    GC_Content = gc_content(seq)       # GC content of the sequence
  )
})

# Combine statistics from all sequences into a single data frame
stats_df <- do.call(rbind, stats)
stats_df$Genome <- rep(names(sequences), sapply(stats, nrow)) # Add genome names to the data frame

# Plot the distribution of sequence lengths
ggplot(stats_df, aes(x = Length, fill = Genome)) +
  geom_histogram(binwidth = 1000, position = "dodge") +
  labs(title = "Distribution of Sequence Lengths", x = "Length (bp)", y = "Frequency") +
  theme_minimal()

# Save the sequence length plot
ggsave("sequence_lengths_distribution.png")

# Plot the distribution of GC content
ggplot(stats_df, aes(x = GC_Content, fill = Genome)) +
  geom_histogram(binwidth = 5, position = "dodge") +
  labs(title = "Distribution of GC Content", x = "GC Content (%)", y = "Frequency") +
  theme_minimal()

# Save the GC content plot
ggsave("gc_content_distribution.png")

# Save the extracted statistics to a CSV file
write.csv(stats_df, "viral_genome_statistics.csv", row.names = FALSE)

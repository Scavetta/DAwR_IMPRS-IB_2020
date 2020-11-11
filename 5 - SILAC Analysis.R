# SILAC Analysis
# Protein profiles during myocardial cell differentiation

# Load packages ----
library(tidyverse)
library(glue)

# Part 0: Import data ----
protein_df <- read.delim("data/Protein.txt")

# Using tidyr methods
protein_tb <- read_tsv("data/Protein.txt")

# Examine the data:
class(protein_df)
protein_df
test <- data.frame(`protein size (KD)` = 16)
test$protein.size..KD. # This is a real name

class(protein_tb)
protein_tb # prints nicely to the screen
test_tb <- tibble(`protein size (KD)` = 16)
test_tb$`protein size (KD)`

# Quantify the contaminants ----


# Proportion of contaminants

# Percentage of contaminants (just multiply proportion by 100)

# Transformations & cleaning data ----

# Remove contaminants ====


# log 10 transformations of the intensities ====
# Save them "in situ"
# protein_df$Intensity.L <- log10(protein_df$Intensity.L)
# protein_df$Intensity.M <- log10(protein_df$Intensity.M)
# protein_df$Intensity.H <- log10(protein_df$Intensity.H)

# protein_df <- 
protein_df %>% 
  as_tibble() %>% 
  mutate(Intensity.L = log10(Intensity.L),
         Intensity.M = log10(Intensity.M),
         Intensity.H = log10(Intensity.H))

# As an exercise, can you figure out how to modify all
# columns that begin with "Intensity"


# Add the intensities ====

# log2 transformations of the ratios ====


# Part 2: Query data using filter() ----
# Exercise 9.2 (Find protein values) ====





# Exercise 9.3 (Find significant hits) and 10.2 ====
# For the H/M ratio column, create a new data 
# frame containing only proteins that have 
# a p-value less than 0.05


# Exercise 10.4 (Find top 20 values) ==== 


# Exercise 10.5 (Find intersections) ====


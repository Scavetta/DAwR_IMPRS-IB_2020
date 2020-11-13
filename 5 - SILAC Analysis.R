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

protein_df %>%
  filter(Contaminant == "+") %>% 
  nrow()

# recall TRUE is 1
sum(protein_df$Contaminant == "+")

# for categorical variables (i.e. "factors") or even characters
table(protein_df$Contaminant)

# Proportion of contaminants
sum(protein_df$Contaminant == "+")/nrow(protein_df)

# length(protein_df) # caution, this is the number of columns, not rows

# Percentage of contaminants (just multiply proportion by 100)
sum(protein_df$Contaminant == "+")/nrow(protein_df) * 100

# Transformations & cleaning data ----

# Remove contaminants ====

protein_df[protein_df$Contaminant != "+",]

protein_df %>% 
  filter(Contaminant != "+")



# log 10 transformations of the intensities ====
# Save them "in situ"
# protein_df$Intensity.L <- log10(protein_df$Intensity.L)
# protein_df$Intensity.M <- log10(protein_df$Intensity.M)
# protein_df$Intensity.H <- log10(protein_df$Intensity.H)

# protein_df <- 
# protein_df %>% 
#   as_tibble() %>% 
#   mutate(Intensity.L = log10(Intensity.L),
#          Intensity.M = log10(Intensity.M),
#          Intensity.H = log10(Intensity.H))

# As an exercise, can you figure out how to modify all
# columns that begin with "Intensity"

# in-situ log2 transformation at the columns of interest
# protein_df %>% 
#   as_tibble() %>% 
#   mutate_at(vars(starts_with("Rat"), -ends_with("Sig")), log2)

# A bit newer way, using across:
# protein_df <- read.delim("data/Protein.txt")
protein_df <- protein_df %>%
  as_tibble() %>% 
  filter(Contaminant != "+") %>% 
  mutate(across(starts_with("Rat") & -ends_with("Sig"), log2)) %>% 
  mutate(across(starts_with("Int"), log10)) %>% 
  mutate(Intensity.H.M = Intensity.H + Intensity.M,
         Intensity.M.L = Intensity.M + Intensity.L)


# This version would make NEW columns with a suffix "_hello" that contained the 
# transformed values:
# mutate(across(starts_with("Rat") & -ends_with("Sig"), list(hello = log2))) %>% 


# problems here:
# 1 - we've removed these columns form the whole data set
# 2 - we've transformed the Sig columns as well as the ratios 
# protein_df %>% 
#   as_tibble() %>% 
#   select(contains("Ratio")) %>% 
#   log2




# Add the intensities ====

# log2 transformations of the ratios ====


# Part 2: Query data using filter() ----
# Exercise 9.3 (Find protein values) ====
# Ratios for (H/M, M/L) of these Uniprot:

query <- c("GOGA7", "PSA6", "S10AB")

protein_df %>% 
  filter(Uniprot %in% query)

# solutions:
# 1 - add "_MOUSE" to our query
query_long <- paste0(query, "_MOUSE")

protein_df %>% 
  filter(Uniprot %in% query_long)


# 2 - remove _"MOUSE" from the search space

# 3 - Use pattern matching

query_2 <- c("Q3TFA5", "Q3UR67", "ADPRH") 

protein_df %>% 
  filter(Uniprot %in% query_2)

protein_df %>% 
  filter(str_detect(Uniprot, "Q3TFA5|Q3UR67|ADPRH"))

# get all ubiquitins:
protein_df %>% 
    filter(str_detect(Description, "ubiquitin"))

# Exercise 9.3 (Find significant hits) and 10.2 ====
# For the H/M ratio column, create a new data 
# frame containing only proteins that have 
# a p-value less than 0.05

# use filter()
protein_df %>% 
  filter(Ratio.H.M.Sig <= 0.05)

# Exercise 10.4 (Find top 20 values) ==== 
# Which proteins (i.e. Uniprot IDs) have the 20 highest  
# log2 H/M and M/L ratios?

# HM, positive only
protein_df %>% 
  arrange(-Ratio.H.M)


# HM, either side of zero?
# first, rearrange the data, then take the first 20 rows
protein_df %>% 
  arrange(-abs(Ratio.H.M)) %>% 
  slice(1:20)

# Super handy shortcut
# just take the top n values in a variable
protein_df_HM <- protein_df %>% 
  top_n(20, Ratio.H.M)

# ML:
protein_df_ML <- protein_df %>% 
  top_n(20, Ratio.M.L)

# Exercise 10.5 (Find intersections) ====
intersect(protein_df_HM, protein_df_ML)





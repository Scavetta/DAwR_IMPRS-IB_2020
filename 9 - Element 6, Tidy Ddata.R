# Element 7: Tidyverse -- tidyr ----

# Load packages ----
# This should already be loaded if you executed the commands in the previous file.
library(tidyverse)

# Get a play data set:
PlayData <- read_tsv("data/PlayData.txt")

# Let's see the scenarios we discussed in class:
# Scenario 1: Transformation height & width
PlayData$height/PlayData$width

# For each time point take A/B for height and width
# This is NOT an ideal solution!
PlayData$height[PlayData$time == 1 & PlayData$type == "A"]/PlayData$height[PlayData$time == 1 & PlayData$type == "B"]

# For the other scenarios, tidy data would be a 
# better starting point:
# we'll use gather()
# 4 arguments
# 1 - data
# 2,3 - key,value pair - i.e. name for OUTPUT
# 4 - the ID or the MEASURE variables

# using ID variables ("exclude" using -)
gather(PlayData, "key", "value", -c("type", "time"))

PlayData_t <- pivot_longer(PlayData,                  # the messy data set
                           -c("type", "time"),        # EXCLUDE the ID variables
                           names_to = "key",          # the out for names
                           values_to = "value")       # the out for values


# using MEASURE variables
PlayData_t <- pivot_longer(PlayData,                  # the messy data set
                           c("height", "width"),      # INCLUDE the MEASURE variables
                           names_to = "key",          # the out for names
                           values_to = "value")       # the out for values

# Scenario 2: Transformation across time 1 & 2
# difference from time 1 to time 2 (time point 2-1) for each type and key
# we only want one value as output
PlayData_t %>% 
  group_by(type, key) %>% 
  summarise(time_diff = value[time == 2] - value[time == 1])

# standardize to time 1
# all values for each type and key, divided by time 1
PlayData_t %>% 
  group_by(type, key) %>% 
  mutate(norm = value/value[time == 1])


# Scenario 3: Transformation across type A & B
# A/B for each time and key (same as above)
PlayData_t %>% 
  group_by(time, key) %>% 
  summarise(type_diff = value[type == "A"]/value[type == "B"])

  
  #  group_split()







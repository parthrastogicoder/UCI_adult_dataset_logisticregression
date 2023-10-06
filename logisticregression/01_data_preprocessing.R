
# Purpose: Load data and perform initial preprocessing steps

# Load libraries
library(dplyr)

# Read data
adult <- read.csv('adult_sal.csv')

# Check the head of the data
head(adult)

# Remove unnecessary column
adult <- select(adult, -X)

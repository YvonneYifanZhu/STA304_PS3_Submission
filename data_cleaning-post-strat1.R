#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander and Sam Caetano [CHANGE THIS TO YOUR NAME!!!!]
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(broom) 
library(here)
library(skimr) 
library(tidyverse) 
library(brms)
library(foreign)
# Read in the raw data.
setwd("~/Desktop/PS3")
usa_raw_data <- read.dta("usa_00002.dta")


# Add the labels
usa_raw_data <- labelled::to_factor(usa_raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
usa_data <- 
  usa_raw_data %>% 
  select(
         sex, 
         age,
         empstat
         )


# change column name "sex" to "gender"
names(usa_data)[names(usa_data) == "sex"] <- "gender"
# group age into 4 categories

usa_data[usa_data=="n/a"] <- NA
usa_data<- usa_data[!is.na(usa_data$empstat),]
usa_data<- usa_data[!is.na(usa_data$gender),]
usa_data<- usa_data[!is.na(usa_data$age),]

usa_data[which(usa_data[,2]>17),]

#sample 10000 observation
set.seed(5849)
usa_sample <- usa_data[sample(1:nrow(usa_data) , 10000),]



# Saving the census data as a csv file in my
# working directory


write_csv(usa_sample, "/Users/angelameng/Desktop/PS3/usa_sample.csv")



         
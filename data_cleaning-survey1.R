#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Rohan Alexander and Sam Caetano [CHANGE THIS TO YOUR NAME!!!!]
# Data: 22 October 2020
# Contact: rohan.alexander@utoronto.ca [PROBABLY CHANGE THIS ALSO!!!!]
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
library(broom) 
library(here)
library(skimr) 
library(tidyverse) 
library(brms)
setwd("~/Desktop/PS3")
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("ns20200625.dta")

# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables

  
  
reduced_data <- 
  raw_data %>% 
  select(trump_biden,
         gender,
         age,
         employment)


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?

reduced_data<-
  reduced_data %>%
  mutate(vote_trump = 
           ifelse(trump_biden=="Donald Trump", 1, 0))

attach(reduced_data)
reduced_data <- reduced_data[!is.na(gender), ]
reduced_data <- reduced_data[!is.na(age),]
reduced_data <- reduced_data[!is.na(employment),]

reduced_data[which(reduced_data[,2]>17),]

# group by age (4 category)
age_group <- reduced_data %>% mutate(age_group = case_when(age >=60 ~ "ages60plus",
                                                           age >= 45  & age <= 59 ~ 'ages45to59',
                                                           age >= 30  & age <= 44 ~ 'ages30to44',
                                                           age >= 18  & age <= 29 ~ 'ages18to29 ')) 
reduced_data <- age_group[!is.na(age_group$age_group),]

reduced_data$vote_trump = as.numeric(as.character(reduced_data$vote_trump))
reduced_data %>%
  summarise(raw_trump_prop=sum(reduceddata$vote_trump,na.rm=TRUE)/nrow(reduced_data))

library(plyr)
newEmp <- c("Full-time employed"="employed","Unemployed or temporarily on layoff"="unemployed",
                    "Retired"="not in labor force","Student"="not in labor force",
                    "Homemaker"="not in labor force","Part-time employed"="employed",
            "Self-employed"="employed","Other:"="not in labor force","Permanently disabled"="not in labor force")
reduced_data$employment <-  revalue(reduced_data$employment, newEmp)

reduced_data$gender <- tolower(reduced_data$gender)

names(reduced_data)[names(reduced_data) == "employment"] <- "empstat"

# Saving the survey/sample data as a csv file in my
# working directory
getwd()

write_csv(reduced_data, "/Users/angelameng/Desktop/PS3/survey_data.csv")








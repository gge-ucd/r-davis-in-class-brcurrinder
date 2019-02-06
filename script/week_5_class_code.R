#Week 5 class code

install.packages("tidyverse")

library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

#select is used for selecting columns in a data frame
select(surveys, plot_id, species_id, weight)

#filter is used for selecting rows
filter(surveys, year == 1995)

surveys2 <- filter(surveys, weight < 5)

surveys_sml <- select(surveys2, species_id, sex, weight)

#Pipes %>% (Command-Shift-M on Mac) - a simpler, faster way to do steps above
#Can think of %>% as the word "then" OR can think of as "takes the thing on the left and places it in the next argument
surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

#Challenge
surveys_challenge <- surveys %>%
  filter(year < 1995) %>% 
  select(year, sex, weight)

#Mutate is used to create new columns
surveys <- surveys %>%
  mutate(weight_kg = weight/1000) %>% 
  mutate(weight_kg2 = weight_kg * 2)
  
#Exclamation points = "not"
surveys %>% 
  filter(!is.na(weight)) %>% #filtering out NAs
  mutate(weight_kg = weight/1000) %>% 
  summary()
#Can also use complete.cases to get rid of all NAs in a data frame

#Challenge: Create a new data frame from the surveys data that meets the following criteria: contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30.
surveys %>%
  filter(!is.na(hindfoot_length)) %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>%
  filter(hindfoot_half < 30) %>% 
  select(species_id, hindfoot_length)

#group_by is good for split-apply-combine; often used with summarize - spits out a new data frame
surveys %>%
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

#mutate adds new columns to an existing data frame 
surveys %>%
  group_by(sex) %>% 
  mutate(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  view()

surveys %>% 
  filter(is.na(sex)) %>% 
  view() #way to look at all the NAs in the data frame

#tally to get numbers for specific groups, including NAs
surveys %>% 
  group_by(species) %>% 
  filter(is.na(sex)) %>% 
  tally()
  
#Using group_by with multiple columns - results in some NaN values (not a number); can remove with filter(is.na)
#added two new columns -- mean weight and min weight
surveys %>%
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight), min_weight = min(weight)) %>% 
  view()

#tally function - same as group_by(summarize(new_column = n()))
surveys %>% 
  group_by(sex, species_id) %>% 
  tally() %>% 
  view

#Spreading -- takes a long format data frame and makes it a wide format data frame
surveys_gw <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight)) %>% 
  view()

#Now want each genus from above to be its own columns
surveys_spread <- surveys_gw %>%
  spread(key = genus, value = mean_weight)

surveys_gw %>%
  spread(genus, mean_weight, fill = 0) %>%  #fills NAs with 0
  view()

#Gathering essentially does the reverse of spreading
surveys_gather <- surveys_spread %>% 
  gather(key = genus, value = mean_weight, -plot_id) %>% #use values from these columns, but not plot_id
  view()

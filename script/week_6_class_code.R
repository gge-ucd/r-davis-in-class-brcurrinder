#Week 6 code

library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")

####Finishing up dplyr ===============
#Take all NAs out of weight, hindfoot_length, and sex columns

surveys_complete <- surveys %>%
  filter(!is.na(weight), !is.na(hindfoot_length), !is.na(sex))

#Remove species with less than 50 observations

species_counts <- surveys_complete %>% 
  group_by(species_id) %>% 
  tally() %>% 
  filter(n >= 50)

surveys_complete <- surveys_complete %>% 
  filter(species_id %in% species_counts$species_id)

species_keep <- c("DM", "DO") #example of list we could use instead of the row in a dataframe

#Writing your dataframe to .csv

write_csv(surveys_complete, path = "data_output/surveys_complete.csv")

####ggplot ===================
#ts tab = time/date
#Tue Feb 12 14:31:31 2019 ------------------------------

#ggplot(data = DATA, mapping = aes(MAPPINGS)) + 
  #geom_function()

ggplot(data = surveys_complete)

#Define a mapping

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

#Saving a plot object

surveys_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

surveys_plot +
  geom_point()

#Challenge with hexbin plot -- good for dense plots with lots of data, but lower resolution

install.packages("hexbin")
library(hexbin)

surveys_plot +
  geom_hex()

#Building plots from the ground up
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) #the "global" framework

#modifying whole geom appearances
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "tomato") #the "local" modifications

#using data in a geom
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id)) #set color to species_id

#putting color as a global aesthetic
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length, color = species_id)) + 
  geom_point(alpha = 0.1)

#using a little jitter
surveys_complete %>% 
  ggplot(aes(x = weight, y = hindfoot_length, color = species_id)) + 
  geom_jitter(alpha = 0.1)

#boxplots
surveys_complete %>% 
  ggplot(aes(x = species_id, y = weight)) +
  geom_boxplot()

#adding points to boxplot
surveys_complete %>% 
  ggplot(aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.05, color = "tomato") +
  geom_boxplot(alpha = 0)

#plotting time series
yearly_counts <- surveys_complete %>% 
  count(year, species_id)

yearly_counts %>% 
  ggplot(aes(x = year, y = n, group = species_id, color = species_id)) + #group by species id
  geom_line()

#faceting - makes a subplot for each grouping variable (makes a panel of graphs)
yearly_counts %>% 
  ggplot(aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~species_id) 

#including sex
yearly_sex_counts <- surveys_complete %>% 
  count(year, species_id, sex)

#themes for plots - search for other ggplot themes
ysx_plot <- yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~species_id) +
  theme_bw() +
  theme(panel.grid = element_blank()) #get rid of grid

ysx_plot + theme_minimal()
ysx_plot + theme_excel()
ysx_plot + theme_tufty() #Tufty is data visualization guy

#More faceting
yearly_sex_weight <- surveys_complete %>% 
  group_by(year, sex, species_id) %>% 
  summarize(avg_weight = mean(weight))
  
yearly_sex_weight %>% 
  ggplot(aes(x = year, y = avg_weight, color = species_id)) +
  geom_line() +
  facet_grid(. ~ sex)#facet_grid(row ~ column) --- period is used to say there's only one grouping to use (sex)

#adding labels
yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~species_id) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  labs(title = "Observed Species Through Time", x = "Year of Observation", y = "Number of Species") +
  theme(text = element_text(size = 16)) +
  theme(axis.text.x = element_text(color = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5))

ggsave("figures/my_test_facet_plot.pdf", height = 8, width = 8) #saves the last plot made in the script


#comment on Nalina Nan
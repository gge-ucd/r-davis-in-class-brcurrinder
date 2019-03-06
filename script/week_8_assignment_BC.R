#week 8 assignment

library(tidyverse)
library(lubridate)

am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)

#### Part 1 ####

#Paste date and time columns together
am_riv$datetime <- paste(am_riv$Date, " ", am_riv$Time, sep = "")
glimpse(am_riv)

#Converting to datetime data
am_riv$datetime <- ymd_hms(am_riv$datetime)

#Make new column for week
am_riv$wk <- week(am_riv$datetime)

#Calculate mean, max, and min for weekly temperatures
am_riv2 <- am_riv %>% 
  group_by(wk) %>% 
  summarize(mean_wk = mean(Temperature), min_wk = min(Temperature), max_wk = max(Temperature))
glimpse(am_riv2)

#Plotting the mean, max, and min temps
am_riv2 %>% 
  ggplot()+
  geom_point(aes(x=wk, y = mean_wk), color = "red")+
  geom_point(aes(x=wk, y = min_wk), color = "green")+
  geom_point(aes(x=wk, y = max_wk), color= "blue")+
  xlab("Week")+ ylab("Temp")+
  theme_bw()

#New columns for hour and month
am_riv$hourly <- hour(am_riv$datetime)
am_riv$month <- month(am_riv$datetime)

#Mean hourly level for April-June
am_riv3 <- am_riv %>% 
  filter(month == 4 | month == 5 | month == 6) %>% 
  group_by(hourly, month, datetime) %>% 
  summarize(mean_level = mean(Level))

#Plot of mean hourly level from April_June
am_riv3%>% 
  ggplot()+
  geom_line(aes(x=datetime, y = mean_level), color = "blue") +
  ylim(1.1, 1.9)+
  theme_bw()


#### Part 2 ####

load("data/mauna_loa_met_2001_minute.rda")

#Make a datetime column
mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

glimpse(mloa_2001)

#Convert to datetime format
mloa_2001$datetime<- ymd_hm(mloa_2001$datetime) 

#Remove NAs
mloa2 <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m!= -99, temp_C_2m != -999) %>% 
  filter(windSpeed_m_s!= -99, windSpeed_m_s != -999)

#New function
plot_temp <- function(monthtoinput, dat = mloa2){
  df <- filter(dat, month == monthtoinput)
  plot <- df %>% 
    ggplot()+ geom_line(aes(x=datetime, y = temp_C_2m), color = "blue") +
    theme_bw()
  return(plot)
}

#Plot of just April (4th month) temperatures 
plot_temp(4)

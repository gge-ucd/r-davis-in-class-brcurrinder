#Week 8 Class Code

library(lubridate)
library(tidyverse)

load("data/mauna_loa_met_2001_minute.rda")

#lower case y is for 2 digit year, upper case Y is for 4 digit year
as.Date("02-01-1998", format = "%m-%d-%Y")

mdy("02-01-1998")

#as.POSIXct - for dates and times, time zones
tm1 <- as.POSIXct("2016-07-24 23:55:26 PDT")
tm1

tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S")
tm2

tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT")
tm3

#specifying timezone and date format in the same call
tm4 <- as.POSIXct(strptime("2016/04/04 14:47", format = "%Y/%m/%d %H:%M", tz = "America/Los_Angeles"))
tm4

tz(tm4)

Sys.timezone() #default timezone on your computer

#Do the same thing with lubridate

ymd_hm("2016/04/04 14:47", tz = "America/Los_Angeles")

ymd_hms("2016-05-04 22:14:11", tz = "GMT")

nfy1 <- read_csv("data/2015_NFY_solinst.csv", skip = 12)

nfy2 <- read_csv("data/2015_NFY_solinst.csv", skip = 12, col_types = "ccidd")
nfy2

#how to change just one column
nfy3 <- read_csv("data/2015_NFY_solinst.csv", skip = 12, col_types = cols(Date = col_date()))
nfy3

glimpse(nfy2)

#matching date and time together using paste
nfy2$datetime <- paste(nfy2$Date, " ", nfy2$Time, sep = "")

nfy2$datetime <- ymd_hms(nfy2$datetime, tz = "America/Los_Angeles")

glimpse(nfy2)

#mauna loa data

summary(mloa_2001)

mloa_2001$datetime <- paste(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

ymd_hm(mloa_2001$datetime)

#Challenge - plot mean temp
mloa2 <- mloa_2001 %>%
  filter(rel_humid != -99 & -999) %>% 
  filter(temp_C_2m != -99 & -999) %>% 
  filter(windSpeed_m_s != -99 & -999)
mloa2

mloa3 <- mloa2 %>%
  mutate(which_month = month(datetime, label = TRUE)) %>% 
  group_by(which_month) %>% 
  summarise(avg_temp = mean(temp_C_2m))

mloa3 %>% ggplot() +
  geom_point(aes(x = which_month, y = avg_temp), size = 3, color = "blue") +
  geom_line(aes(x = which_month, y = avg_temp, group = 1))

####FUNCTIONS####

my_sum <- function(a = 1, b = 2){ #defaults are 1 and 2
  the_sum <- a + b
  return(the_sum)
}

my_sum()
my_sum(3, 7)
my_sum(b=8)

#convert K to C (subtract 273.15)
bry_func <- function(K){
  Celsius_temp <- K - 273.15
  return(Celsius_temp)
}

bry_func(10)


####Iteration####
x <- 1:10
log(x)

#For loops
  #i is an object

for(i in 1:10){
  print(i)
}

for(i in 1:10){
  print(i)
  print(i^2)
}

#can use the i value as an index
for(i in 1:10){
  print(letters[i])
  print(mtcars$wt[i])
}

#sometimes want to save results from a for loop
  #make a results vector ahead of time

results <- rep(NA, 10)

for(i in 1:10){
  results[i] <- letters [i]
}

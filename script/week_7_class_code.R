#Week 7 Class Code

#how to install a package from github
install.packages("devtools")
library(devtools)

devtools::install_github("thomasp85/patchwork") #user name on github/name of package

#### Data Import and Export ####

install.packages("tidyverse")
library(tidyverse)

#skipping lines of data
wide_data <- read_csv("data/wide_eg.csv", skip = 2)

#loading and saving .rda and .rds files
#loaded an RDA file that contained a single R object
load("data/mauna_loa_met_2001_minute.rda")

#write wide_data to an RDS file
saveRDS(wide_data, "data/wide_data.rds")

#remove wide_data
rm(wide_data)

#RDS files are good for if you want to store a single object -- e.g. good for saving model outputs
#RDS files only work with R
wide_data_rds <- readRDS("data/wide_data.rds")

#other packages: readxl, googlesheets, googledrive, foreign (for reading in weird files), rio

#### Working with Dates and Times ####

install.packages("lubridate")
library(lubridate)

sample_dates1 <- c("2016-02-01", "2016-03-17", "2017-01-01")

#as.Date looking for data that looks like YYYY-MM-DD
as.Date(sample_dates1)

sample_dates2 <- c("02-01-2001", "04-04-1991")

#if not in YYYY-MM-DD format, can change format in as.Date
as.Date(sample_dates2, format = "%m-%d-%Y") #upper case Y

as.Date("2016/01/01", format = "%Y/%m/%d")

as.Date("Jul 04, 2017", "%b%d, %Y") #b instead of m for month; strptime for other variations on b

#Date calculations
dt1 <- as.Date("2017-07-11")

dt2 <- as.Date("2016-04-22")

print(dt1 - dt2)

#time difference in weeks
print(difftime(dt1, dt2, units = "week"))

six.weeks <- seq(dt1, length = 6, by = "week")

#Challenge - create a sequence of 10 every 2 weeks

challenge <- seq(dt1, length = 10, by = 14)
#OR
challenge2 <- seq(dt1, length = 10, by = "2 week")

#Lubridate package

ymd("2016/01/01")
dmy("04.04.91")
mdy("Feb 19, 2005")

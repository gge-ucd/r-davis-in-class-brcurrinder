#Intro to DataFrames

download.file(url = "https://ndownloader.figshare.com/files/2292169", destfile = "data/portal_data_joined.csv")

surveys <- read.csv(file = "data/portal_data_joined.csv")

#data structure
head(surveys) #first 6 rows
str(surveys)
dim(surveys)
nrow(surveys)
ncol(surveys)
tail(surveys) #last 6 rows
names(surveys) #names of columns
rownames(surveys)
summary(surveys) #more of a stastical look at each column

#subsetting vectors
animal_vec <- c("mouse", "rat", "cat")
animal_vec[2]

#subsetting dataframes -- dataframes are 2D
surveys[1,1] #row, column
head(surveys)
surveys[2,1]
surveys[33000,6]
surveys[,1] #output is every row in the first column as a VECTOR

surveys[1] #output is every row in the first column as a DATAFRAME
head(surveys[1])

surveys[1:3,6] #first three rows of sixth column

animal_vec[c(1,3)]
1:3 #acts as a vector

#pull out a whole single observation as a dataframe
surveys[5,]

#negative sign to exclude indices
surveys[1:5, -1] #excludes the first column
surveys[-10:34786,] #R wants to expand into a vector, but can't with negative sign
surveys[-c(10:34786),] #excludes all rows after row 10 by using a vector
surveys[c(10,15,20),] #just 10th, 15th, and 20th rows
surveys[c(10,15,20,10),] #gives you the 10th row again (as 10.1)

#more ways to subset
names(surveys)
surveys["plot_id"] #single column as data frame
surveys[,"plot_id"] #single column as vector
surveys[["plot_id"]] #double brackets -- single column as a vector, will be more useful when using lists

surveys$year #single column as a vector; not as flexible as [] subsetting when doing multiple steps

#challenge
surveys_200 <- surveys[200,] #pull out just the 200th row
surveys_last <- surveys[nrow(surveys),] #pull out just the last row
surveys_last
surveys_middle <- surveys[nrow(surveys)/2,] #pull out just the middle row
surveys_middle
surveys_head <- surveys[-c(7:nrow(surveys)),] #mimics head(surveys) by excluding 7th column and above
head(surveys)

#factors - stored as integers with labels assigned to them
surveys$sex

#creating our own factor
sex <- factor(c("male", "female", "female", "male")) #1 assigned to female, 2 assigned to male
sex 
class(sex) #factor - the lower level attribute
typeof(sex) #integer - the higher level attribute

levels(sex) #gives back a character vector of the levels
levels(surveys$genus) 
nlevels(sex)

concentration <- factor(c("high", "medium", "high", "low"))
concentration

concentration <- factor(concentration, levels = c("low", "medium", "high"))
concentration                          

#adding to a factor
concentration <- c(concentration, "very high") #R doesn't like this - it coerces to characters if you add values that don't match a current level
concentration

as.character(sex)

#factors with numeric levels
year_factor <- factor(c(1990, 1923, 1965, 2018)) #assigned 
year_factor
as.numeric(year_factor) #gives back integers
as.character(year_factor) #gives back levels as characters
as.numeric(as.character(year_factor)) #gives back levels as numeric vector

#why all the factors?
surveys_no_factors <- read.csv(file = "data/portal_data_joined.csv", stringsAsFactors = FALSE)
str(surveys_no_factors)

#recommended way
as.numeric(levels(year_factor))[year_factor]

#renaming factors
sex <- surveys$sex
levels(sex)[1] <- "undetermined"
levels(sex)
head(sex)

#working with dates
library(lubridate)
install.packages("lubridate")
my_date <- ymd("2015-01-01") #stores as a date
my_date
str(my_date)

my_date <- ymd(paste("2015", "05", "17", sep = "-"))
my_date

paste(surveys$year, surveys$month, surveys$day, sep = "-") #pastes all date columns together with dashes

surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
surveys$date
surveys$date[is.na(surveys$date)]

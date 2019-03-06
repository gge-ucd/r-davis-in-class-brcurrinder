#week 9 class code

#### Iteration ####

#For "sapply" --- first argument is the data/thing you want to iterate across, and the second argument is the function you want to apply to each thing
sapply(1:10, sqrt) 
sqrt(1:10)

#for loop first
result <- rep(NA, 10)

for(i in 1:10){
  result[i] <- (sqrt(i)/2)
}

#now to use sapply - a little bit cleaner
result_apply <- sapply(1:10, function(x) sqrt(x)/2)
result_apply

#additional arguments in sapply
mtcars_na <- mtcars
mtcars_na[1, 1:4] <- NA

sapply(mtcars_na, mean)
sapply(mtcars_na, mean, na.rm = TRUE) #mean of all columns
mean(mtcars_na$mpg, na.rm = T) #mean of just one column

# Back to Tidyverse
library(tidyverse)

mtcars %>%
  map(mean) #non-numeric vector

mtcars %>% 
  map_dbl(mean) #for numeric vector

mtcars %>% 
  map_chr(mean) #for character vector

#map2_ for two sets of inputs
map2_chr(rownames(mtcars), mtcars$mpg, function(x,y) paste(x, "gets", y, "miles per gallon"))

#complete workflow - specific code, pull out general code, make into a function, iterate
#attempt to scale our weights of mtcars
(mtcars$wt[1] - min(mtcars$wt)) / (max(mtcars$wt) - min(mtcars$wt))

#generalize
(x - min(x)) / (max(x) - min(x))

#make the above into a function
rescale_01 <- function(x){
  (x - min(x)) / (max(x) - min(x))
}

rescale_01(mtcars$wt)

#iterating
map_df(mtcars, rescale_01) #gives back a dataframe



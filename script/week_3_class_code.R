read.csv("data/tidy.csv")

#vectors

weight_g <- c(50, 60, 31, 89)
weight_g

#now characters

animals <- c("mouse", "rat", "dog", "cat")
animals

#vector exploration tools
length(weight_g)
length(animals)

class(weight_g)
class(animals)

str(weight_g)
str(animals)

#be careful about running line multiple times
weight_g <- c(weight_g, 105)
weight_g

weight_g <- c(25, weight_g)
weight_g

#6 types of atomic vectors: "numeric" ("double"), "character", "logical", "integer", "complex" (imaginary numbers, etc.), "raw" (zeros and ones)

typeof(weight_g)

#challenge
#Hierarchy of vector types: character -> numeric -> integer -> logical
  #"character" type wins through coercion
  
num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
num_logical2 <- c(1, 2, 3, FALSE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

combined_logical <- c(num_logical, char_logical)

#subsetting vectors

animals[3]

animals[c(2, 3)]
animals[c(3, 1, 3)]

#conditional subsetting
weight_g
weight_g[c(F, T, T, F, T, T)]
weight_g > 50
weight_g [weight_g > 50]

#multiple conditions
weight_g[weight_g < 30 | weight_g > 50]
weight_g[weight_g >= 30 & weight_g == 89]

#searching for characters
animals[animals == "cat" | animals == "rat"]
animals %in% c("rat", "antelope", "jackalope", "hippogriff")
animals[animals %in% c("rat", "antelope", "jackalope", "hippogriff")]

#challenge
  #alphabetic order
"four" > "five"
"a" > "b"

#missing values
heights <- c(2, 4, 4, NA, 6)
str(heights)

mean(weight_g)
mean(heights)
max(heights)

mean(x = heights, na.rm = TRUE)
max(heights, na.rm = TRUE)

is.na(heights)
na.omit(heights)
complete.cases(heights)    #for grabbing all complete data, not incomplete data

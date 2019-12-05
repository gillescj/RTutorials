# R Basics

# All comments have a hashtag infront of them. These lines are ignored by RStudio when running code

# This is a script that communicates with the Console (Down Below) to read and execute the code.
# You can use R in the Console as well.

# Press CTRL-ENTER to run through each line. You can also hilight certain code and press CTRL-ENTER
# to run only the highlighted portion. To run all the code in the script press CTRL-SHIFT-ENTER.



# ASSIGNMENT ---------------------------------------------------------------



# Create a new variable called 'a' and give it the numeric value of 74. 
# You can read this as 74 goes into 'a'.
a <- 74

# Call 'a', the Console in the bottom should display '[1] 74'.
# 'a' should now be in the global envirornment to the top right. The global envirornment is kind of
# like a warehouse of all the values we have created so far. R remembers these values so we can use
# them for later. If you want to reset the global envirornment, click the little broom in the same area.
a

# We can use this variable in many ways, Console should now say 792.8571
((1 + a)/7) * a
((1 + 74)/7) * 74

# We can add in more variables
b <- 1
c <- 7

((b + a)/7) * a

# We can also save values over an existing variable, it will take on the last value that was passed into it.
# 'a' now has the value of 740 in the global envirornment. The value of 74 is not in 'a' anymore.
a <- 740

# variables don't just have to hold numeric values. 
# They can hold text (aka strings/characters), factors, dataframes (tables), 
# logicals/booleans (TRUE or FALSE), vectors, and more complicated objects (example: time series objects)

# To assign text to a variable use Quotations around the text you want to save. 
# This is known as a String, or a Character.
welcome_text <- "Hello World"
welcome_text

# To see what type of value a variable has you can use typeof(), or you can look at the global environment

typeof(welcome_text)

# Double is a numeric value
typeof(a)



# VECTORS ---------------------------------------------------------------



# Here I'm using the combine function c() to create a vector of 4 values 
# and saving it as the variable called "combined". 

combined <- c(-2,19,0,64,-100,45)

# I can pull out elements from this vector by calling the index number. 
# combined[2] gives me the second element in the vector (so 19)
combined[2]

# Like Excel, the ':' can be used to give a range of values
combined[2:5]

# I can save the output of a vector's elements into a new variable..
element4 <- combined[4]

# and then use that new variable any way I want. (sqrt is the square root function).
# Read this as "I would like to perform the function named square root on the value inside element4"
sqrt(element4)

# We can also assign new values for the elements in the vector
combined[2] <- 6

# or add more to the end of the vector, using the append function
combined <- append(combined,777)



# FUNCTIONS ----------------------------------------------------------------



# General format: function (first argument, second argument, third argument, ...)
#                 f (arg1, arg2, arg3)
# Some functions have optional arguments you can add, other functions need no arguments
#
# If there is any confusion about what a function does, you can type ?functionName in the Console 
# to bring up the HELP for definitions and examples. 

?c()
?sqrt
?append

# Functions are very useful in simplifying your script. You can even create your own functions.
# For example, look at this useless function I made:
# The function name is 'add', the first argument takes in a value, 
# and the second argument takes in what you want to add to that value.
# the function returns (spits out) the new value.

add <- function (a_value, add_by) { 
  plus <- a_value + add_by
  return(plus)
} 

add(51,2)
add(c(2,4,6,8,10), 7)


# R has a very large library of packages with useful functions, so before you make your own,
# see if there already exists one within R. No point in reinventing the wheel.



# LOGICALS/BOOLEANS -------------------------------------------------------------------



# Logical values can either be True or False

# Use operators to create logical values:
# Greater than: > , Less than: < , Equal to: == , NOT: ! 
# AND: && , OR: || , ENTRY WISE AND: & , ENTRY WISE OR: |
# Operators in combination with logicals are called 'expressions' and will return back a logical value

# Some sample expressions:

1 == 1 # Is the number 1 equal to the number 1? TRUE
2 > 4
20 < 50
"a" == "a"  # Can compare more than just numbers

c(1,2,3) == c(1,9,6)  # Entry Wise equals, goes through each element in the two vectors and compares them
                      # If you want to compare whole vectors (or objects), use identical()
identical(c(1,2,3),c(1,9,6))
identical(c(1,2,3),c(1,2,3))

"ab" != "ac"
3 != 3
1 <= 5
3 >= 70

TRUE == TRUE
FALSE == TRUE
!FALSE == TRUE

(FALSE == FALSE) == TRUE
(2 > 7) == (20 < 16)

# AND, OR are very famous operators. 
# All values must be true for AND to return TRUE:
TRUE & TRUE
TRUE & FALSE
FALSE & TRUE
FALSE & FALSE

# You only need One True value in the expression for OR to return TRUE:
TRUE | TRUE
TRUE | FALSE
FALSE | TRUE
FALSE | FALSE


# If Statements
# If Statements use expressions to choose which code to run.

# if (expression) {statement1} else {statement2}
# when expression is equal to TRUE, run statement1, otherwise run statement2

# If Else / Nested Ifs
# if (expression) {statement2} else if (expression2) {statement2} ... else {statementN}
# Elseif needs an expression just like if. Else needs no expression.

# Examples

if (TRUE) {
  print("This is True")
} else {
  print("This is False")
}


if (3 > 7) {
  print("This is True")
} else {
  print("This is False")
}


if (typeof(a) == "double") {
  print("a is of double type")
} else {
  print("a is not of double type")
}


number1 <- 5
if  (sign(number1) == 1) {
  print("number1 is positive")
  
} else if (sign(number1) == -1) {
  print("number1 is negative")
  
} else {
  print("number1 is zero")
}


# Logicals are very useful in filtering data


# LISTS ----------------------------------------------------------------------------



# Lists are like flexible vectors, but they are not as restrictive with what values you can put into them.
# Lists can have different types of values in them, where vectors can only have one type of value.

# Creating a list using list()
aReallyCoolList <- list(4,90,TRUE,"pizza")

# Indexing a value for a list requires two square brackets
aReallyCoolList[[2]]
aReallyCoolList[[4]]


#Comparison between c() and list():

myList <- list(1,"cheese",FALSE)
typeof(myList[[1]])
typeof(myList[[2]])
typeof(myList[[3]])

myVector <- c(1, "cheese", FALSE)
# Because the c() can only have one type, it converts all values to characters
typeof(myVector[1])
typeof(myVector[2])
typeof(myVector[3])

# doing calculations on lists can be more time consuming and less efficient (or impossible)
# compared to vectors because of this added flexibiity.


# If you want to go down the rabbit hole of crazy indexing, you can make lists of lists
l1 <- list(c(100,200,300),"texttext",45)
l2 <- list("more text",19)
l3 <- list(list("a","b","c","d","e"), 18, TRUE, "f")

listofLists <- list(l1,l2,l3)

listofLists[[2]][[1]]   # Retrieving l2 from listofLists and the first element from l2
listofLists[[1]][[1]][3]
listofLists[[3]][[1]][[5]]



# DATAFRAMES (TABLES) ---------------------------------------------------------------



# You can make your own dataframe/table directly. 
DF1 <- data.frame("column1" = 6, "column2" = 2, "c3" = FALSE)

# adding rows to it
DF1 <- rbind(DF1, list(2,6,FALSE))
DF1 <- rbind(DF1, list(0,0,TRUE))

# You can also add columns. Notice how each column can have a different type.
DF1$column4 <- c("aa","bb","cc")
DF1$column5 <- c(1,54,2)

# You can edit the column names of a dataframe
DF1 <- setNames(DF1, c("c1","c2","c3","c4","c5"))


# This gets cumbersum for large datasets, usually you'll be reading in a file and
# converting it into a dataframe.

# read.csv reads a file in table format and creates a data frame of it.
# Make sure city_populations.csv is in the same directory as RTutorial.r, then
# Go to Session (Top Menu) -> Set Working Directory -> Source File Location

# create the data frame called city_pop by reading in the contents of a csv file.
city_pop <- read.csv("city_populations.csv", header = TRUE)

# You can pull a specific column by using '$'
city_pop$Population

# city_pop[,], city_pop[], and city_pop output the entire table/dataframe
# it is also viewable by clicking the 'city_pop in the envirornment window to the top right
city_pop[]

# Since a dataframe is a 2 dimensional object, you need to specify 2 indices when referencing a cell.
# dataFrame[row number, column number] 
# Example: retrieve the third row value from the second column in city_pop
city_pop[3,1]

# retrieve ALL columns from row 7 (So return row 7)
city_pop[7,]

# Retrieve rows 60 to 79 and display the first, second, and forth column for each of these rows.
city_pop[60:79,c(1,2,4)]

# retrieve ALL row values from the third column
city_pop[,3]

# Using the column name instead of the index number to get the same result as city_pop[,3]
city_pop[,"City"]


# You can filter by a column's value 

# Read as: Give me the rows where the City column is equal to "Brussels"
city_pop[city_pop$City == "Brussels",]

# Read as: Give me the rows where the Population Column is greater then 45,000
city_pop[city_pop$Population > 45000,]

# Read as: Give me the rows where the Population Column is greater then 45,000, 
# and only give the City Names and Date
city_pop[city_pop$Population > 45000,c("City","Date")]



# USEFUL FUNCTIONS to use on dataframes -----------------------------------------------------------

# head shows the first few observations (rows) in the dataframe
head(city_pop)

# str (structure) gives the data types of each column (int and Factor in this case) 
# as well as some of the first few observations just like head
str(city_pop)

# summary gives information depending on the data type of the column.
summary(city_pop)

# split creates a list of dataframes seperated by a function. 
# In this example I have split the dataframe into parts for each City
city_pop_list <- split(city_pop, f = city_pop$City)

# aggregate
# In this example I am getting the averages of populations for each date
aggregate(city_pop$Population, by = list(city_pop$Date), mean)

# table
# similar to aggregate but for counting.
# table is it's own type, it is easy to convert into a dataframe using as.data.frame though.
number_of_months_recorded <- as.data.frame(table(city_pop$City))

# In this example I am getting the sum of populations for each City, then naming it as 'city_pop_sums'
city_pop_sums <- setNames(aggregate(city_pop$Population, by = list(city_pop$City), sum),c("City","Population Sum"))


# Writing to a csv
write.csv(city_pop_sums,"Population by City, 2020-2021.csv")










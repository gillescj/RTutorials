# R Tutorial 2 

# ggplot2 for any plotting, install the ggplot2 package 
# and then turn it on in the library, once a package is installed, it does not need to be reinstalled

# for running the first time, uncomment the line bellow
# install.packages("ggplot2")
library("ggplot2")

# R has built in datasets for learning and testing: 
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html
# trees is a dataframe for 31 observations of Diameter, Height and Volume for Black Cherry Trees
treeDF <- trees



# PLOTTING AND LINEAR REGRESSION ----------------------------------------------------------------------



# scatterplot of treeDF: x-axis is Girth of each Tree, y-axis is Volume
# ggplot is a function from the ggplot2 package, aes stands for aesthetics
# geom_point specifies that you want a scatter plot, shape specifies what the points will look like.
ggplot(treeDF, aes(x = Girth, y = Volume)) + geom_point(shape=1) + labs(title = "Tree Girth vs. Tree Volume")

# Same scatterplot but with a line of best fit.
ggplot(treeDF, aes(x = Girth, y = Volume)) + geom_point(shape=1) + geom_smooth(method=lm, se=FALSE) +
  labs(title = "Tree Girth vs. Tree Volume")

# Same scatterplot but with a line of best fit AND standard error at 95% confidence interval
ggplot(treeDF, aes(x = Girth, y = Volume)) + geom_point(shape=1) + geom_smooth(method=lm, se=TRUE) + 
  labs(title = "Tree Girth vs. Tree Volume - 95% CI")

# Same scatterplot but with a line of best fit AND standard error at 99% confidence interval
ggplot(treeDF, aes(x = Girth, y = Volume)) + geom_point(shape=1) + geom_smooth(method=lm, level=0.99) + 
  labs(title = "Tree Girth vs. Tree Volume - 99% CI")


# It looks like Girth and Volume have a correlation, let's check the correlation using cor()
cor(treeDF$Girth, treeDF$Volume)

# Linear Regression Test between Girth and Volume, x = Girth, y = Volume
# lm stands for linear model, 
# Read as: Create a linear model object using the treeDF dataframe. Independent variable is equal to
# the Girth column, dependent variable is equal to the Volume column.
# lm(Y ~ X1 + X2 + X3 +...., data)
treelm <- lm(Volume ~ Girth, data = treeDF)

# Summary of the linear model for treeDF. Most information about the regression test can be found here.
summary(treelm)

# Saving summary as a variable to pull out information:
treelmSum <- summary(treelm)
treelmSum$r.squared
treelmSum$adj.r.squared
treelmSum$coefficients # t-value, p-value
confint(treelm) #  95% Confidence interval

# plotting a lm gives different plots of the residuals
plot(treelm, ask = FALSE)


# Multiple Regression:

# lm works for multiple regression aswell
# lm(Y ~ X1 + X2 + X3 +...., data)
treeMultlm <- lm(Volume ~ Girth + Height, data = treeDF)
summary(treeMultlm)



# LOOPS ------------------------------------------------------------------------------------------



# Loops do the same thing over and over again until a condition is met. 
# They allow you to automate parts of code that are repetitive.

# Examples: 


# make a random vector
vector1 <- c(4,3,5,7,8,3,80,30)

# set a count variable to zero
count <- 0

# This 'for' loop counts how many 3's are in vector1
# Read as: For all the values in vector1, if they are equal to 3 then add one to the count.
for (value in vector1){
  
  if (value == 3) {count = count + 1}
}

count



# Creating a vector of 1000 random numbers, normally distributed around a mean of 100 
# with standard deviation = 10
random_nums <- floor(rnorm(1000, mean = 100, sd = 10))

# set the count to zero
count <- 0

# Count number of occurances of the value 101 in the vector random_nums
# (how many times does the number 101 occur in this vector?)
for (num in random_nums){
  if (num == 101) count = count + 1
}

count



# make a random vector
vector2 <- c(100,200,300,400,500,600)
# Creating an empty vector
vector2copy <- c()

# Create a copy of vector2
# 'i' will start at one and then increment by one until it reaches 6
for (i in 1:(length(vector2))) {
  vector2copy <- append(vector2copy,vector2[i])
}

vector2 == vector2copy



# THE PIPE OPERATOR  %>% -----------------------------------------------------------------------
# f(x) can be written as x %>% f


# Since the pipe operator is so popular in R, it is worth having a section explaining it.
# To use the pipe operator install and turn on the dyplr package

# for running the first time, uncomment the line bellow
# install.packages("dplyr")
library("dplyr")


# It can sometimes be hard to read what a line of code is 
# doing when multiple functions are being used at once 

# Example

# In this case you have to look inside all the brackets at the start
# then work your way outward to see what the function actually does
changed_numbers <- as.data.frame(round(log(sqrt(abs(c(2.9,3.4,1.9,-8.4,6.2,11.2,8.8,-3)))),3))

# Too long of a line like this and it becomes very difficult to read. 

# One way to make it more understandable is to break each part of it up.
stat_numbers <- c(2.9,3.4,1.9,-8.4,6.2,11.2,8.8,-3)
abs_stat_nums <- abs(stat_numbers)
sqrt_abs_stat_nums <- sqrt(abs_stat_nums)
logarithms <- log(sqrt_abs_stat_nums)
logs_rounded <- round(logarithms, 3)

changed_numbers2 <- as.data.frame(logs_rounded) 

# This is more a lot easier to follow, but creates a lot of varibles that we will probably never use again.


# If only there was a happy medium? Cue in the pipe operator


# The pipe operator takes in the values before it 
# and then puts them into the first argument of the function after it

round(2.45,1)       # Normal way
2.45 %>% round(1)   # Pipe Operator

paste("Hello","there","look","at","this", sep = "---")      #Normal Way
"Hello" %>% paste("there","look","at","this", sep = "---")  #Pipe Operator

# Now instead of reading from inside to outside brackets, you read from left to right



changed_numbers_pipe <- 
  c(2.9,3.4,1.9,-8.4,6.2,11.2,8.8,-3) %>% abs() %>% sqrt() %>% log() %>% round(3) %>% as.data.frame()



#################################################################################### END -------









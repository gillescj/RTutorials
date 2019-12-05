# R Tips and Tricks

# Very useful package, includes ggplot2, dplyr, readr and more.
library(tidyverse)

# DPLYR --------

# Pipe operator %>% ++++++++++++++++++++++++++++++++++++++++++++++++++++++

# You can think of the pipe operator as: Put this into that
# Whatever is left of the pipe operator is used as the first argument in the 
# function to the right of the pipe operator.

sum(c(0:10)) # can be written as:
c(0:10) %>% sum()
# put c(0:10) into the sum function

round(12.345,1) # can be written as:
12.345 %>% round(1)
# put 12.245 into the round function

# CTRL + SHIFT + M shortcut for ' %>% '


# DataSet example: mtcars
# type: ?mtcars in Console for explanation of the dataset

cars <- mtcars %>% rownames_to_column("model") # don't worry about rownames_to_columns
cars %>% View() 

# Use View() for quick glance at the table when console isn't showing enough.
# In this case you could just click 'cars' in the global envirornment but View() 
# is useful if you don't want to create a variable just to look at the table so far.
# Feel free to take out View() or add it in where ever.  

# Selecting specific columns of a dataframe +++++++++++++++++++++++++++++++++++

cars %>% select(mpg, cyl, disp) 
cars %>% select(-mpg, -cyl, disp) %>% View()
cars %>% select(contains("mpg")) 
cars %>% select(contains("g")) 

# Filtering specific rows of a dataframe ++++++++++++++++++++++++++++++++++++++

cars %>% filter(mpg > 20)
cars %>% filter(model == "Merc 240D")
cars %>% filter(am == 1) %>% select(model) # These are all manual transmission

# Mutate: Add new columns to dataframe ++++++++++++++++++++++++++++++++++++++++

cars %>% mutate(weight_in_lbs = wt*1000)
cars %>% mutate(mileage = ifelse(mpg > 18, "Good", "Bad"))
cars %>% mutate(brand = word(model,1)) # word() selects the first word of a string

# using the same name as another variable/column will overwrite it
cars %>% mutate(mpg = round(mpg,0))

# We can use mutate_at to overwrite many columns/variables
cars %>% 
  mutate_at(.vars = vars("mpg","disp","drat","wt","qsec"), 
            .funs = list(~round(.,0))) %>% View()
# vars() specifies what columns we want to change
# funs() is the function we want to use on each column, 
# the '.' refers to each column

# We can use mutate_at to create many columns/variables as well.
# Just add a name (in this case 'rounded')
cars %>% 
  mutate_at(.vars = vars("mpg","disp","drat","wt","qsec"), 
            .funs = list('rounded'= ~round(.,0))) %>% View()
# This keeps the old columns and adds the new rounded ones to the df 

# If we wanted to overwrite these columns we wouldn't add a name:
cars %>% 
  mutate_at(.vars = vars("mpg","disp","drat","wt","qsec"), 
            .funs = list(~round(.,0))) %>% View()

# mutate_if searches for columns that follow a logical rule
# This example searches for all numerics and converts them to integers
cars %>% 
  mutate_if(is.numeric, as.integer)

# Rename ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# When cleaning data just imported, you may need to change the column names

cars %>%
  rename("new_column_name" = mpg)

# Multiple renames at once
cars %>% 
  rename("new_mpg" = mpg, "new_model" = model, "new_card" = carb)

# Multiple renames with one function
cars %>% 
  rename_at(.vars = vars("mpg","disp","drat","wt"), .funs = list(~toupper(.)))

cars %>% 
  rename_at(.vars = vars("cyl","hp","am","gear"), .funs = list(~paste0("___",.)))

cars %>%
  rename_if(is.character, .funs = list(~paste0("CHARACTER___",.)))


# Arrange ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Sorting for dplyr
cars %>%
  arrange(mpg)

cars %>% 
  arrange(desc(hp))

# Grouping +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Performing operations by variable values

# seperate cars into two groups, manual transmission cars and automatic,
# then make a new column with the average miles per gallon of each group
cars %>% 
  group_by(am) %>% # Group by cars with manual transmission and automatic
  mutate(avg_mpg = mean(mpg)) %>% View()
# we can see that automatic cars on average have worse mileage than manual

# Compare this to:
cars %>% 
  mutate(avg_mpg = mean(mpg)) %>% View()

# Group by doesn't do much by itself, it is used in combonation with other
# dyply functions like mutate and summarize.

# Summarize/Summarise +++++++++++++++++++++++++++++++++++++++++++++++++++++
# agreggate and condense information (using group_by) 

cars %>%
  group_by(am) %>%
  summarise(avg_mpg = mean(mpg))

# You can summarize by more than one function using summarise_at()
cars %>%
  group_by(am) %>%
  summarise_at(vars(mpg), funs(mean,max,min))

# You can summarise by more than one function AND variable 
# using summarise_all() and select_at()

# summarize_all() takes all variables that are not in group_by 
# and aggregates them by one or more functions

cars %>%
  select_at(vars(am,mpg,hp)) %>%
  group_by(am) %>%
  summarise_all(c("mean", "min", "max"))


# Example Problem 1: +++++++++++++++++++++++++++++++++++++++++++++++++++++++
# I care about mileage and I hate Ford, Fiat and Lincoln. 
# Find me the top 3 car brands by the average mileage of their vehicles.
# Display the results to me in the metric system.

cars %>% 
  mutate(brand = word(model,1)) %>% 
  filter(brand != "Ford", brand != "Fiat", brand != "Lincoln") %>%
  mutate(kpl = 2.35*mpg) %>%
  group_by(brand) %>%
  summarise(avg_kpl = mean(kpl)) %>%
  arrange(desc(avg_kpl)) %>%
  head(3)

# Example Problem 2
# Using the "boston_air_bnb_listings.csv" AirBnb data, find the average 
# rental price by neighbourhood in boston. Also display the number of 
# house listings used in each neighbourhood.

# Source: http://insideairbnb.com/get-the-data.html
bostonbnb <- read_csv("boston_airbnb_listings.csv")

bostonbnb %>% 
  group_by(neighbourhood) %>%
  summarise_at(.vars = vars(price), .funs = funs(mean,n())) %>% 
  arrange(by = mean)

# Also include availability as a variable 
bostonbnb %>% 
  select_at(vars(neighbourhood,availability_365,price)) %>%
  group_by(neighbourhood) %>%
  summarise_all(funs(n(),mean)) %>% 
  View()

# ^ This adds a duplicate number of occurances (n), so lets drop it out

bostonbnb %>% 
  select_at(vars(neighbourhood,availability_365,price)) %>%
  group_by(neighbourhood) %>%
  summarise_all(funs(n(),mean)) %>% 
  select(-availability_365_n) %>%
  rename("n" = price_n) %>%
  View()

# Lets make a simple graph to get a better visual 
# of average prices per neighbourhood

bostonbnb %>% 
  select_at(vars(neighbourhood,availability_365,price)) %>%
  group_by(neighbourhood) %>%
  summarise_all(funs(n(),mean)) %>% 
  select(-availability_365_n) %>%
  rename("n" = price_n) %>%
  ggplot(aes(x = reorder(neighbourhood, price_mean), y = price_mean)) + 
    geom_col() + #want a bar graph
    theme(axis.text.x = element_text(angle = 90)) #rotate x axis label


# RANDOM ------

# Vocabulary to learn:
# http://adv-r.had.co.nz/Vocabulary.html

# Style to follow:
# http://adv-r.had.co.nz/Style.html

# You can use print(n='number') if the console is too
# limited in the number of rows it displays

# Example: tibbles only display 10 rows
trees %>% select(Girth) %>% as_tibble()

# But using print()
trees %>% select(Girth) %>% as_tibble() %>% print(n=40)
trees %>% select(Girth) %>% as_tibble() %>% print(n = nrow(trees))


# Lapply ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# You can use lapply in most cases instead of a for loop 
# (Prefer lapply over sapply as lapply is more reliable)
a_list <- list(a = 1:10, b = 30:50, c = c(TRUE,FALSE,FALSE,TRUE,FALSE))
lapply(a_list, max)

# var is each item in a_list, one at a time
lapply(a_list, FUN = function(var){
  
  if(typeof(var) == "logical"){
    return(all(var))
  }
  return(sum(var))
  
})

sample_vars = cars %>%
  select("cyl", "vs", "am", "gear", "carb") %>%
  names()

lapply(sample_vars, FUN = function(sample_vars){
  
  cars %>%
    group_by_at(vars(sample_vars)) %>% 
    summarise(amount = n()) %>%
    mutate("feature" = colnames(.[1])) %>% 
    rename("type" = colnames(.[1]))
  
}) %>% 
  bind_rows()



# Ordering within facets when facet wrapping ++++++++++++++++++++++++++++++++++

diamond_means <- diamonds %>%
  group_by(clarity, cut) %>%
  summarise(carat = mean(carat))

# Not ordered inside each facet (only ordered as a whole)
diamond_means %>% 
  ggplot(aes(x = reorder(clarity, carat), y= carat)) +
  geom_col() +
  facet_wrap(~cut, scales = "free")

# Use https://github.com/dgrtwo/drlib package
# Now ordered inside each facet

library(drlib)

diamond_means %>% 
  ggplot(aes(x = reorder_within(clarity, carat, cut), y= carat)) +
  geom_col() +
  scale_x_reordered() +
  facet_wrap(~cut, scales = "free")

















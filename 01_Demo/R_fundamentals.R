# Programming and ETL in R

# Simple Data Structure: Assignment Operator
## all environment objects are mutable; can be assigned/reassigned multiple times.
x <- 3
x <- 5

# Simple Data Structure: Numeric Vector
## an ordered list of numbers using the c() function
## "num[1:10]" = a numeric object with 1 row and 10 columns of values
numlist <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)

# Advanced Data Structure: Matrix 
## "a vector of vectors", where each value is the same data type.

# Advanced Data Structure: Data Frame
## very similar to a Pandas DataFrame where each column can be a different data type.

# Advanced Data Structure: Tibble
## a recent data object introduced by the tidyverse package in R
## an optimized data frame with extra metadata and features.


# ?<name of function>
## opens the documentation in the Help pane

# Importing data files
?read.csv()
demo_table <- read.csv(file = 'demo.csv', 
                       check.names = F, 
                       stringsAsFactors = F)

# Import 'jsonlite' library
library(jsonlite)

# Import JSON file
?fromJSON()
demo_table2 <- fromJSON(txt='demo.json')

# Select data using [] notation
## ex: select the third row of the Year column
demo_table[3, "Year"]
## can also select the same data using just number indices aka row/column indices.
demo_table[3, 3]

# Using $ operator, select vector of vehicle classes from demo_table;
## using '$', we can select columns from any two-dimensional R data structure 
## as a single vector, similar to selecting a series from a Pandas DataFrame.
demo_table$"Vehicle_Class"

# When vector is selected, use bracket notation to select a single value.
demo_table$"Vehicle_Class"[2]

# Select Data with Logical Operators -- similiar to Python
## Filter used cars by price greater than $10,000
filter_table <- demo_table2[demo_table2$"price">10000]

# Another method to filter and subset data frames
?subset()
filter_table2 <- subset(demo_table2, price > 10000 & drive == "4wd")

# Generate a *random* sample of data points from a larger dataset
?sample()
sample(c("cow", "deer", "pig", "chicken", "duck", "sheep", "dog"), 4)
demo_table[sample(1:nrow(demo_table), 3)]

# Import 'tidyverse' library
library(tidyverse)

# Transform a data frame and include new calculated data columns
?mutate()
demo_table <- demo_table %>% mutate(Mileage_per_Year = Total_Miles/(2020-Year), IsActive = TRUE)
## "Mileage_per_Year" and "IsActive" are new columns added to the original dataframe

# Create summary table using group_by()
summarize_demo <- demo_table2 %>% group_by(condition) %>%
                                  summarize(Mean_Mileage = mean(odometer))

# Add to previous summary table: maximum price for each condition & no. of vehicles in each category
summarize_demo <- demo_table2 %>% group_by(condition) %>%
                                  summarize(Mean_Mileage = mean(odometer), 
                                            Maximum_Price = max(price),
                                            Number_Vehicles = n())

# Import dataset
demo_table3 <- read.csv('demo2.csv', 
                        check.names = F,
                        stringsAsFactors = F)

# Transform a wide dataset into a long dataset using gather()
?gather()
long_table <- gather(demo_table3, 
                     key = "Metric", 
                     value = "Score",
                     buying_price: popularity)

# Alternatively, this function works too
long_table <- demo_table3 %>% gather(key = "Metric", 
                                     value = "Score",
                                     buying_price: popularity)
# 15.2.5 example does not have 'safety_rating" column in long_table

# Transform data in a long format to spread out a variable column of multiple measurements 
# into columns for each variable.
?spread()
wide_table <- long_table  %>% spread(key = "Metric",
                                     value = "Score")

# NOTE: If you ever compare two data frames that you expect to be equal, 
# and the all.equal() function tells you they’re not, try sorting the columns of both data frames.
wide_table <- wide_table[order(colnames(wide_table))]
demo_table3 <- demo_table3[order(colnames(demo_table3))]

# Check if newly created wide-format table is exactly the same as our original
all.equal(demo_table3, wide_table)



# Using Statistical Analysis in R

# Quantitative test for normality uses a statistical test to quantify the probability of whether or not 
# the test data came from a normally distributed dataset
?shapiro.test()
shapiro.test(mtcars$wt)

# Random sampling: create a random sample dataset from population data that contains minimal bias 
# and (ideally) represents the population data.
?sample_n()

# Visualize the distribution of driven miles for entire population dataset

# Import dataset
population_table <- read.csv("used_car_data.csv", check.names = F, stringsAsFactors = F)

# Import dataset into ggplot2
plt <- ggplot(population_table, aes(x = log10(Miles_Driven)))
#plt <- ggplot(population_table, aes(x = (Miles_Driven))) # Compare the differences with/without log10

# Plot using density plot
plt + geom_density()

# After characterizing population data using density plot, create a sample dataset.
# Randomly sample 50 data point
sample_table <- population_table %>% sample_n(50)

# Import dataset into ggplot2
plt <- ggplot(sample_table, aes(x = log10(Miles_Driven)))

# Plot using density plot
plt + geom_density()


# Two basic ways to check that the sample data is representative of the underlying population: 
# 1. a qualitative assessment of each density plot 
# 2. a quantitative statistical test such as the one-sample t-test.


# ONE-SAMPLE T-TEST: 
# Test if miles driven in sample data is statistically different from miles driven in population data
?t.test()

# Compare sample and population means
t.test(log10(sample_table$Miles_Driven), mu = mean(log10(population_table$Miles_Driven)))

# NOTE: Assuming the significance level is at 0.05%,  p-value is above this level. 
# Therefore, there is not sufficient evidence to reject the null hypothesis, 
# and we would state that the two means are statistically similar.
# NOTE: If p-value is below the signifance level, there is sufficient evidence to reject 
# the null hypothesis and state that the two means are statistically different.


# TWO-SAMPLE T-TEST:
# Test whether the mean miles driven of two samples from used car dataset are statistically different.

# Generate 50 random sample data points
sample_table1 <- population_table %>% sample_n(50)
# Generate another 50 random sample data points
sample_table2 <- population_table %>% sample_n(50)

# Compare the means of both samples
t.test(log10(sample_table1$Miles_Driven), log10(sample_table2$Miles_Driven))


# PAIR T-TEST: Compare two samples from two different populations.
## pair observations in one dataset with observations in another one.

# Import dataset
mpg_data <- read.csv("mpg_modified.csv")

# Select data points from 1999
mpg_1999 <- mpg_data %>% filter(year == 1999)
# Select data points from 2008
mpg_2008 <-  mpg_data %>% filter(year == 2008)

# With paired datasets, use a paired t-test to determine if there is a statistical difference 
# in overall highway fuel efficiency between vehicles manufactured in 1999 versus 2008.
# AKA: test null hypothesis — that the overall difference is zero

# Compare the mean difference between two samples
t.test(mpg_1999$hwy, mpg_2008$hwy, paired = T)

# NOTE: p-value is above the assumed significance level. 
# Therefore, we would state that there is not enough evidence to reject the null 
# hypothesis and there is no overall difference in fuel efficiency between vehicles 
# manufactured in 1999 versus 2008.


# ANOVA TEST: Cmpare the means of a continuous numerical variable across a number of groups (or factors in R)
# one-way vs. two-way ANOVA
?aov()

# Test: Is there any statistical difference in the horsepower of a vehicle based on its engine type?
# Using mtcars dataset:
# - horsepower (hp) = dependent, measured variable
# - number of cylinders (cyl) = independent, categorical variable
# NOTE: In dataset, cyl is considered a numerical interval vector, not a categorical vector => NEED TO CONVERT!

# Filter columns from mtcars dataset
mtcars_filt <- mtcars[c("hp", "cyl")]

# Convert numeric column to factor
mtcars_filt$cyl <- factor(mtcars_filt$cyl)

# Compare means across multiple levels
aov(hp ~ cyl, data = mtcars_filt)

# Initial output of ANOVA function doesn't contain p-values, wrap aov() function in a summary() function
summary(aov(hp ~ cyl, data = mtcars_filt))

# NOTE: Assuming sig. level of 0.05%, p-value is below sig. level.
# Therefore, there's sufficient evidence to reject the null hypothesis and 
# accept that there is a significant difference in horsepower between at least one engine type and the others.

# CORRELATIONAL ANALYSIS: A statistical technique that identifies how strongly (or weakly) two variables are related
?cor()
head(mtcars)

# Test whether or not horsepower (hp) is correlated with quarter-mile race time (qsec)

# Import dataset into ggplot2
plt <- ggplot(mtcars, aes(x = hp, y = qsec))

# Create scatter plot
plt + geom_point()

# NOTE: There is a negative correlation between horsepower and quarter-mile race time. 
# As vehicle horsepower increases, vehicle quarter-mile time decreases

# Calculate the correlation coefficient (r): to quantify the strength of the correlation between our two variables
cor(mtcars$hp, mtcars$qsec)

# NOTE: r-value between horsepower and quarter-mile time is -0.71, which is a strong negative correlation.

# Read dataset
used_cars <- read.csv('used_car_data.csv',stringsAsFactors = F)
head(used_cars)

# Test whether or not vehicle miles driven and selling price are correlated

# Import dataset into ggplot2
plt <- ggplot(used_cars, aes(x= Miles_Driven, y = Selling_Price))

# Create scatter plot
plt + geom_point()

# Calculate correlation coefficient (r)L
cor(used_cars$Miles_Driven, used_cars$Selling_Price)

# NOTE: r-value is 0.02, which means that there is a negligible correlation between 
# miles driven and selling price in this dataset.

# CORRELATION MATRIX: a lookup table where the variable names of a data frame are stored as rows and 
# columns, and the intersection of each variable is the corresponding Pearson correlation coefficient.

# Convert data frame into a numeric matrix
used_matrix<- as.matrix(used_cars[c("Selling_Price", "Present_Price", "Miles_Driven")])
cor(used_matrix)


# LINEAR REGRESSION: a statistical model that is used to predict a continuous dependent variable based 
# on one or more independent variables fitted to the equation of a line
# Simple (one independent variable) vs. Multiple (2+ independent variables) linear regression

# NOTE: Combining the p-value of the hypothesis test with the r-squared value, the linear regression model 
# becomes a powerful statistics tool that both quantifies a relationship between variables and provides 
# a meaningful model to be used in any decision-making process.
?lm()

# Test whether or not quarter-mile race time (qsec) can be predicted using a linear model and horsepower (hp).

# Create a linear model
lm(qsec ~ hp, mtcars)

# To determine p-value and r-squared value for a simple linear regression model, use the summary() function:
# Summarize linear model
summary(lm(qsec ~ hp, mtcars))

# NOTE: 
# 1. Given the r-squared value is 0.50, roughly 50% of all quarter mile time predictions 
# will be correct when using this linear model.
# 2. The p-value is much smaller than assumed significance level of 0.05%. There is sufficient 
# evidence to reject null hypothesis, which means that the slope of linear model is not zero.

# Calculate the data points to use for line plot
# Create linear model
model <- lm(qsec ~ hp, mtcars)

# Determine y-axis values from linear model
yvals <- model$coefficients['hp']*mtcars$hp + model$coefficients['(Intercept)']

# Import dataset into ggplot2
plt <- ggplot(mtcars, aes(x = hp, y = qsec))

# Plot scatter and linear plots
plt + geom_point() + geom_line(aes(y =  yvals), color = "red")

# To better predict the quarter-mile time (qsec) dependent variable, add other variables of interest:
# fuel efficiency (mpg), engine size (disp), rear axle ratio (drat), vehicle weight (wt),  horsepower (hp) 
# as independent variables to our multiple linear regression model.

# Generate multiple linear regression model
lm(qsec ~ mpg + disp + drat + wt + hp, data = mtcars)

# Generate summary statistics
summary(lm(qsec ~ mpg + disp + drat + wt + hp, data = mtcars))

# NOTE: vehicle weight and horsepower (as well as intercept) are statistically unlikely to provide 
# random amounts of variance to the linear model. In other words the vehicle weight and horsepower 
# have a significant impact on quarter-mile race time.

# NOTE: When an intercept is statistically significant, it means there are other variables and factors 
# that contribute to the variation in quarter-mile time that have not been included in our model.

# NOTE: Multiple linear regression model outperformed the simple linear regression. 
# According to the summary output, the r-squared value has increased from 0.50 in the simple linear 
# regression model to 0.71 in our multiple linear regression model while the p-value remained significant.


# CHI-SQUARED TEST: Used to compare the distribution of frequencies across two groups and tests hypothesese:
# H0 : There is no difference in frequency distribution between both groups.
# Ha : There is a difference in frequency distribution between both groups
?chisq.test()

# Test whether there is a statistical difference in the distributions of vehicle class across 1999 and 2008 
# in mpg dataset.

# Generate contingency table
tbl <- table(mpg$class, mpg$year)
tbl

# Compare categorical distributions
chisq.test(tbl)

# enough evidence to reject the null hypothesis, and there is no difference in the distribution of vehicle 
# class across 1999 and 2008 from the mpg dataset.


# A/B TESTING: A randomized controlled experiment that uses a control (unchanged) and experimental (changed) group
# to test potential changes using a success metric. It tests whether or not the distribution of the success metric 
# increases in the experiment group instead of the control group.













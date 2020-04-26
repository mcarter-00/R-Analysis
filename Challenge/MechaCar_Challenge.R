# Import libraries
library(tidyverse)

# Import datasets
MechaCar_table <- read.csv(file = "/Users/mariacarter/Desktop/Berkeley-Bootcamp/Analysis-Projects/R-Analysis/Challenge/MechaCar_mpg.csv", header = TRUE, sep = ",")
Suspension_table <- read.csv(file = "/Users/mariacarter/Desktop/Berkeley-Bootcamp/Analysis-Projects/R-Analysis/Challenge/Suspension_Coil.csv", header = TRUE, sep = ",")


# MPG REGRESSION
# Create a multiple linear regression model
lm(mpg ~ vehicle.length + vehicle.weight + spoiler.angle + ground.clearance + AWD, data = MechaCar_table)

# Create summary statistics
summary(lm(mpg ~ vehicle.length + vehicle.weight + spoiler.angle + ground.clearance + AWD, data = MechaCar_table))


# SUSPENSION COIL SUMMARY
# Create summary statistics
Suspension_table %>% 
  summarize(PSI_mean = mean(PSI), 
            PSI_median = median(PSI), 
            PSI_variance = var(PSI),
            PSI_sd = sd(PSI))

# Create summary statistics based on Manufacturing Lots
Suspension_table %>% 
  group_by(Manufacturing_Lot) %>% 
  summarize(PSI_mean = mean(PSI), 
            PSI_median = median(PSI), 
            PSI_variance = var(PSI),
            PSI_sd = sd(PSI))


# SUSPENSION COIL T-TEST
# Generate 50 random sample data points
sample_table1 <- Suspension_table %>% sample_n(50) 
sample_table2 <- Suspension_table %>% sample_n(50)

# Compare the means of two samples
t.test(sample_table1$PSI, sample_table2$PSI)

# Determine if the suspension coil’s PSI results are statistically different from the mean population PSI results of 1,500.
t.test(Suspension_table$PSI, mu = 1500)

t.test(subset(Suspension_table, Manufacturing_Lot == "Lot1")$PSI, mu = 1500)
t.test(subset(Suspension_table, Manufacturing_Lot == "Lot2")$PSI, mu = 1500)
t.test(subset(Suspension_table, Manufacturing_Lot == "Lot3")$PSI, mu = 1500)


# DESIGN MY OWN STUDY
# Use mtcars to compare miles per gallon (mpg) vs. horsepower (hp)
head(mtcars)

# Create a single linear regression model
lm(mpg ~ hp, data = mtcars)

# Create summary linear model
summary(lm(mpg ~ hp, data = mtcars))

# Create summary statistics for horsepower (hp)
mtcars %>%
  summarize(hp_mean= mean(hp), 
            hp_median = median(hp), 
            hp_variance = var(hp),
            hp_sd = sd(hp))

# Generate 16 random sample data points 
sample_mtcars <- mtcars %>% sample_n(16) 

# Determine statistical differences using t-test
t.test(sample_mtcars$hp, mu = 146)




# Visualize Your Data Using ggplot2
?ggplot()

# mpg dataset is built into R and used throughout R documentation
head(mpg)

### BAR PLOTS: Create a bar plot that represents the distribution of vehicle classes

# Import dataset into ggplot2
plt <- ggplot(mpg, aes(x = class)) 

# Plot a bar plot
plt + geom_bar()
?geom_bar()

# Create a summary table
mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count = n())

# Import dataset into ggplot2
plt <- ggplot(mpg_summary, aes(x = manufacturer, 
                               y = Vehicle_Count))
# Plot a bar plot
plt + geom_col()
?geom_col()

# NOTE: 
# geom_bar() expects one variable and generates frequency data
# geom_col() expects two variables where we provide the size of each category’s bar


# Plot bar plot with labels + Rotate the x-axis label 45 degrees
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles") + theme(axis.text.x = element_text(angle=45, hjust=1))

# NOTE: To adjust y-axis labels, use the axis.text.y argument of the theme() function





### LINE PLOTS: Create a line plot to compare the differences in average highway fuel economy (hwy) of Toyota vehicles as a function of the different cylinder sizes (cyl).

# Create summary table
mpg_summary <- subset(mpg, manufacturer == "toyota") %>% 
                group_by(cyl) %>% 
                summarize(Mean_Hwy = mean(hwy))

# Import dataset into ggplot2
plt <- ggplot(mpg_summary, aes(x= cyl, y = Mean_Hwy))

# Plot line plot and adjust the x-axis and y-axis tick values
plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(15:30))





# SCATTER PLOTS: Create a scatter plot to visualize the relationship between the size of each car engine (displ) versus their city fuel efficiency (cty).

# Import dateset into ggplot2
plt <- ggplot(mpg, aes(x = displ, y = cty))
# Plot scatter plot with labels
plt + geom_point() + xlab("Enginge Size (L)") + ylab("City Fuel-Efficiency (MPG)") 

# Customize data points to add additional context and convey more information through a single viz

# Import dataset into ggplot2
plt <- ggplot(mpg, aes(x = displ, y = cty, color=class))
# Plot scatter plot with labels
plt + geom_point() + labs(x="Engine Size (L)", 
                          y="City Fuel-Efficiency (MPG)", 
                          color="Vehicle Class")


# Import dataset into ggplot2
plt <- ggplot(mpg, aes(x = displ, y = cty, color=class, shape=drv))
# Plot scatter plot with labels
plt + geom_point() + labs(x="Engine Size (L)", 
                          y="City Fuel-Efficiency (MPG)", 
                          color="Vehicle Class", 
                          shape="Type of Drive")


# Import dataset into ggplot2
plt <- ggplot(mpg, aes(x = displ, y = cty, color=class, shape=drv, size=cty))
# Plot scatter plot with labels
plt + geom_point() + labs(x="Engine Size (L)", 
                          y="City Fuel-Efficiency (MPG)", 
                          color="Vehicle Class", 
                          shape="Type of Drive", 
                          size="City Fuel-Efficiency")


# Import dataset into ggplot2
plt <- ggplot(mpg, aes(x = displ, y = cty, size=cty))
# Plot scatter plot with labels
plt + geom_point() + labs(x="Engine Size (L)", 
                          y="City Fuel-Efficiency (MPG)", 
                          size="City Fuel-Efficiency")




# BOXPLOTS: Create a boxplot to visualize the highway fuel efficiency of our mpg dataset

# Import dataset into ggplot2
plt <- ggplot(mpg, aes(y=hwy))
# Plot box plot
plt + geom_boxplot()

# NOTE: geom_boxplot()expects a numeric vector assigned to the y-value. 
## This is due to the ggplot accounting for multiple boxplots in a single figure


# Create a set of boxplots that compares highway fuel efficiency for each car manufacturer
# Import dataset into ggplot2
plt <- ggplot(mpg, aes(x=manufacturer, y=hwy))
# Plot box plot
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1))

# Customize the boxplot to be more aesthetic
plt + geom_boxplot(fill= "white",
                   color = "#3366FF",
                   outlier.colour = "red", 
                   outlier.shape = 1) + theme(axis.text.x=element_text(angle=45,hjust=1))

# Boxplots are automatically dodged when any aesthetic is a factor
plt + geom_boxplot(aes(colour = drv)) + theme(axis.text.x=element_text(angle=45,hjust=1))






# HEATMAPS: Create a heatmap to visualize the average highway fuel efficiency across the type of vehicle class from 1999 to 2008

# Create summary table
mpg_summary <- mpg %>% group_by(class, year) %>% summarize(Mean_Hwy = mean(hwy))

# Import datset into ggplot2
plt <- ggplot(mpg_summary, aes(x=class, y=factor(year), fill = Mean_Hwy))

# Create heatmap with labels
plt + geom_tile() + labs(x= "Vehicle Class", 
                         y= "Vehicle Year", 
                         fill= "Mean Highway (MPG)")

# Create a heatmap to look at the difference in average highway fuel efficiency across each vehicle model from 1999 to 2008

# Create summary table
mpg_summary <- mpg %>% group_by(model, year) %>% summarize(Mean_Hwy = mean(hwy))

# Import datset into ggplot2
plt <- ggplot(mpg_summary, aes(x=model, y=factor(year), fill = Mean_Hwy))

# Create heatmap with labels & #rotate x-axis labels 90 degrees
plt + geom_tile() + labs(x= "Model", 
                         y= "Vehicle Year", 
                         fill= "Mean Highway (MPG)") + theme(axis.text.x= element_text(angle= 90, hjust= 1, vjust= .5))

?mpg

# Recreate previous boxplot comparing the highway fuel efficiency across manufacturers, and
# add data points using the geom_point() function
plt <- ggplot(mpg, aes(x= manufacturer, y= hwy)) #import dataset into ggplot2
plt + geom_boxplot() + #add boxplot
theme(axis.text.x= element_text(angle= 45, hjust= 1)) + #rotate x-axis labels 45 degrees
geom_point() #overlay scatter plot on top

# Compare average engine size for each vehicle class
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine= mean(displ)) #create summary table
plt <- ggplot(mpg_summary, aes(x = class, y = Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x = "Vehicle Class", y = "Mean Engine Size") #add scatter plot

# Provide context around the standard deviation of the engine size for each vehicle class
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine = mean(displ), SD_Engine = sd(displ))
plt <- ggplot(mpg_summary, aes(x = class, y = Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size = 4) + labs(x = "Vehicle Class", y = "Mean Engine Size") + #add scatter plot with labels
geom_errorbar(aes(ymin = Mean_Engine - SD_Engine, ymax = Mean_Engine + SD_Engine)) #overlay with error bars

# Instead of the wide format,  mpg dataset was in a long format:
mpg_long <- mpg %>% gather(key = "MPG_Type", value = "Rating", c(cty,hwy)) #convert to long format
head(mpg_long)

# Visualize the different vehicle fuel efficiency ratings by manufacturer
plt <- ggplot(mpg_long, aes(x = manufacturer, 
                            y = Rating, 
                            color = MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle = 45, hjust = 1)) #add boxplot with labels rotated 45 degrees

# Facet the different types of fuel efficiency within the viz using the facet_wrap() function.
?facet_wrap()

plt <- ggplot(mpg_long, aes(x = manufacturer,
                            y = Rating,
                            color = MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + #create multiple boxplots, one for each MPG type
theme(axis.text.x=element_text(angle = 45, hjust = 1), legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels


# Qualitative test for normality is a visual assessment of the distribution of data, which looks for 
# the characteristic bell curve shape across the distribution
# Visualize distribution using density plot
ggplot(mtcars, aes(x = wt)) + geom_density()












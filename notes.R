# notes on book R for data science (https://r4ds.had.co.nz/)

library("tidyverse")

# Do cars with big engines use more fuel than cars with small engines?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# A mapping template:
# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# Run ggplot(data = mpg). What do you see?
#   An empty plot
#   How many rows are in mpg? How many columns?
dim(mpg) # 234 x 11
#   What does the drv variable describe? Read the help for ?mpg to find out.
?mpg # the type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd
# Make a scatterplot of hwy vs cyl.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy))
# What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = class)) # two categorical data types

# color "outlier" points
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = hwy > 20 & displ > 5), show.legend = FALSE)

# color by class of car
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) # most outliers 2seaters

# What has gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) + 
geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
# color should be outside of mapping
  
# Which variables in mpg are categorical? Which variables are continuous? 
mpg # categorical: manufacturer, model, trans, drv, fl, class
# continuous: hwy, cty, cyl, year?, displ
  
# Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?
  
  

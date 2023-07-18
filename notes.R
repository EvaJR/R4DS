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
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = displ))
# color:gradient vs individual legend
# shape: A continuous variable cannot be mapped to the shape aesthetic

# What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = drv, color = drv, size = drv))
# What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "white", size = 5, stroke = 5)
# use to modify the width of the border for shapes that have a border (21-25)
# What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
# color mapped based on boolean expression

# example facet_wrap (subplots)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# example facet_grid (subplots)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# What happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cty, nrow = 2)
# lots of facets!

# What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?
# no data for that combination, same combination that does not have a point in the plot 

# scatterplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# fitted line of same data
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# combine two geoms in one plot:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth()

# overview of extensions/inspiration: https://exts.ggplot2.tidyverse.org/gallery/

# example bar chart
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# What is the default geom associated with stat_summary()? 
#pointrange

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# equivalent for scatterplot to show all the data, also overlapping values: jitter or count
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_jitter(color="red") +
  geom_count(color = 'blue')

ggplot(data = mpg, mapping = aes(class, hwy)) +
  geom_boxplot()

read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))

# read_csv and read_tsv are specific cases of the more general read_delim:
read_delim("1|2|3\n4|5|6", delim = "|", col_names = c("x", "y", "z"))

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)

stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")
# not symmetrical because type of column year is lost
           
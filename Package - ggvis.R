# Learn package ggvis
# The goal of ggvis is to make it easy to build interactive graphics for exploratory data analysis. 
library(ggvis)

# Every ggvis graphic starts with a call to ggvis(). The first argument is the data set that you want to plot, and the other arguments describe how to map variables to visual properties.
p <- ggvis(mtcars, x = ~wt, y = ~mpg)
layer_points(p)

# Another shorter way to plot this one
mtcars %>%
  ggvis(x = ~wt, y = ~mpg) %>%
  layer_points()

# You can add more variables to the plot by mapping them to other visual properties like fill, stroke, size and shape
mtcars %>% ggvis(~mpg, ~disp, stroke = ~vs) %>% layer_points()
mtcars %>% ggvis(~mpg, ~disp, fill = ~vs) %>% layer_points()
mtcars %>% ggvis(~mpg, ~disp, size = ~vs) %>% layer_points()
mtcars %>% ggvis(~mpg, ~disp, shape = ~factor(cyl)) %>% layer_points()

# If you want to make the points a fixed colour or size, you need to use := instead of =. 
mtcars %>% ggvis(~wt, ~mpg, fill := "red", stroke := "black") %>% layer_points()

mtcars %>% ggvis(~wt, ~mpg, size := 300, opacity := 0.4) %>% layer_points()

mtcars %>% ggvis(~wt, ~mpg, shape := "cross") %>% layer_points()


# Interaction -------------------------------------------------------------
# The following example allows you to control the size and opacity of points with two sliders:
mtcars %>% 
  ggvis(~wt, ~mpg, 
        size := input_slider(10, 100),
        opacity := input_slider(0, 1)
  ) %>% 
  layer_points()

keys_s <- left_right(10, 1000, step = 50)
mtcars %>% ggvis(~wt, ~mpg, size := keys_s, opacity := 0.5) %>% layer_points()


mtcars %>% ggvis(~wt, ~mpg) %>% 
  layer_points() %>% 
  add_tooltip(function(df) df$wt)


# Layers ------------------------------------------------------------------
# All layer functions use the plural, not the singular. Think the verb, not the noun: I'm going to layer some points onto my plot.
# There are five simple layers:

# 1. Points
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points()

# 2. Path and polygons
df <- data.frame(x = 1:10, y = runif(10))
df %>% ggvis(~x, ~y) %>% layer_paths()

# If you supply a fill, you'll get a polygon
t <- seq(0, 2 * pi, length = 100)
df <- data.frame(x = sin(t), y = cos(t))
df %>% ggvis(~x, ~y) %>% layer_paths(fill := "red")

# 3. Ribbons
# Filled areas, layer_ribbons(). Use properties y and y2 to control the extent of the area.
df <- data.frame(x = 1:10, y = runif(10))
df %>% ggvis(~x, ~y) %>% layer_ribbons()

df %>% ggvis(~x, ~y + 0.1, y2 = ~y - 0.1) %>% layer_ribbons()


# 4. Rectangles, layer_rects(). The location and size of the rectangle is controlled by the x, x2, y and y2 properties.
set.seed(1014)
df <- data.frame(x1 = runif(5), x2 = runif(5), y1 = runif(5), y2 = runif(5))
df %>% ggvis(~x1, ~y1, x2 = ~x2, y2 = ~y2, fillOpacity := 0.1) %>% layer_rects()

# 5. Text
df <- data.frame(x = 3:1, y = c(1, 3, 2), label = c("a", "b", "c"))
df %>% ggvis(~x, ~y, text := ~label) %>% layer_text()

df %>% ggvis(~x, ~y, text := ~label) %>% layer_text(fontSize := 50)
df %>% ggvis(~x, ~y, text := ~label) %>% layer_text(angle := 45)



# Compound layers ---------------------------------------------------------
# The four most common compound layers are:
# layer_lines()
t <- seq(0, 2 * pi, length = 20)
df <- data.frame(x = sin(t), y = cos(t))
df %>% ggvis(~x, ~y) %>% layer_paths()

# layer_lines() which automatically orders by the x variable:
# Please note the difference
# layer_lines() is equivalent to arrange() + layer_paths():
df %>% ggvis(~x, ~y) %>% layer_lines()

# layer_smooths()
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths()

# You can control the degree of wiggliness with the span parameter:
span <- input_slider(0.2, 1, value = 0.75)
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths(span = span)



# Multiple layers ---------------------------------------------------------
mtcars %>% 
  ggvis(~wt, ~mpg) %>% 
  layer_smooths() %>% 
  layer_points()



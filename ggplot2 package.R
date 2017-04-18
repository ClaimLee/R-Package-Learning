#===============================================================================
#                     Package ggplot2
#===============================================================================
setwd("D:/")
library(ggplot2)

data(mpg)

# It is just adding a new layer from existing layers using "+"
LIFEI <- ggplot(data = mpg, aes(x=cty, y=hwy)) + geom_point(aes(color = cyl)) + geom_smooth(method = "lm") + coord_cartesian() + scale_color_gradient() + theme_bw()

# Save last plot in working directory
ggsave(filename = "My first plot.png", width = 5, height = 5)


# Graphical primitives
a <- ggplot(data = seals, aes(x=long, y=lat))
b <- ggplot(data = economics, aes(date,unemploy))

a + geom_blank() #Useful for explanding limits

a + geom_curve(aes(yend=lat+delta_lat,xend=long+delta_long, curvature = z))

b + geom_path(lineend="square",linejoin = "round",linemitre = 1)

b + geom_polygon(aes(group = group))

b + geom_ribbon(aes(ymin=unemploy-900, ymax=unemploy+900))

a + geom_segment(aes(yend=lat+delta_lat,xend=long+delta_long))

a + geom_spoke(aes(yend=lat+delta_lat,xend=long+delta_long))

# Two variables
#Continous x, continous y
e <- ggplot(mpg, aes(cty,hwy))

e + geom_label(aes(label = cty), nudge_x = 1,nudge_y = 1)

e + geom_jitter(height = 2,width = 2)

e + geom_point()

e + geom_quantile()

e + geom_rug(sides = "bl")

e + geom_smooth(method = lm)

e + geom_text(aes(label=cty),nudge_x = 1,nudge_y = 1,check_overlap = TRUE)

# Continuous Bivariate distribution
h <- ggplot(diamonds, aes(carat, price))

h + geom_bin2d(binwidth=c(0.25,500))

h + geom_density2d()

h + geom_point()

h + geo_hex()



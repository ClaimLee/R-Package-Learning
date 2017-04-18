#=======================================================================
#             Learn "dplyr" package
#=======================================================================

library(dplyr)

data(mtcars)
head(mtcars)
colnames(mtcars)
rownames(mtcars)

add_rownames(mtcars,var = "cartype")
mtcars %>% tbl_df()

mtcars_df <- tbl_df(mtcars)

#disturb the orders of rows and columns
scramble <- function(x) x[sample(nrow(x)), sample(ncol(x))]

#See if these two data frames are still the same
all.equal(mtcars_df, scramble(mtcars_df))

# arrange
arrange(mtcars, cyl, disp)
arrange(mtcars, desc(disp))

# as.tbl_cube
as.tbl_cube(mtcars, dim_names = names(dimnames(mtcars)))

# as_data_frame
l <- list(x = 1:50, y = runif(50), z = 50:1)

df <- as_data_frame(l)

as.data.frame(l)

df %>% mutate(w = x+z) %>% mutate(r = y+z)

require(microbenchmark) && has_lahman()

# bind
one <- mtcars[1:4,]
two <- mtcars[11:14,]
three <- mtcars[20:25,]
do.call(rbind, list(one,two))
bind_rows(one,two)
smartbind(one,two)

bind_rows(list(a = one,b = two, c = three), .id = "id")

bind_cols(data.frame(x = 1:3), data.frame(y = 1:4))

f1 <- factor("a")
f2 <- factor("b")
c(f1,f2)
unlist(list(f1,f2))
combine(f1,f2)
combine(list(f1,f2))

# build_sql
build_sql("SELECT * FROM TABLE")
x <- "TABLE"
build_sql("SELECT * FROM", x)
build_sql("SELECT * FROM", ident(x))
build_sql("SELECT * FROM", sql(x))

cummean(c(1:10))

# data_frame
a <- 1:5
data_frame(a, b = a*2)
as_data_frame(list(a = a, b = a*3))
data_frame(letters)
str(data_frame(letters))

data_frame('a+b' = 1:5)

# distinct
df <- data.frame(x = sample(10,100,rep=T),y=sample(10,100,rep=T))
nrow(df)
nrow(distinct(df))
distinct(df,x)
distinct(df,y)

df[!duplicated(df$x),]

# do
by_cyl <- group_by(mtcars, cyl)
summarise(by_cyl, mean(disp))

do(by_cyl, head(.,2))

models <- by_cyl %>% do(mod = lm(mpg~disp, data=.))
models
summarise(models, rsq = summary(mod)$r.squared)

# failwith
# capture error
f <- function(x) if(x==1) stop("Error!") else 1
f(1)
f(2)
safef <- failwith(NULL, f)
safef(1)
safef(2)

# frame_data
frame_data(~colA, ~colB,
           "a",1,   4,
           "b",2,   100)


# funs
fs <- c("min", "max")
funs_(fs)

funs_(fs)$min
funs(mean, "mean", mean(., na.rm = TRUE))


means_fun <- function(x) mean(x, na.rm = TRUE)
iris %>% 
  group_by(Species) %>%  
  summarise_each(funs(sum))

# glimpse
glimpse(iris)
glimpse(mtcars)

# groups
grouped <- group_by(iris, Species)
groups(grouped)
groups(ungroup(grouped))
ungroup(grouped)

# group_indices
group_indices(mtcars, cyl)
group_indices(iris, Species)

# group_size
# The argument shoudl be a grouped table
n_groups(grouped) #how many groups are grouped together
group_size(grouped) #what is the data size for each group

# join
right_join(iris[1:5,],iris[6:10,])
inner_join(df1,df2)
left_join(df1,df2)
semi_join(df1,df2)
anti_join(df1,df2)
full_join(df1,df2)

df1 <- data_frame(a = 1:10, b = 2:11)
df2 <- data_frame(a = 3:12, d = 4:13)

# lead-lag
lead(1:10,1)
lead(1:10,2)
lag(1:10,1)
lag(1:10,2)

# location
# print the location i memory of a data frame
location(mtcars)
mtcars2 <- mutate(mtcars, cyl2 = cyl*2)
location(mtcars2)
changes(mtcars, mtcars)
changes(mtcars, mtcars2)

# n
# The number of observations in the current group
summarize(grouped,n())
mutate(grouped, n = n())

# nasa
nasa
head(nasa)

# nth
x <- 1:10
last(x)
y <- 10:1
last(x,y)
nth(x, 5)
x[5]

#n_distinct
w <- c("Lily","Lily","Helen","Helen","Justin","Kevin")
length(unique(w))
n_distinct(w)

#order_by
order_by(10:1, cumsum(1:10))

# rowwise
rowwise(mtcars)

# sample
sample_n(mtcars, 4, replace = TRUE, weight = mpg)

# select
select(mtcars, starts_with("m"))
select(mtcars, ends_with("b"))
select(mtcars, contains("mpg"))
select(mtcars, carb, everything())

# setops
first <- mtcars[1:20,]
second <- mtcars[10:32,]
intersect(first,second)
union(first, second)
setdiff(first, second)
setequal(first, second)

# connect to MySQL
# method 1
mydb = dbConnect(MySQL(), user='analytics', password='analytics123', dbname='aims_analytics', host='10.67.2.50')

# method 2
mydb <- src_mysql('aims_analytics', host = '10.67.2.50',user='analytics', password='analytics123')
src_tbls(mydb)

# summarise
summarise_each(grouped, funs(mean))

# tally
#similar as n_groups and group_size
tally(grouped)
n_groups(grouped)
group_size(grouped)

# tbl
tbl(mtcars)


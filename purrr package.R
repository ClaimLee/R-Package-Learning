#=======================================================================
#             Learn "purrr" package
#=======================================================================
# Functional Programming Tools
library(purrr)

# Accumulate
# Accumulate recursive folds across a list
1:3 %>% accumulate(`+`)

1:10 %>% accumulate_right(`+`)

# From Haskell's scanl documentation
1:10 %>% accumulate(max, .init = 5) # .init If supplied, will be used as the first value to start the accumulation


# along
# Helper to create vectors with matching length.
x <- 1:5
rep_along(x, 1:2)
rep_along(x, 1)
list_along(x)

# array-coercion
# coerce array to list
# We create an array with 3 dimensions
x <- array(1:12, c(2, 2, 3))
# Creating a branch along the full margin is equivalent to
# as.list(array) and produces a list of size length(x):
array_branch(x) %>% str()
# A branch along the first dimension yields a list of length 2
# with each element containing a 2x3 array:
array_branch(x, 1) %>% str()

# A branch along the first and third dimensions yields a list of
# length 2x3 whose elements contain a vector of length 2:
array_branch(x, c(1, 3)) %>% str()

# Creating a tree from the full margin creates a list of lists of
# lists:
array_tree(x) %>% str()

# The ordering and the depth of the tree are controlled by the
# margin argument:
array_tree(x, c(3, 1)) %>% str()

# as_function
# Convert an object into a function.
LIFEI <- as_function(~ . + 1)
LIFEI(6)

as_function(1)

as_function(c("a", "b", "c"))

as.list(letters) %>% as_vector("character")


# by_row
# apply a function to each row of a data frame
# ..f should be able to work with a list or a data frame. As it
# happens, sum() handles data frame so the following works:
A <- mtcars %>% by_row(sum)

B <- mtcars %>% by_row(lift_vl(mean))


# compose
# compose multiple functions
not_null <- compose(`!`, is.null)
not_null(4)
not_null(NULL)
add1 <- function(x) x + 1
compose(add1, add1)(8)

# dmap
# map over the columns of a data frame
# dmap() also supports sliced data frames:
sliced_df <- mtcars[1:5] %>% slice_rows("cyl")

sliced_df %>% dmap(mean)
sliced_df %>% dmap(~ .x / max(.x))


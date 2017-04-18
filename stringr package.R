#=======================================================================
#             Learn "stringr" package
#=======================================================================
library(stringr)

# case

lifei <- "This is A handsome boy"
str_to_lower(lifei)
str_to_upper(lifei)
str_to_title(lifei)

str_to_upper("i", locale = "en") # English
str_to_upper("i", locale = "tr") # Turkish

# invert_match
#capture all the numbers
numbers <- "1 and 2 and 4 and 456"
num_loc <- str_locate_all(numbers, "[0-9]+")[[1]]
str_sub(numbers, num_loc[,"start"], num_loc[,"end"])

medicine <- "Amox/ciliin 30 mg/ml, Penicilllin 65 mg/ml"
dosage_loc <- str_locate_all(medicine, "[0-9]+")[[1]]
dosage <- str_sub(medicine, start = dosage_loc[, "start"], end = dosage_loc[, "end"])
dosage

#capture the rest info except those numbers
text_loc <- invert_match(num_loc)
str_sub(numbers, text_loc[, "start"], text_loc[, "end"])

medi_loc <- invert_match(dosage_loc)
str_sub(medicine, start = medi_loc[, "start"], end = medi_loc[, "end"])

# modifiers
# control matching behaviour with modifier functions
pattern <- "a.b"
strings <- c("abb", "a.b")
str_detect(strings, pattern)
str_detect(strings, fixed(pattern))
str_detect(strings, coll(pattern))

i <- c("I", "\u0130", "i")

str_detect(i, fixed("i", ignore_case = TRUE))
str_detect(i, coll("i", ignore_case = TRUE, locale = "tr"))

#Word boundaries
words <- c("These are   some words.")
str_count(words, boundary("word"))
str_split(words, " ")[[1]]
str_split(words, boundary("word"))[[1]]

#Regular expression variations
str_extract_all("The Cat in the Hat", "[a-z]+")[[1]]
str_extract_all("The Cat in the Hat", regex("[a-z]+",TRUE))[[1]]

str_extract_all("a\nb\nc", "^.")[[1]]
str_extract_all("a\nb\nc", regex("^.", multiline = TRUE))[[1]]

str_extract_all("a\nb\nc", "a.")[[1]]
str_extract_all("a\nb\nc", regex("a.", dotall = TRUE))[[1]]

#str_c
#Join multiple strings into a single string
str_c("Letter: ", letters)
str_c("LFEI: ", letters)
str_c("Letter", letters, sep = "-")
str_c(letters, " is for ", "...")
str_c(letters[-26]," comes from ", letters[-1])
str_c(letters, collapse = "")
str_c(letters, collapse = ", ")

#missing inputs give missing outputs
str_c(c("a", NA, "b"), "-d")
#use str_replace_NA to display literal NAs:
str_c(str_replace_na(c("a", NA, "b")), "-d")

#str_count
#count the number of matches in a string
str_count(c("a.", "...", ".a.a"), ".") #just count the number of characters
str_count(c("a.", "...", ".a.a"), fixed(".")) #only count the dots

#str_detect
#detect the presence or absence of a pattern in a string
fruit <- c("apple", "banana", "pear", "pineapple")
str_detect(fruit, "a") #as long as contains "a", is TRUE
str_detect(fruit, "^a") #only starting with "a" is TRUE
str_detect(fruit, "a$") #only ending with "a" is TRUE
str_detect(fruit, "[aeiou]")

str_detect("aecfg", letters)

#str_dup
str_dup(fruit, 2)
str_dup(fruit, 1:4)
str_c("ba", str_dup("na", 0:5))

#str_extract
#extract matching patterns from a string
shopping_list <- c("apples x4", "bag of flour", "bag of sugar", "milk x2")
str_extract(shopping_list, "\\d") #extract all the digits
str_extract(shopping_list, "[a-z]+")
str_extract(shopping_list, "[a-z]{1,4}")
str_extract(shopping_list, "\\b[a-z]+\\b")
str_extract(shopping_list, "\\b[a-z]{1,4}\\b")

#extract all matches
str_extract_all(shopping_list, "\\d") #extract all the digits
str_extract_all(shopping_list, "[a-z]+")
str_extract_all(shopping_list, "[a-z]{1,4}")
str_extract_all(shopping_list, "\\b[a-z]+\\b")
str_extract_all(shopping_list, "\\b[a-z]{1,4}\\b")
#simplify results into character matrix
str_extract_all(shopping_list, "\\d", simplify = TRUE) 

#str_length
str_length(letters)
str_length(NA)
str_length(factor("abc"))
str_length(fruit)

#str_locate
#locate the position of patterns in a string
str_locate_all(shopping_list, "\\d")
str_locate(fruit, "$")
str_locate(fruit, "a")
str_locate_all(fruit, "a")
str_locate_all(fruit, "") #find the location of every character

#str_match
#extract matched groups from a string
strings <- c(" 219 733 8965", "329-293-8753 ", "banana", "595 794 7569",
             "387 287 6718", "apple", "233.398.9187  ", "482 952 3315",
             "239 923 8115 and 842 566 4692", "Work: 579-499-7527", "$1000",
             "Home: 543.355.3679")

phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"

str_extract(strings, phone)
str_match(strings, phone)

# Extract/match all
str_extract_all(strings, phone)
str_match_all(strings, phone)

#str_order
str_order(letters, decreasing = T,locale = "en") #numbers
str_sort(letters, decreasing = T) #original letters

str_sort(letters, locale = "haw")

#str_pad
str_pad("hadley", 30, "left")
str_pad("You go out", 20, "right",pad = "!")

rbind(
  str_pad("hadley", 30, "left"),
  str_pad("hadley", 30, "right"),
  str_pad("hadley", 30, "both")
  
)

#All arguments are vectorised except side
str_pad(c("a", "abc", "adcdef"), 10)
str_pad("a", c(5,10,20))
str_pad("a", 10, pad = c("-", "_", " "))

#str_replace
fruits <- c("one apple", "two pears", "three bananas")
str_replace(fruits, "[aeiou]", "-") #only replace the first matching letter
str_replace_all(fruits, "[aeiou]", "-") # replace all matching letters

str_replace(fruits, "([aeiou])", "")
str_replace(fruits, "([aeiou])", "\\1\\1")
str_replace(fruits, "[aeiou]", c("1", "2", "3"))
str_replace(fruits, c("a", "e", "i"), "-")

#If you want to apply multiple patterns and replacements to the same string, pass a named version to pattern
str_replace_all(str_c(fruits, collapse = "---"),
                c("one" = 1, "two" = 2, "three" = 3))

#str_replace_na
#Turn NA into "NA"
str_replace_na(c("NA", "abc", "def"))
str_replace_na(NA, "LIFEI")

#str_split
#split up a string into piecesfruits <- c(
fruits <- c(
  "apples and oranges and pears and bananas",
  "pineapples and mangos and guavas"
)

str_split(fruits, " and ")
str_split(fruits, " and ", n = 3) #force to split into 3 pieces

#use fixed to return a character matrix
str_split_fixed(fruits, " and ", n = 3)

#str_sub
hw <- "Hadley Wickham"
pos <- str_locate_all(hw, "[aeio]")[[1]]
str_sub(hw, pos)
str_sub(hw, pos[, 1], pos[, 2])

#str_subset
#keep strings matching a pattern
str_subset(fruits, "^o")
str_subset(fruits, "e$")

#missings are silently dropped
str_subset(c("a", NA, "b"), ".") #NA was dropped automatically

#str_trim
#also similarly, str_pad to add whitespace
str_trim("this   ", side = "right")#remove right side whitespace
str_trim("this   ", side = "left") #no change
str_trim("  String with trailing and leading white space\t")
str_trim("String with trailing and leading white space", side = "both")

#str_wrap
#Wrap strings into nicely formatted paragraphs
thanks_path <- file.path(R.home("doc"), "THANKS")
thanks <- str_c(readLines(thanks_path), collapse = "\n")
thanks <- word(thanks, 1, 3, fixed("\n\n"))
cat(str_wrap(thanks), "\n")
cat(str_wrap(thanks, width = 40), "\n")
cat(str_wrap(thanks, width = 60, indent = 2), "\n")
cat(str_wrap(thanks, width = 60, exdent = 2), "\n")
cat(str_wrap(thanks, width = 0, exdent = 2), "\n")


#word
#extract words from a sentence
sentences <- c("Jane saw a cat", "Jane sat down")
word(sentences, 1)
word(sentences, 2)
word(sentences, -1)
word(sentences, 2, -1)

# Also vectorised over start and end
word(sentences[1], 1:3, -1)
word(sentences[1], 1, 1:4)

# Can define words by other separators
str <- 'abc.def..123.4568.999'
word(str, 1, sep = fixed('..'))
word(str, 2, sep = fixed('..'))


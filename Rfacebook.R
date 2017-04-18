setwd("F:/Rfacebook/")

library(Rfacebook)
# library(rvest)

# fb_oauth <- fbOAuth(app_id="youridhere", app_secret="yoursecrethere", extended_permissions = TRUE)
# 
# save(fb_oauth, file="fb_oauth")

load("fb_oauth")


# function getUsers() -----------------------------------------------------
# Extract information about one or more facebook users
# Here is my personal facebook profile
me <- getUsers(users = "youruserid", token = fb_oauth, private_info = T)
me

# function getLikes -------------------------------------------------------
my_likes <- getLikes(user = 'me', token=fb_oauth)


# function getFriends() ---------------------------------------------------
# Only friends who use the application will be returned
getFriends(token = fb_oauth, simplify = FALSE)


# function getGroup() -----------------------------------------------------
# Find Facebook ID for R-Users Facebook group
ids <- searchGroup(name = "hospital", token = fb_oauth)
ids[2,3]

# Downloading posts from R-Users Facebook group in January 2013
group <- getGroup(group_id = "493857343989246", token = fb_oauth, since = '2013/01/01', until = '2013/01/31')


# function getInsights() --------------------------------------------------
# Getting page impressions for facebook's facebook page
insights <- getInsights(object_id = "20531316728", token = fb_oauth, metric = 'page_impressions')

# Getting post impressions for a random facebook's page post
insights <- getInsights(object_id = '221568044327801_754789777921289', token = fb_oauth, metric = 'post_impressions', period = 'days_28')


# function getNetwork() ---------------------------------------------------
# Only friends who use the application will be returned
mat <- getNetwork(token = fb_oauth, format = "adj.matrix")
library(igraph)
network <- graph.adjacency(mat, mode = "undirected")
plot(network)


# function getNewsfeed() --------------------------------------------------
my_newsfeed <- getNewsfeed(token = fb_oauth, n = 100)


# function getPage() ------------------------------------------------------
# Getting information about facebook's facebook page
fb_page <- getPage(page = "facebook", token = fb_oauth)

Orangekampong <- getPage(page = "myorangekampong", token = fb_oauth, n = 100)

NUS <- getPage(page = "nationaluniversityofsingapore", token = fb_oauth, n=100)

SGAirlines <- getPage(page = "singaporeairlines", token = fb_oauth, n = 100)

SGgovernment <- getPage(page = "gov.sg", token = fb_oauth, n = 100)

LHL <- getPage(page = "leehsienloong", token = fb_oauth, n = 100)

Straitstimes <- getPage(page = "thestraitstimes", token = fb_oauth, n = 100)

ChannelNewsAsia <- getPage(page = "channelnewsasia", token = fb_oauth, n = 100)

Today <- getPage(page = "today", token = fb_oauth, n = 100)

HumanNY <- getPage(page="humansofnewyork", token=fb_oauth, feed=TRUE, n = 100)

KTPH <- getPage(page = "khooteckpuathospital", token = fb_oauth, n = 100)

UTI <- getPage(page = "urinarytractinfection", token = fb_oauth, n=100)

Rio_2016 <- getPage(page = "2016olympics", token = fb_oauth, n=100)
# function getPost() ------------------------------------------------------
# This is a very useful function.
# It can receive information about a public facebook post including a list of comments and likes
KTPH_Post <- getPost(post = "120946307917945_1216981231647775", token = fb_oauth, n=1000, comments = TRUE, likes = TRUE)


# functions getReactions() ------------------------------------------------
# Extract total count of reactions to one or more facebook posts
KTPH_PostReaction <- getReactions(post = KTPH$id[1:100], token = fb_oauth, verbose = TRUE)


# function getShares() ----------------------------------------------------
KTPH_Shares <- getShares(post = KTPH$id[3], token = fb_oauth, n=1000)



# function searchPages() --------------------------------------------------
# Search pages that mention a string
FBPages <- searchPages("facebook", token = fb_oauth, n = 200)

KTPHPages <- searchPages("ktph", token = fb_oauth, n = 100)


# function updateStatus() -------------------------------------------------
# Update facebook status from R
updateStatus("Testing", token = fb_oauth)


## convert Facebook date format to R date format
format.facebook.date <- function(datestring) {
  date <- as.POSIXct(datestring, format = "%Y-%m-%dT%H:%M:%S+0000", tz = "GMT")
}

## aggregate metric counts over month
aggregate.metric <- function(metric) {
  m <- aggregate(HumanNY[[paste0(metric, "_count")]], list(month = HumanNY$month), 
                 mean)
  m$month <- as.Date(paste0(m$month, "-15"))
  m$metric <- metric
  return(m)
}

# create data frame with average metric counts per month
HumanNY$datetime <- format.facebook.date(HumanNY$created_time)
HumanNY$month <- format(HumanNY$datetime, "%Y-%m")
df.list <- lapply(c("likes", "comments", "shares"), aggregate.metric)
df <- do.call(rbind, df.list)

# visualize evolution in metric
library(ggplot2)
library(scales)
ggplot(df, aes(x = month, y = x, group = metric)) + geom_line(aes(color = metric)) + 
           scale_x_date(breaks = "years", labels = date_format("%Y")) + 
           scale_y_log10("Average count per post", breaks = c(10, 100, 1000, 10000, 50000)) + theme_bw() + theme(axis.title.x = element_blank())



#library(testthat)
#library(ROAuth)
#library(RCurl)

context("checking Authentication")

# preacquire consumer key and secret by working with apps.twitter.com
consumerKey <- "yvXM5zB1VtAGNBuHXlseaKJ2g"
consumerSecret <- "sJHBriUJd4yqtWa60npJrG8By13rtfqrU1URVDA8geAmSEr3tl"
# Create the twitCred credentials
twitCred <- ROAuth::OAuthFactory$new(consumerKey=consumerKey,
                                     consumerSecret=consumerSecret,
                                     requestURL="https://api.twitter.com/oauth/request_token",
                                     accessURL="https://api.twitter.com/oauth/access_token",
                                     authURL="https://api.twitter.com/oauth/authorize")

context("Authentication complete")
test_that("twitCred is valid", {
  
  # read a set twitCred field to see whether it is available. 
  # If it is and matches a known value, this is confirmation that twitCred has been set up
  expect_equal(twitCred$requestURL, "https://api.twitter.com/oauth/request_token")
  
}
)
context("twitCred is valid")
origop <- options("httr_oauth_cache")
options(httr_oauth_cache=TRUE)
suppressWarnings(twitteR::setup_twitter_oauth(consumer_key = twitCred$consumerKey,
                             consumer_secret=twitCred$consumerSecret,
                             access_token = "285069938-ls4UHjJU2eGt5DdQsPkQsmsYt16SeDzloKPrqUvU",
                             access_secret = "xbnK50700XY6SQjBOFEAp276R8jFy1BzPtohMse2nvARV"))
# Restore the original cache option
options(httr_oauth_cache=origop)

context("checking twitterBuildDatabase")

#Test Parameters
lat = "37.794108"
long = "-122.39511"
miles = "15"
since = "2014-10-01"
numberOfTweets = 100

expect_that(as.numeric(lat), is_more_than(-0.000001))
expect_that(as.numeric(lat), is_less_than(90.000001))

expect_that(as.numeric(long), is_more_than(-179.999999))
expect_that(as.numeric(long), is_less_than(180.000001))

expect_that(numberOfTweets, is_more_than(0))
expect_that(numberOfTweets, is_less_than(301))

expect_that(as.numeric(miles), is_more_than(0))
getTweetsStatus <- suppressWarnings(twitterBuildDatabase(search.string = "Giants", lat=lat, long=long, miles=miles, 
                                                     since=since, numberOfTweets = numberOfTweets))



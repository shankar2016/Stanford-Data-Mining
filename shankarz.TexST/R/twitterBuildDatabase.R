#' @title shankarz.TexST : Get tweets from Twitter, given user credentials and tokens.
#'
#' @description
#' \code{twitterBuildDatabase} \cr
#' Gets tweets from within an area specified by within-miles of a location specified by lattitude and longitude
#' 
#' @details
#' This function conducts a search that pulls tweets that originated within miles 
#' of lat, long that have been tweeted after the date specified by the since parameter. 
#' Optionally, this function also accepts a search string for the query.
#' 
#' 
#' @param search.string An optional search string to query Twitter.
#' @param lat A string of latitude numerics.
#' @param long A string of longitude numeric.
#' @param miles The number of miles for radius of search (as string).
#' @param since The start date for the Twitter search ("yyyy-mm-dd").
#' @param numberOfTweets Number of tweets requested from Twitter.
#'
#' @return A data.frame of twitter tweets.
#' 
#' 
#' @export
#' 
#' @examples
#'  message("To run twitterBuildDatabase, it is mandatory to have have run TwitterAuthenticate()")
#'  \dontrun{
#'  # This routine will work but because it needs internet access, it is disabled
#'  # for example check. This will ensure no unexpected failure during checks performed
#'  # during verification of the Stat290 final project
#'  twitterAuthenticate()
#'  
#'  twitterBuildDatabase(search.string = "Giants", lat="37.794108", long="-122.39511", 
#'            miles="15", since="2014-10-01", numberOfTweets = 100)
#'  }
# 

##
## Begin shankarz code
##
twitterBuildDatabase <- function (search.string = "", lat="", long="",
                              miles="", since="", numberOfTweets = 1) {
  
  validInput <- TRUE
  # Require user to input values for lat, long, miles, and date
  # Further error will be reported by the Twitter API
  if (lat=="") {
    message("\nPlease include a valid latitude for lattitude, the \"lat\" parameter")
    validInput <- FALSE
  }
  
  if (long=="") {
    message("\nPlease include a valid longitude for longitude, the \"long\" parameter")
    validInput <- FALSE
  }
  
  if (miles=="") {
    stop("\nlease include a valid number of miles for radius, only a positive numeral")
    validInput <- FALSE
  }
  
  if (since=="") {
    stop("\nPlease include a valid start day (yyyy-mm-dd) for the parameter \"since\"")
    validInput <- FALSE
  }
  
  if (numberOfTweets >= 300) {
    print("\nRequest for more than 300 tweets may cause rate limiting by Twitter")
    validInput <- FALSE
  }
  
  if (validInput == FALSE)
      stop

  
  # construct Geocode in Twitter format from user input
  gcode <- gcode <- paste(lat,",",long,",",miles,"mi", sep="")
  
  # Query Twitter
  # The parameter checks are complete. Assume that we have a very legit search call.
  # Now SUPPRESS ALL MESSAGES because we do have a ligitimate call
  # Twitter error handler will handle other calls
  tweets <- suppressWarnings(twitteR::searchTwitter(search.string, n=numberOfTweets, geocode = gcode, since=since, lang="en"))
  
  # Put data into a data frame and return a data frame
  tweetsDF = plyr::ldply(tweets, function(t) t$toDataFrame())
}

##
## End shankarz code
##
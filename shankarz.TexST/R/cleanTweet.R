#
# This is a utility function that is used internal to the TexST package
# It is not exported or documented externally. 
# This utility function is used to clean up Twitter tweet data
# Both shankarz and mtr worked on this code
##
## Begin mtr code
##
##
## Begin shankarz code
##
.cleanTweet <- function (tweetString) {
  
  # Remove non-standard characters from tweet
  # Remove punctuation
  tweetString <- stringr::str_replace_all(tweetString, "[^[:alnum:]]", " ")
  tweetString <- stringr::str_replace_all(tweetString, " t ", " ")
  tweetString <- stringr::str_replace_all(tweetString, " co ", " ")
  tweetString <- stringr::str_replace_all(tweetString, " http ", " ")
}
##
## End shankarz code
##
##
## End mtr code
##
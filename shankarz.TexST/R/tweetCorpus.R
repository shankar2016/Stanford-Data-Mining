# This is a utility function that is used internal to the TexST package
# It is not exported or documented externally. 
# The . prefix is to ensure that the file is treated as a private file

# This file  in not presented for external use and so is not documented

##
## Begin mtr code
##
.tweetCorpus <- function (tweetDF, tweet=NULL) {
  
  # Get a character vector from the tweetDF local frame where each entry is a tweet
  tweetsVector <- tweetDF$text
  
  # If the tweet text field is not NULL, add that tweet to the tweetsVector
  if (!is.null(tweet)) {
    tweetsVector <- c(tweetsVector, tweet)
  }
  
  # Clean each tweet in the tweets Vector
  tweetsVector <- lapply(tweetsVector, .cleanTweet)
  
  # Use the tm::library function to create a corpus object
  # A VCorpus represents a collection of text documents. A corpus is an abstract concept in data
  # mining. The default implementation implemented in R is Volatile Corpus. Volatile,
  # because the in-memory object dies when the R object ends life.
  tweetCorpus <- tm::VCorpus(VectorSource(tweetsVector))
  
  # Remove whitespace
  tweetCorpus <- tm::tm_map(tweetCorpus, stripWhitespace, mc.cores=1)
  
  # Remove English Stop-Words
  # In computing, stop words are words which are filtered out before or after processing of 
  # natural language data (text). There is no single universal list of stop words used by all 
  # processing of natural language tools, and indeed not all tools even use such a list.
  tweetCorpus <- tm::tm_map(tweetCorpus, removeWords, stopwords("english"))
  
}
##
## End mtr code
##
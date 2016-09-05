##
## Begin shankarz comments
##
#' @title generateTweetRecommendations : Given a new tweet, return n recommended tweets.
#'
#' @description
#' \code{generateTweetRecommendations}\cr
#' Recommends tweets in the corpus given a seed tweet.
#' 
#' @details
#' This function constructs a DocumentTermMatrics (reference: package tm) that
#' is weighted by TF-IDF in order to show similar words to any 
#' given tweet. Given a seed tweet, this function adds the tweet to the 
#' corpus, calculates TF-IDF on the entire set, and recommends n similar 
#' tweets based on text similarity.
#' 
#' @import tm
#' @import slam
#' 
#' @param tweetDF A data.frame returned from the prior step that called twitterBuildDatabase().
#' @param tweet The seed string for which recommendations will be returned for.
#' @param num_recs The number of recommendations requested.
#' 
#' @return tweets recommended for the seed tweet.
#' 
#' @export
#' @examples
#'    generateTweetRecommendations(sfTweets, tweet="sourdough", num_recs=10)

##
## Begin mtr code
##
generateTweetRecommendations <- function (tweetDF, tweet=NULL, num_recs=10) {

  # Add seed tweet to corpus
  corpus <- .tweetCorpus(tweetDF, tweet)
  
  # Generate DTM
  # COMMENT TEXT FROM Wikipedia: http://en.wikipedia.org/wiki/Document-term_matrix
  # A document-term matrix or term-document matrix is a mathematical matrix that describes the 
  # frequency of terms that occur in a collection of documents. In a document-term matrix, rows 
  # correspond to documents in the collection and columns correspond to terms. There are various 
  # schemes for determining the value that each entry in the matrix should take. 
  # One such scheme is tf-idf. DTMs are used in the field of natural language processing.
  dtm <- DocumentTermMatrix(corpus, control = list(weighting = weightTfIdf,
                                                   removePunctuation=TRUE,
                                                   removeNumbers=TRUE,
                                                   toLower=TRUE))
  
  ## Reference: http://anythingbutrbitrary.blogspot.com/2013/03/build-search-engine-in-20-minutes-or.html
  ## An example term-document matrix 
  ## 
  ## Non-/sparse entries: 21/91
  ## Sparsity           : 81%
  ## Maximal term length: 8 
  ## Weighting          : term frequency (tf)
  ## 
  ##           Docs
  ## Terms      doc1 doc2 doc3 doc4 doc5 doc6 doc7 query
  ##   all         1    0    0    0    0    0    0     0
  ##   and         0    0    0    0    1    0    0     0
  ## and so on.......
  
  
  # Get TF-IDF scored vector for tweet
  v <- dtm[dtm$nrow, 1:dtm$ncol]
  
  # Find similar tweets from the DTM
  similarityVector <- slam::matprod_simple_triplet_matrix(dtm, t(v))
  
  # Remove the search tweet itself
  similarityVector <- similarityVector[1:(length(similarityVector) - 1)]
  
  # Order the similarity tweets
  similarTweetInd <- order(similarityVector, decreasing=TRUE)
  
  # Get a character vector from the tweet database where each entry is a tweet
  tweetText <- tweetDF$text
  
  # Return top num_recs similar tweets
  similarTweetInd <- similarTweetInd[1:num_recs]
  
  # print out the number of similar tweets requested
  tweetText[similarTweetInd]
}
##
## End mtr code
##

##
## End shankarz comments
##
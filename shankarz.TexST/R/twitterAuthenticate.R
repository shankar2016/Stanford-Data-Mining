##
## Begin shankarz code
##
#' @title shankarz.TexST : Set up and complete Twitter authentication.
#'
#' @description
#' \code{twitterAuthenticate} \cr
#' Authenticates user session with Twitter
#' 
#' @details
#' 
#' Prerequisite task (to be completed at dev.twitter.com) \cr
#' The dev.twitter.com application control panel provides the ability to generate an OAuth access \cr
#' token for the owner of this application. Visit the -My applications- page by navigating to \cr
#' appsdottwitterdotcom, or hover over the profile image in the top right hand corner of the twitter \cr
#' site and select -My applications-. \cr\cr
#' The Applications page contains a list of the applications, along with a button to create a new \cr
#' application. Select the application you wish to generate a token for, and click on its title. Then \cr
#' Click on the -Create my access token- button, and an authorized access token and secret will be \cr
#' generated for this account and the current application. \cr
#' \cr
#' Once the access tokens have been generated, they are to be into this function. Knowing the tokens, \cr
#' the shankarz.TexST application will subsequently make requests on behalf of this R session.\cr
#' \cr
#' Once the prequisite task is complete, twitterAuthenticate will succeed in accessing the Twitter server \cr
#' with the pre-generated access token and secret: \cr
#' In summary, this function: \cr
#' 1). Sets up the wtitter credentials for session authentication \cr
#' 2). Accesses the Twitter servers and authorizes the local host and local user\cr
#' 
#' 
#' \url{http://dev.twitter.com} for more details.
#'  
#' @import RCurl
#'  
#' @export
#' @examples
#' \dontrun{
#'    # This routine will work but because it needs internet access, it is disabled
#'    # for example check. This will ensure no unexpected failure during checks performed
#'    # during verification of the Stat290 final project
#'    twitterAuthenticate()
#'  }

twitterAuthenticate <- function() {
  
  # Download a Curl certificate, based on SSL for this session
  # Store the file one level higher to avoid NOTES in devtools::check()
  download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="../cacert.pem")
  
  # REFERENCE : dev.twitter.com
  # REFERENCE : Numerous references on Certificate Authority, including Wikipedia
  # REFERENCE : https://dev.twitter.com/oauth/overview/authentication-by-api-family
  
  # preacquire consumer key and secret by working with apps.twitter.com
  # hardcoded here for Instructor to verify
  consumerKey <- "xx"
  consumerSecret <- "YY"
  
  # Create the twitCred credentials to be used for Twitter authentication
  twitCred <- ROAuth::OAuthFactory$new(consumerKey=consumerKey,
                                       consumerSecret=consumerSecret,
                                       requestURL="https://api.twitter.com/oauth/request_token",
                                       accessURL="https://api.twitter.com/oauth/access_token",
                                       authURL="https://api.twitter.com/oauth/authorize")
  
  # Turn on local cache for storing oauth so that authentication can be completed without manual intervention
  # REFERENCE : Stackforge
  # http://stackoverflow.com/questions/28221405/automated-httr-authentication-with-twitter-provide-response-to-interactive-pro
  origop <- options("httr_oauth_cache")
  options(httr_oauth_cache=TRUE)
  
  #Using twiCred credentials for the local host on this sesssion, authenticate with Twitter
  tryCatch((twitteR::setup_twitter_oauth(consumer_key = twitCred$consumerKey,
                                consumer_secret=twitCred$consumerSecret,
                                access_token = "ZZ",
                                access_secret = "AA")),
                                error = print("Please establish and verify connection with Twitter.com and the corresponding tokens"))
  
  # Restore the original cache option
  options(httr_oauth_cache=origop)
}

##
## End shankarz code
##

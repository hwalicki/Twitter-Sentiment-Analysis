################## TWITTER SENTIMENT FUNCTIONS ###################

# Load munging functions
source("MungingFuns.r")

### Score most recent 500 tweets
scoreRecent = function(keywords, tweetNum) {
  
  tweets <- searchTwitter(keywords, n=tweetNum)
  df <- do.call("rbind", lapply(tweets, as.data.frame))
  text <- cleanText(tweets)
  
  # Clean
  scores <- sapply(text, function(verbiage) {
    
    # Split & Score
    words <- unlist(str_split(verbiage, "\\s+"))
    verbiageValences <- lexicon[lexicon$Word %in% words,]
    meanVerbiageValence <- mean(verbiageValences$V.Mean.Sum)
    
    return(meanVerbiageValence)
  })
  
  # Get sources
  sources <- cleanSources(tweets)
  finalDf <- cbind(scores, text, df[,c(5,11)], sources)
  
  return(finalDf)
}


### Score longitudinal tweets (FUTURE)
scoreLongitudinal = function() {
}


### Get words by count in a set of tweets
getWordsByCount = function(texts) {
  
  # We assume these were cleaned already
  rawWords <- data.frame(Word=character())
  
  splits <- sapply(texts, function(verbiage) {
    
    words <- as.data.frame(unlist(str_split(verbiage, "\\s+")))
    colnames(words) <- c("Word")
    rawWords <<- rbind(rawWords, words)
    
    return(rawWords)
  })
  
  counts <- as.data.frame(table(rawWords$Word))
  colnames(counts) <- c("Word","Count")
  
  return(counts)
}
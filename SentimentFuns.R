################## TWITTER SENTIMENT FUNCTIONS ###################

# Load munging functions
source("MungingFuns.r")

### General scoring function
score = function(tweets) {
  
  df <- do.call("rbind", lapply(tweets, as.data.frame))
  text <- cleanText(tweets)
  
  scores <- sapply(text, function(verbiage) {
    
    words <- unlist(str_split(verbiage, "\\s+"))
    verbiageValences <- lexicon[lexicon$Word %in% words,]
    meanVerbiageValence <- mean(verbiageValences$V.Mean.Sum)
    
    return(meanVerbiageValence)
  })
  
  # Get sources
  sources <- cleanSources(tweets)
  finalDf <- cbind(scores, text, df[,c(5,11)], sources)
  gc()
  
  return(finalDf)
}


### Score most recent 500 tweets
scoreRecent = function(keywords, tweetNum) {
  
  tweets <- searchTwitter(keywords, n=tweetNum)
  gc()
  
  finalDf <- score(tweets)
  
  return(finalDf)
}


### Get all words in a set of tweets
getRawWords = function(texts) {
  
  # We assume these were cleaned already
  rawWords <- data.frame(Word=character())
  
  splits <- sapply(texts, function(verbiage) {
    
    words <- as.data.frame(unlist(str_split(verbiage, "\\s+")))
    colnames(words) <- c("Word")
    rawWords <<- rbind(rawWords, words)
    
    return(rawWords)
  })
  
  return(rawWords)
}


### Get word counts & valences
getWordsByCount = function(wordList) {
  
  counts <- as.data.frame(table(wordList))
  colnames(counts) <- c("Word","Count")
  counts$Word <- as.character(counts$Word)
  counts$Valence <- sapply(counts$Word, function(word) {
    
    val <- lexicon$V.Mean.Sum[lexicon$Word==word]
    return(val)
    
  })
  
  counts <- counts[order(-counts$Count),]
  
  return(counts)
}


### Create word cloud
createWordCloud = function(wordList, discludedWords) {

  cleanWordList <- wordList[!(wordList$Word %in% discludedWords),]
  
  wordcloud(cleanWordList, scale=c(5,0.5), max.words=50, random.order=FALSE, 
            rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(6, "Dark2"))
}
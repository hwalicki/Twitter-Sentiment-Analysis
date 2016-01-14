################## TWITTER MUNGING FUNCTIONS ###################

### Clean tweet text
cleanText = function(tweets) {
  
  texts <- sapply(tweets, function(tweet) {
    
    verbiage <- tweet$getText()
    
    # Remove emoticons, punctuation, digits, capital letters
    verbiage<- iconv(verbiage, "latin1", "ASCII", sub="")
    verbiage <- gsub("[[:punct:]]", "", verbiage)
    verbiage <- gsub("[[:cntrl:]]", "", verbiage)
    verbiage <- gsub("\\d+", "", verbiage)
    verbiage <- tolower(verbiage)
    
    return(verbiage)
  })
  
  return(texts)
}


### Clean tweet sources
cleanSources = function(tweets) {
  sources <- sapply(tweets,function(x) x$getStatusSource())
  sources <- gsub("</a>","",sources)
  sources <- strsplit(sources,">")
  sources <- sapply(sources, function(x) ifelse(length(x)>1,x[2],x[1]))
  
  return(data.frame(sources))
}
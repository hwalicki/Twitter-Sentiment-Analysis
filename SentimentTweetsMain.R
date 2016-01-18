#### GREAT LAKES TWITTER SENTIMENT ANALYSIS ######
library(ROAuth)
library(twitteR)
library(stringr)
library(ggplot2)
library(wordcloud)

#### NOTE: You must set up a Twitter account & get an access token ####
#consumerKey="your_given_consumer_key"
#consumerSecret="your_given_consumer_secret"
#accessToken="your_given_access_token"
#accessSecret="your_given_access_secret"
#setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessSecret)

# Load functions
source("SentimentFuns.r")

# Load lexicon
# Original Source: http://crr.ugent.be/archives/1003
lexicon <- read.csv("Ratings_Warriner_et_al.csv")[c("Word","V.Mean.Sum")]
lexicon <- lexicon[lexicon$Word!="superior",] #Remove 'superior'


## Search & Score ##
num <- 5000
superior <- scoreRecent("Lake Superior", num)
erie <- scoreRecent("Lake Erie", num)
huron <- scoreRecent("Lake Huron", num)
ontario <- scoreRecent("Lake Ontario", num)
michigan <- scoreRecent("Lake Michigan", num)

# Graph Mean Scores
totals <- data.frame(Lake=c("Lake Superior", "Lake Erie", "Lake Huron", "Lake Ontario", "Lake Michigan"), 
                     Score=c(mean(superior$scores[!is.na(superior$scores)]), mean(erie$scores[!is.na(erie$scores)]), 
                             mean(huron$scores[!is.na(huron$scores)]), mean(ontario$scores[!is.na(ontario$scores)]), 
                             mean(michigan$scores[!is.na(michigan$scores)])))
totals$Lake <- factor(totals$Lake, levels = totals$Lake[order(totals$Score)])

# Plot
ggplot(data=totals, aes(x=Lake, y=Score, fill=Lake)) + 
  geom_bar(colour="black", fill="#4ca679", width=.8, stat="identity") + 
  guides(fill=FALSE) +
  ggtitle("Mean Valence for Most Recent 500 Tweets") +
  ggplot2::annotate("text", x=5.4, y=6.475, label=Sys.Date()) +
  coord_cartesian(ylim=c(6,6.5))


## Word Counts for Superior & Erie ##
superiorWords <- getRawWords(superior$text)
superiorCounts <- getWordsByCount(superiorWords)
head(superiorCounts[!(is.na(superiorCounts$Word[superiorCounts$Valence>0])),], 20)

erieWords <- getRawWords(erie$text)
erieCounts <- getWordsByCount(erieWords)
head(erieCounts[!(is.na(erieCounts$Word[erieCounts$Valence>0])),], 20)

# Word Cloud
createWordCloud(superiorWords, c("lake","superior"))
createWordCloud(erieWords, c("lake","erie"))








# Twitter-Sentiment-Analysis
Analyzing the valence of the U.S. Great Lakes

## Methodologies
My goal was to analyze the public's sentiment towards each of the U.S. Great Lakes. There is a large Erie vs. Superior debate in our household, and I decided to test my personal hypothesis that, like it's name, Lake Superior is the most admirable of the lakes. I gathered a recent set of tweets about each lake and used the lexicon described below to score each lake, as well as look at the most used words in tweets about Erie and Superior.

After considerable research into various tools for sentiment analysis, I chose to use the included lexicon by Warriner & Kuperman. This decision came about due to the comprehensiveness of their lexicon and the relative reliability of their methods. A reference to the source of their dataset is listed below. Although a lexicon is not ideal in jargon-filled text such as a Twitter mine, it was chosen for its simplicity in an example setting. 

## Sources
[English Valence Lexicon](http://crr.ugent.be/archives/1003/)

[Validity](http://crr.ugent.be/papers/Warriner_et_al_affective_ratings.pdf)

## Conclusions
Judging based on mean scores, Lake Superior is indeed superior to Lake Erie, though the gap between the two lakes in question is not as large as I'd comfortably like it to be. Additionally, there are many assumptions made when dealing with only a small set of recent data, that could very well contain biases. Ideally, I would like to do some longitudinal research on valences for each lake, however, the API only returns tweets within the last week. Over time, I may start scoring each day's lake tweets to get a better sense of valence regardless of season.

<img src="Great Lakes Valence 2016-01-17.jpeg">


##### Lake Superior Word Cloud:
<img src="Superior Word Cloud 2016-01-17.jpeg">


##### Lake Erie Word Cloud:
<img src="Erie Word Cloud 2016-01-17.jpeg">

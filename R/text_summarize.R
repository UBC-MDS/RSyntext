#' Created on 09 February, 2019
#' Implementation of text_summarize function in the RySyntext package.


#' This function returns a DataFrame with total word count,
#' total sentence count, most common and least common word, average
#' word length, and average sentence length. Each information resides
#' in a separate column.


#' Takes in a string and returns a data.frame with one row and six columns.
#' First column contains the total word count of the string.
#' Second column contains the total number of sentences in `text`.
#' Third column contains a list of the most common words in `text`. If this returns a
#'   list of length 1, there is only one most common word. If this
#'   returns a list of length > 1, there are multiple words that appear
#'   the most number of times in `text`.
#' Fourth column contains a list of the least common words in `text`.
#'   If this returns a list of length 1, there is only one least common word.
#'   If this returns a list of length > 1, there are multiple words that appear
#'   the least number of times in `text`.
#' Fifth column contains the average word length in `text`.
#' Sixth column contains the average number of words in a sentence, in `text`.


#'

#' @param text string
#' @param stopwords_remove Boolean
#' @param lemmatize Boolean
#' @param remove_punctuation Boolean
#' @param remove_numbers Boolean
#' @param case_sensitive Boolean
#' @param gibberish_remove Boolean

#'

#' @return data.frame

#' @export

#'

#' @examples

#' text <- "This is the first sentence in this paragraph. This is the second sentence. This is the third."

#'

#' summary <- text_summarize(text)

text_summarize <- function(text) {
  
  df <- data.frame(word_count=integer(),
                   sentence_count=integer(),
                   most_common=character(),
                   least_common=character(),
                   avg_word_length=integer())
  df[nrow(df) + 1,] = list(0,0,'','',0)
  
  #text=clean(text)
  
  df$word_count=lengths(gregexpr("\\W+", text))
  
  df$sentence_count=length(gregexpr('[[:alnum:] ][.!?]', text)[[1]])
  
  text_split=c(unlist(strsplit(text, split=" ")))
  
  # average word length
  total=0
  for (i in 1:length(text_split)){
    total=total+nchar(text_split[i])
  }
  df$avg_word_length= total/length(text_split)
  
  # most common word
  table=sort(table(text_split), decreasing=T)
  df$most_common=as.vector(list(names(table[table==max(table)])))
  
  # least common word
  df$least_common=as.vector(list(names(table[table==min(table)])))
  
  return (df)

}


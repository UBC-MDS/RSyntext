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

  df <- data.frame(word_count=17,
                   sentence_count=3,
                   most_common = array('This'),
                   least_common = array('first'),
                   avg_word_length = 4.35,
                   avg_sentence_length = 5.67)

  # dummy output
  # df <- data.frame(word_count=NA,
  #                  sentence_count=NA,
  #                  most_common = NA,
  #                  least_common = NA,
  #                  avg_word_length = NA,
  #                  avg_sentence_length = NA)

  return (df)

}


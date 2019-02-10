#' Created on 09 February, 2019
#' auuthor: Harjyot Kaur
#' Implementation of text_grams function in the RySyntext package.


#' This function returns a DataFrame with k top ngrams.
#' ngrams is a combination of n words occuring together with
#' highest frequency in the text. The function will return multiple
#' values in cases of frequency conflict.


#' Takes in a string and returns a data.frame
#' Number of rows are dependent on the input n of the user
#' Size of the list is dependent on the input k of the user

#'

#' @param text string
#' @param k top ngrams
#' @param n n combination of words
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

#' text <-  "Today is a sunny day. We should go to a beach on this sunny day"

#'

#' grams<- text_grams(text)

text_grams <- function(text) {

  #dummy output
  df <- data.frame(bigrams=('sunny,day'))


  return (df)

}


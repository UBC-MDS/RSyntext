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

#' @param txt string
#' @param k top ngrams
#' @param n n combination of words
#' @param stop_remove Boolean
#' @param remove_punctuation Boolean
#' @param remove_number Boolean
#' @param case_sensitive Boolean

#'

#' @return data.frame
#'
#' @import stringr
#' @import tm

#' @export

#'

#' @examples

#' txt <-  "Today is a sunny day. We should go to a beach on this sunny day"

#'

#' grams<- text_grams(txt)

#asdf <- "Today is a Sunny day. We should go to a beach on this sunny day"
#text_grams(asdf)

text_grams <- function(txt, k = 5, n = c(2,3),
                       stop_remove = TRUE,
                       remove_punctuation = TRUE,
                       remove_number = TRUE,
                       case_sensitive = FALSE) {


  final <- data.frame(matrix(NA, nrow = k))
  lbls <- c()

  for (idx in 1:length(n)){
    lbls <- c(lbls, paste0(as.character(n[idx]), "_gram"), "Frequency")
  }

  split_sentences <- unlist(strsplit(txt, "(?<=[[:punct:]])\\s(?=[A-Z])", perl=T))
  #print(split_sentences)

  for (i in 1:length(n)){
    ngrams_list <- c()

    for (sentence in split_sentences){
      clean_text <- clean_text_grams(txt = sentence,
                          rmv_punct = remove_punctuation,
                          rmv_num = remove_number,
                          lower_case = case_sensitive)

      if (stop_remove == TRUE){
        clean_text <- pre_processing(clean_text)
      }
      #print(clean_text)
      #print(create_grams(clean_text, n[i])[1:k])
      ngrams_list <- c(ngrams_list, create_grams(clean_text, n[i]))
    }
    #print(ngrams_list)
    temp <- sort(ngrams_list, decreasing = T)[1:k]
    temp1 <- cbind(names(temp),unname(temp))
    final <- cbind(final,temp1)

  }
  final[,1] = NULL
  colnames(final) <- lbls
  return (final)
}
#asdf <- "Today is a sunny day. We should go to a beach on this sunny day"
#text_grams(asdf)



# THIS SHIT DOESN'T WORK WHEN n is greater than the number of words in a sentence!!!!
create_grams <- function(sentence, n){
  list_of_words <- c()
  split_words <- unlist(strsplit(sentence, " +"))
  #print(split_words)

  for (i in 1:(length(split_words) - (n-1))){
    #print(split_words[i:(i+n-1)])
    list_of_words <- c(list_of_words, paste(split_words[i:(i+n-1)], collapse = " "))
  }

  print(list_of_words)
  table(list_of_words)
}

clean_text_grams <- function(txt, rmv_punct, rmv_num, lower_case){

  if (lower_case == FALSE){
    lower_var <- tolower(txt)
  } else {
    lower_var <- txt
  }

  if (rmv_punct == TRUE){
    # remove tickers
    tickers <- gsub("\\$", "", lower_var)
    # remove new line symbol
    newline <-  gsub('\n','', tickers)
    # remove links
    links <- gsub('http\\S+\\s*','', newline)
    # remove special characters
    punctuation <- gsub("[[:punct:]]", ' ', links)
  } else {
    punctuation <-  lower
  }

  if (rmv_num == TRUE){
    # remove numerical strings
    numeric_words <-  gsub("\\b\\d+\\b", '',punctuation)
  } else {
    numeric_words <-  punctuation
  }

  clean_text <- str_squish(numeric_words)
  return (clean_text)
}

pre_processing <- function(txt){
  stopwords_regex <-  paste(stopwords('en'), collapse = '\\b|\\b')
  stopwords_regex <-  paste0('\\b', stopwords_regex, '\\b')
  no_stop_words <-  str_replace_all(txt, stopwords_regex, '')
  no_stop_words
}

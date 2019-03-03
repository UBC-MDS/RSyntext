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

#' @param txt string
#' @param stop_remove Boolean
#' @param remove_punctuation Boolean
#' @param remove_number Boolean
#' @param case_sensitive Boolean
#'
#' @import stringr
#' @import tm

#' @return data.frame

#' @export

#'

#' @examples

#' txt <- "This is the first sentence in this paragraph.
#'         This is the second sentence. This is the third."

#'

#' summary <- text_summarize(txt)


text_summarize <- function(txt,
                           stop_remove = FALSE,
                           remove_punctuation = TRUE,
                           remove_number = TRUE,
                           case_sensitive = FALSE) {



  df <- data.frame(word_count=integer(),
                   sentence_count=integer(),
                   most_common=character(),
                   least_common=character(),
                   avg_word_length=integer(),
                   avg_sentence_length=integer(),
                   stringsAsFactors=FALSE)


  df[nrow(df) + 1,] = list(0,0,"","",0)


  split_sentences <- unlist(strsplit(txt, "(?<=[[:punct:]])\\s(?=[A-Z])", perl=T))
  df$sentence_count <- length(split_sentences)

  if(case_sensitive==FALSE){
    split_sentences <- tolower(split_sentences)}

  clean_sentence <- clean_text_summarize(split_sentences, remove_punctuation, remove_number, case_sensitive)

  if (stop_remove == TRUE){
    clean_sentence <- pre_processing(clean_sentence)

  }

  df$avg_sentence_length <- sum(mapply(nchar, clean_sentence))/df$sentence_count


  txt_split <- c(unlist(strsplit(clean_sentence, split=" ")))
  df$word_count <- length(txt_split)



  # average word length

  df$avg_word_length <- sum(mapply(nchar, txt_split))/df$word_count

  # most common word
  table=sort(table(txt_split), decreasing=T)
  df$most_common=as.vector(list(names(table[table==max(table)])))

  # least common word
  df$least_common=as.vector(list(names(table[table==min(table)])))

  return (df)

}



clean_text_summarize <-  function(txt, rmv_punct, rmv_num, lower_case){

  if (lower_case == FALSE){
    lower = tolower(txt)
  } else {
    lower <- txt
  }

  if (rmv_punct == TRUE){
    # remove tickers
    tickers <- gsub("\\$", "", lower)
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
    numeric_words <-  gsub("\\d+\\.*\\d*",'',punctuation )
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
  no_stop_words <- str_squish(no_stop_words)
  return (no_stop_words)
}

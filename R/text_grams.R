#' Create n-grams from text
#'
#' This function returns a DataFrame with `k`` top ngrams.
#' `ngrams`` is a combination of n words occuring together with
#' highest frequency in the text. The function will return multiple
#' values in cases of frequency conflict.
#'
#' Created on 09 February, 2019
#'
#' Authors: Harjyot Kaur, Alexander Pak
#'
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
#'
#' @export
#'
#' @examples
#' txt <-  "Today is a sunny day. We should go to a beach on this sunny day"
#'
#' grams<- text_grams(txt)

text_grams <- function(txt, k = 5, n = c(2,3),
                       stop_remove = TRUE,
                       remove_punctuation = TRUE,
                       remove_number = TRUE,
                       case_sensitive = FALSE) {

  # Check if conditions are boolean
  if (!is.logical(stop_remove) |
      !is.logical(remove_punctuation) |
      !is.logical(remove_number) |
      !is.logical(case_sensitive)){
    stop("Conditions are not Boolean.")
  }

  # Declaring variables
  final <- data.frame(matrix(NA, nrow = k))
  lbls <- c()

  # Creating labels
  for (idx in 1:length(n)){
    lbls <- c(lbls, paste0(as.character(n[idx]), "_gram"), "Frequency")
  }

  # Split all sentences in the input text by: special character followed by a capital letter
  # Try/Catch block to catch any value errors
  result = tryCatch({
    split_sentences <- unlist(strsplit(txt, "(?<=[[:punct:]])\\s(?=[A-Z])", perl=T))
    split_sentences
  }, error = function(e) {
    stop("Input must be a string.")
  })

  # Runs for as long as the specified n values
  for (i in 1:length(n)){

    ngrams_list <- c()

    # Runs for every sentence
    for (sentence in split_sentences){
      # Cleans text based on user specifications
      clean_text <- clean_text_grams(sentence,
                                     remove_punctuation,
                                     remove_number,
                                     case_sensitive)

      # Removes stopwords if specified
      if (stop_remove == TRUE){
        clean_text <- pre_processing(clean_text)
      }
      # Creates a growing vector of grams
      ngrams_list <- c(ngrams_list, create_grams(clean_text, n[i]))
    }
    # Combine the tables together to make a final table with frequencies of all grams
    if (!is.na(ngrams_list)){
      ngrams_list <- table(ngrams_list)

      temp <- sort(ngrams_list, decreasing = T)[1:k]
      temp1 <- cbind(names(temp),unname(temp))
      final <- cbind(final,temp1)

    } else {
      final <- cbind(final, as.factor(NA), as.factor(NA))
    }

  }
  # Remove first column for aesthetics
  final[,1] = NULL
  # Assign labels
  colnames(final) <- lbls


  return (final)
}

# Helper function to create grams
create_grams <- function(sentence, n){
  list_of_words <- c()
  # Split on every word
  split_words <- unlist(strsplit(sentence, " +"))

  # Moving window to combine words in a sentence and create grams
  # Run only if n is less than or equal to the number of words in a sentence
  if (n <= length(split_words)){
    for (i in 1:(length(split_words) - (n-1))){
      list_of_words <- c(list_of_words, paste(split_words[i:(i+n-1)], collapse = " "))
    }
    # Calculate frequency of grams and return
    list_of_words

  # Run if n > number of words in a sentence
  } else {
    # Return a null table
    NA
  }
}

# Clean the input text according to specifications
clean_text_grams <- function(txt, rmv_punct, rmv_num, lower_case){

  # Case sensitivity
  if (lower_case == TRUE){
    lower <-  tolower(txt)
  } else {
    lower <-  txt
  }

  # Punctuation
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

  # Numbers
  if (rmv_num == TRUE){
    # remove numerical strings
    numeric_words <- gsub("\\b\\d+\\b", '',punctuation)

  } else {
    numeric_words <-  punctuation
  }

  # Recombine text and return
  clean_text <- str_squish(numeric_words)


  return (clean_text)
}


# Pre-processing to remove stop words on input text
pre_processing <- function(txt){
  stopwords_regex <-  paste(stopwords('en'), collapse = '\\b|\\b')
  stopwords_regex <-  paste0('\\b', stopwords_regex, '\\b')
  no_stop_words <-  str_replace_all(txt, stopwords_regex, '')
  no_stop_words
}

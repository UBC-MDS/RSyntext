#' Check quality and toxicity of an input string
#'
#' Check quality of the string in terms of spelling errors and toxicity content.
#' The function performs necessary cleaning on the input string.
#'
#' Created on 09 February, 2019
#'
#' Authors: Harjyot Kaur
#'
#' Comparison is done with pre-existing list of
#' exhaustive english words to calculate the spelling errors in the string.
#' Comparison is done with pre-existing list of
#' exhaustive toxic-english words to calculate the toxicity in the string.
#'
#' Takes in a string and returns a data.frame with one row and two columns
#' First column contains proportion of spelling errors in the input
#' contains and the second column storestoxicity in the the input string.
#'
#' @param txt string
#'
#' @return data.frame
#'
#' @import stringr
#' @export
#'
#' @examples
#' txt <- "This str has words spelllll wrong. This string has a slag word shitty."
#'
#' quality <- text_quality(txt)

text_quality <- function(txt) {

  if (!is.character(txt)){stop("Input text must be a string.")}

  # Go through text cleaning before running quality check
  cleaned_text <- clean_text_quality(txt)
  spelling_mistakes <- spell_check(en_dictionary[[1]],cleaned_text)
  toxic_content <- toxicity_check(en_dictionary[[2]],cleaned_text)

  # Run quality check
  quality <- cbind(spelling_mistakes,toxic_content)


  return (quality)
}


# Helper function that cleans the text
clean_text_quality <-  function(txt){
  text="RT $USD @Amila #Test\nTom\'s newly listed Co. &amp; Mary\'s unlisted Group to supply tech for
            nlTK.\nh.. $TSLA $AAPL https://t.co/x34afsfQsh"
  # Remove tickers
  remove_tickers=gsub("\\$", "", txt)
  # Remove new line symbol
  remove_newline = gsub('\n','',remove_tickers)
  # Remove links
  remove_links=gsub('http\\S+\\s*','',remove_newline)
  # Remove special characters
  remove_punctuation=gsub("[[:punct:]]", ' ', remove_links)
  # Remove numerical strings
  remove_numeric_words= gsub("\\b\\d+\\b", '',remove_punctuation)
  clean_text <- str_squish(remove_numeric_words)


  return (clean_text)
}


# Checks the spelling of the input words
spell_check <- function(eng_words,txt){
  spell_error_df <- data.frame(spell_error=character(),
                               count_spell_error=integer(),
                               proportion_spell_error=double(),
                               stringsAsFactors=FALSE)
  spell_error_df[nrow(spell_error_df) + 1,] = list("",0,0.0)

  if (length(unlist(strsplit(txt, split=" ")))!=0){
    eng_words_regex = paste(eng_words, collapse = '\\b|\\b')
    eng_words_regex = paste0('\\b', eng_words_regex, '\\b')
    # get mispelt words
    non_eng_words=str_remove_all(txt, eng_words_regex)
    non_eng_words=str_squish(non_eng_words)

    if (length(unlist(strsplit(non_eng_words, split=" ")))!=0){

        remove_nouns=gsub("[A-Z]([a-z]+)", '',non_eng_words)
        non_eng_words=str_squish(non_eng_words)
        non_noun_words=str_squish(remove_nouns)

        if (length(unlist(strsplit(non_noun_words, split=" ")))!=0){

          spell_error=str_remove_all(tolower(non_noun_words), eng_words_regex)
          spell_error=str_squish(spell_error)
          count=length(unlist(strsplit(spell_error, split=" ")))
          prop=count/(length(unlist(strsplit(txt, split=" "))))
          errors=c(unique(unlist(strsplit(spell_error, split=" "))))
          spell_error_df$spell_error <- list(errors)
          spell_error_df$count_spell_error <- count
          spell_error_df$proportion_spell_error <- prop
      }
    }
  }
  return (spell_error_df)
}




toxicity_check <- function(profane_words,txt){
  toxic_words_df <- data.frame(toxic_words=character(),
                               count_toxic_words=integer(),
                               proportion_toxic_words=double(),
                               stringsAsFactors=FALSE)
  toxic_words_df[nrow(toxic_words_df) + 1,] = list("",0,0.0)
  toxic_words_regex = paste(profane_words, collapse = '\\b|\\b')
  toxic_words_regex = paste0('\\b', toxic_words_regex, '\\b')
  # get mispelt words
  txt=unlist(strsplit(txt, split=" "))
  toxic_words=str_subset(txt,toxic_words_regex)
  if (length(unlist(strsplit(toxic_words, split=" ")))!=0){
    count=length(unlist(strsplit(toxic_words, split=" ")))
    prop=count/(length(unlist(strsplit(txt, split=" "))))
    errors=c(unique(toxic_words))
    toxic_words_df$toxic_words<- list(errors)
    toxic_words_df$count_toxic_words <- count
    toxic_words_df$proportion_toxic_words <- prop
  }
  return (toxic_words_df)
}



context("Test text_summarize")

#'
#' This script tests the text_summarize function of the RSyntext package.
#'
#'
#' The text_summarize function of the RSyntext package checks the
#' gives various summary information about the input string
#' It takes in a string as input and returns a dataframe.
#' The function performs necessary cleaning on the input string.
#'

# Sample input
txt <-  "This is the first sentence in this paragraph. This is the second sentence. This is the third."


#' Test for output type
test_that("Test that output is of type dataframe", {
  expect_true(class(text_summarize(txt))=="data.frame")
})


#' Test for values returned in the dataframe
test_that("Test that outputs are of the right type", {

  output <- text_summarize(txt)

  expect_true(typeof(output$word_count) == "integer")
  expect_true(typeof(output$sentence_count)=="integer")
  expect_true(typeof(output$most_common)=="list")
  expect_true(typeof(output$least_common)=="list")
  expect_true(typeof(output$avg_word_len)=="double")
  expect_true(typeof(output$avg_sentence_len)=="double")

})


#' Test for values returned in the dataframe
test_that("Test that output contains non-negative values", {

  output <- text_summarize(txt)

  expect_true(typeof(output$word_count) >= 0)
  expect_true(typeof(output$sentence_count) >= 0)
  expect_true(typeof(output$avg_word_len) >= 0)
  expect_true(typeof(output$avg_sentence_len) >= 0)

})

#' Test for valid input
test_that("Input should be a string", {
  txt <- 123
  expect_error(text_summarize(txt))
})


#' Test for valid input
test_that("Input should be a string", {

  txt <- ""
  expect_error(text_summarize(txt))
})

#' Test for functionality

test_that("Test that summarizer gives expected output", {

  output <- text_summarize(txt)

  least_common_list <- list(0)
  least_common_list [[1]] <- c('first', 'in', 'paragraph', 'second', 'third')

  expect_true(output$word_count == 17)
  expect_true(output$sentence_count == 3)
  expect_true(output$most_common == "this")
  expect_true(all.equal(c(output$least_common[[1]]),c(least_common_list[[1]])))
  expect_true(output$avg_word_len>= 4.352941-0.5 &
              output$avg_word_len<= 4.352941+0.5  )
  expect_true(output$avg_sentence_len>=29.33333-0.5 &
                output$avg_sentence_len<=29.33333+0.5  )
})


test_that("Test that summarizer gives expected output", {

  output <- text_summarize(txt,
                           stop_remove = TRUE,
                           remove_punctuation = FALSE,
                           remove_number = FALSE,
                           case_sensitive = TRUE)


  least_common_list <- list(0)
  least_common_list [[1]] <- c('first', 'paragraph.', 'second', 'sentence', 'sentence.', 'third.')

  expect_true(output$word_count == 9)
  expect_true(output$sentence_count == 3)
  expect_true(output$most_common == "This")
  expect_true(all.equal(c(output$least_common[[1]]),c(least_common_list[[1]])))
  expect_true(output$avg_word_len>= 6.222222-0.5 &
                output$avg_word_len<= 6.222222+0.5  )
  expect_true(output$avg_sentence_len>=20.66667-0.5 &
                output$avg_sentence_len<=20.66667+0.5  )
})

test_that("Test that error handling is working for boolean parameters", {
  txt <-  "Today is a sunny day. We should go to a beach on this sunny day"
  expect_error(text_summarize(txt, stop_remove = 12))
})

test_that("Test that error handling is working for input text", {
  txt <-  123
  expect_error(text_summarize(txt))
})

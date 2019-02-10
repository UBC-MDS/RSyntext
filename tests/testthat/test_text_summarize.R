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

text <-  "This is the first sentence in this paragraph. This is the second sentence. This is the third."



# sample output

df <- data.frame(word_count=17,

                 sentence_count=3,

                 most_common = array('This'),

                 least_common = array('first'),

                 avg_word_length = 4.35,

                 avg_sentence_length = 5.67)







#' Test for output type



test_that("Test that output is of type dataframe", {



  expect_true(class(text_summarize(text))=="data.frame")



})



#' Test for values returned in the dataframe

test_that("Test that outputs are of the right type", {



  output <- text_summarize(text)



  expect_true(typeof(output$word_count) == "double")

  expect_true(typeof(output$sentence_count)=="double")

  expect_true(typeof(output$most_common)=="character")

  expect_true(typeof(output$least_common)=="character")

  expect_true(typeof(output$avg_word_len)=="double")

  expect_true(typeof(output$avg_sentence_len)=="double")



})





#' Test for values returned in the dataframe

test_that("Test that output contains non-negative values", {



  output <- text_summarize(text)



  expect_true(typeof(output$word_count) >= 0)

  expect_true(typeof(output$sentence_count) >= 0)

  expect_true(typeof(output$avg_word_len) >= 0)

  expect_true(typeof(output$avg_sentence_len) >= 0)



})



#' Test for valid input

test_that("Input should be a string", {



  text <- 123



  expect_error(text_summarize(text))



})





#' Test for valid input

test_that("Input should be a string", {



  text <- ""



  expect_error(text_summarize(text))



})





#' Test for functionality

test_that("Test that summarizer gives expected output", {



  output <- text_summarize(text)



  expect_true(output$word_count == df$word_count)

  expect_true(output$sentence_count == df$sentence_count)

  expect_true(output$most_common == df$most_common)

  expect_true(output$least_common == df$least_common)

  expect_true(output$avg_word_len == df$avg_word_len)

  expect_true(output$avg_sentence_len == df$avg_sentence_len)

})

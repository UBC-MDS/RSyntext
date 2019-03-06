context("Test text_grams")

#'
#' This script tests the text_grams function of the RSyntext package.
#'
#'
#' The text_grams function of the RSyntext package checks the
#' gives various summary information about the input string
#' It takes in a string as input and returns a dataframe.
#' The function performs necessary cleaning on the input string.
#'

#' Test for output type
test_that("Test that output is of type dataframe", {
  txt <-  "Today is a sunny day. We should go to a beach on this sunny day"
  expect_true(class(text_grams(txt)) == "data.frame")
})

#' Test for values returned in the dataframe
test_that("Test that outputs are of the right type", {
  txt <-  "Today is a sunny day. We should go to a beach on this sunny day"
  output <- text_grams(txt)
  expect_true(class(output$'2_gram')=="factor")
})


#' Test for length of dataframe matches argument passed
test_that("Test that output matches arguments passed", {
  txt <-  "Today is a sunny day. We should go to a beach on this sunny day"
  output <- text_grams(txt)
  expect_true(dim(output)[1]==5)
  expect_true(dim(output)[2]==4)
})

test_that("Test normal function", {
  txt <-  "Today is a sunny day. We should go to a beach on this sunny day."
  output <- text_grams(txt)
  print(output)
  expect_true(output[[2]][[1]] == 2)
})


test_that("Test normal function for full branch coverage", {
  txt <-  "Today is a Sunny day. We should go to a beach on this sunny day"
  output <- text_grams(txt,
                       stop_remove = FALSE,
                       remove_punctuation = FALSE,
                       remove_number = FALSE,
                       case_sensitive = TRUE)
  expect_true(output[[2]][[1]] == 1)
})

test_that("Test that error handling is working for boolean parameters", {
  txt <-  "Today is a sunny day. We should go to a beach on this sunny day"
  expect_error(text_grams(txt, stop_remove = 12))
})

test_that("Test that error handling is working for input text", {
  txt <-  123
  expect_error(text_grams(txt))
})

test_that("Test when n > number of words in input sentence", {
  txt <-  "Cell phone expensive."
  expect_true(is.na(text_grams(txt, n = c(4))[, 1][[1]]))
})

context("Test text_quality")

#'

#' This script tests the text_quality function of the PySyntext package.
#'
#'
#' text_quality function of the PySyntext package, checks the
#' quality of the string in terms of spelling errors and toxicity content.
#' It takes in a string as input and returns a dataframe.
#' The function performs necessary cleaning on the input string.
#'



# Sample input
text <-  "This str has words spelllll wrong. This string has a slag word shitty."

# sample output
df <- data.frame(spell_error=0.15, toxicity=0.08)



#' Test for output type

test_that("Test that output is of type dataframe", {

  expect_true(class(text_quality(text))=="data.frame")

})


#' Test for values returned in the dataframe
test_that("Test that output contains double", {

  output <- text_quality(text)

  expect_true(typeof(output$spell_error)=="double")
  expect_true(typeof(output$toxicity)=="double")

})


#' Test for values returned in the dataframe
test_that("Test that output contains non-negative values", {

  output <- text_quality(text)

  expect_true(typeof(output$spell_error)>=0)
  expect_true(typeof(output$toxicity)>=0)

})




#' Test for functionality
test_that("Test that spell error gives expected output", {

  output <- text_quality(text)

  expect_true(output$spell_error==df$spell_error)

})


#' Test for functionality
test_that("Test that toxicity gives expected output", {

  output <- text_quality(text)

  expect_true(output$toxicity==df$toxicity)

})





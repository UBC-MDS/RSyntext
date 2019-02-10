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



# Sample input
text <-  "Today is a sunny day. We should go to a beach on this sunny day"
k=1
n=2

# sample output
df <- data.frame(bigrams=('sunny,day'))



#' Test for output type

test_that("Test that output is of type dataframe", {

  expect_true(class(text_grams(text))=="data.frame")

})

#' Test for values returned in the dataframe
test_that("Test that outputs are of the right type", {

  output <- text_grams(text)


  expect_true(typeof(output$bigrams)=="character")

})


#' Test for length of dataframe matches argument passed
test_that("Test that output matches arguments passed", {

  output <- text_grams(text)

  expect_true(dim(output)[1]==n-1)
})


#' Test for valid input
test_that("Input should be a string", {

  text <- 123

  expect_error(text_grams(text))

})


#' Test for valid input
test_that("Input should be a string", {

  text <- ""

  expect_error(text_grams(text))

})


#' Test for functionality
test_that("Test that functions gives the required output", {

  output <- text_grams(text)

  expect_true(output$bigrams == df$bigrams)
})


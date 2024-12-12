# Check to see that the function handles valid/invalid countries correctly

test_that('valid Countries and invalid countries are processed correctly',{
  expect_error(CountryPopulation("NOAH"))
  expect_error((CountryPopulation("Plant")))
})

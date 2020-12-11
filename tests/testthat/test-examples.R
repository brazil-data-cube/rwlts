context("test_examples")

testthat::test_that("examples file", {
  vcr::use_cassette("examples_file", {

    # skip cran check test
    testthat::skip_on_cran()




  })
})

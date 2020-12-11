context("test_services")

testthat::test_that("services api", {
  vcr::use_cassette("services_api", {

    # skip cran check test
    testthat::skip_on_cran()

    wlts_bdc <- "http://brazildatacube.dpi.inpe.br/dev/wlts/"

    # /list_collections - OK
    testthat::expect_equal(
      object   = class(list_collections(wlts_bdc)),
      expected = "character")

    # /list_collections - Error
    testthat::expect_error(
      object = list_collections(NULL))

    # /list_collections - Error
    testthat::expect_error(
      object = list_collections("."))

  })
})

context("test_services")

testthat::test_that("services api", {
  vcr::use_cassette("services_api", {

    # skip cran check test
    testthat::skip_on_cran()

    wlts_bdc <- "https://brazildatacube.dpi.inpe.br/wlts/"

    #---- list collections test
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

    #---- describe collection test

    # /describe_collection (structure test)
    testthat::expect_equal(
      object   = class(describe_collection(wlts_bdc, "deter_amazonia_legal")),
      expected = "list"
    )

    # /describe_collection (signature test)
    testthat::expect_error(
      object = describe_collection(NULL)
    )

    testthat::expect_error(
      object = describe_collection(wlts_bdc, NULL)
    )

    #---- get trajectory test

    # get trajectory test (simple trajectory request)
    testthat::expect_s3_class(
      object = get_trajectory(
        URL         = wlts_bdc,
        latitude    = -12,
        longitude   = -54,
        start_date  = "2015-01-01",
        end_date    = "2017-01-01",
        collections = "mapbiomas5_amazonia"),
      class = "wlts"
    )

    # get trajectory test (signature test)
    testthat::expect_error(
      object = get_trajectory(
        URL         = NULL,
        latitude    = -12,
        longitude   = -54,
        collections = "mapbiomas5_amazonia")
    )

    # get trajectory test (semantic point request test)
    testthat::expect_error(
      object = get_trajectory(
        URL         = wlts_bdc,
        latitude    = c(-12, NULL),
        longitude   = c(-54, -55),
        collections = "mapbiomas5_amazonia")
    )

    ## latitude test
    testthat::expect_error(
      object = get_trajectory(
        URL         = wlts_bdc,
        latitude    = -95,
        longitude   = -54,
        collections = "mapbiomas5_amazonia")
    )

    ## longitude test
    testthat::expect_error(
      object = get_trajectory(
        URL         = wlts_bdc,
        latitude    = -12,
        longitude   = 185,
        collections = "mapbiomas5_amazonia")
    )

    ## time interval request
    testthat::expect_error(
      object = get_trajectory(
        URL         = wlts_bdc,
        latitude    = -12,
        longitude   = -54,
        start_date  = "2015/01/01",
        collections = "mapbiomas5_amazonia")
    )

    testthat::expect_error(
      object = get_trajectory(
        URL         = wlts_bdc,
        latitude    = -12,
        longitude   = -54,
        end_date    = "2015-01",
        collections = "mapbiomas5_amazonia")
    )

    testthat::expect_error(
      object = get_trajectory(
        URL         = wlts_bdc,
        latitude    = -12,
        longitude   = -54,
        start_date  = "2017-01-01",
        end_date    = "2015-01-01",
        collections = "mapbiomas5_amazonia")
    )
  })
})

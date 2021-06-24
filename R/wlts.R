#' @title List Collections
#'
#' @description Retrieves the list of available data collections.
#'
#' @param URL         a \code{character} URL of the WLTS Service.
#' @param ...         a \code{list} Parameters to httr::GET function
#'
#' @examples
#' \donttest{
#'  wlts_bdc <- "https://brazildatacube.dpi.inpe.br/wlts/"
#'
#'  list_collections(wlts_bdc)
#' }
#'
#' @return a \code{character} vector with the available data collections.
#'
#' @export
list_collections <- function(URL, ...) {

  if (is.null(URL))
    stop("The WLTS URL service must be provided.")

  # is this best way?
  url_obj <- .build_url(URL, path = "/list_collections")

  content <- request(url_obj$url, ...)
  unlist(content, use.names = FALSE)
}

#' @title Describe Collection
#'
#' @description Retrieves the metadata of a given data collection.
#'
#' @param URL           a \code{character} URL of the WLTS Service.
#' @param collection_id a \code{character} with identifier (name) of a
#'  collection.
#' @param ...           a \code{list} Parameters to httr::GET function.
#'
#' @examples
#' \donttest{
#'  wlts_bdc <- "https://brazildatacube.dpi.inpe.br/wlts/"
#'
#'  describe_collection(wlts_bdc, "deter_amazonia_legal")
#' }
#'
#' @return a named \code{list} with the metadata of data collection.
#'
#' @export
describe_collection <- function(URL, collection_id, ...) {

  if (is.null(URL))
    stop("WLTS URL service must be provided.")

  if (is.null(collection_id))
    stop("collection_id must be provided.")

  url_obj <- .build_url(URL, path = "/describe_collection",
                        query = list(collection_id),
                        names_list = "collection_id")

  content <- request(url_obj$url, query = url_obj$query, ...)
  content
}

#' @title Get Trajectory
#'
#' @description Retrieves the land use and cover trajectories from the data
#'  collections given a location in space. The property \code{result} contains
#'  the feature identifier information, class, time, and the collection
#'  associated to the data item.
#'
#' @param URL         a \code{character} URL of the WLTS Service.
#' @param latitude    a \code{numeric} vector corresponding to latitude in
#'  WGS84 coordinate system.
#' @param longitude   a \code{numeric} vector corresponding to longitude in
#'  WGS84 coordinate system.
#' @param collections a \code{character} vector of identifier (name) of
#'  collections delimited by comma.
#' @param start_date  a \code{character} with the start date to be search.
#' @param end_date    a \code{character} with the end date to be search.
#' @param ...         a \code{list} Parameters to httr::GET function.
#' @param query_info  a \code{bolean} flag, if true query information is
#'  returned.
#'
#' @examples
#' \donttest{
#'  wlts_bdc <- "https://brazildatacube.dpi.inpe.br/wlts/"
#'
#'  get_trajectory(wlts_bdc, latitude = c(-12, -11.01), longitude = c(-54, -54),
#'                collections = "mapbiomas5_amazonia")
#'
#'  # date interval
#'  get_trajectory(URL        = wlts_bdc,
#'                latitude    = c(-12, -11),
#'                longitude   = c(-54, -55),
#'                collections = "mapbiomas5_amazonia",
#'                start_date  = "2015-07-01",
#'                end_date    = "2017-07-01")
#' }
#'
#' @return a \code{object} of wlts class with query (if \code{query_info} is
#'  provided) and a tibble with trajectory requested.
#'
#' @export
get_trajectory <- function(URL,
                           latitude,
                           longitude,
                           collections = NULL,
                           start_date  = NULL,
                           end_date    = NULL,
                           ...,
                           query_info = FALSE) {

  if (is.null(URL))
    stop("WLTS URL service must be provided.")

  # check if the latitude and longitude
  .check_location(latitude, longitude)

  if (any(!is.null(start_date) | !is.null(end_date)))
    .check_datetime(start_date, end_date)

  # build final url
  url_obj <- .build_url(URL, path  = "/trajectory",
                        query      = list(start_date, end_date, collections),
                        names_list = c("start_date", "end_date", "collections"))

  # create a list of content
  list_content <- lapply(seq_along(latitude), function(i) {
    url_obj$query[c("latitude", "longitude")] <- c(latitude[i], longitude[i])

    # TODO: adjust parent.frame
    content <- request(url_obj$url, query = url_obj$query, ...)
    content$result <- .build_wlts_tb(content$result, index = i)

    content
  })

  result_query <- NULL
  if (query_info)
    result_query <- sapply(list_content, `[[`, "query", simplify = FALSE)

  wlts_tb <- do.call(rbind, sapply(list_content, `[[`, "result",
                                   simplify = FALSE))

  structure(list(
    query  = result_query,
    result = wlts_tb),
    class  = "wlts")
}

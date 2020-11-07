#' @title ...
#'
#' @param a \code{character} ...
#' @param ... \code{character} ...
#'
#' @return
#'
#' @export
list_collections <- function(URL, ...) {

  if (missing(URL))
    stop("The WLTS URL service must be provided.")

  # is this best way?
  final_url <- .build_url(URL, path = "/list_collections")

  content <- request(final_url, ...)
  unlist(content, use.names = FALSE)
}

#' @title ...
#'
#' @param URL a \code{character} ...
#' @param collection_id a \code{character} ...
#' @param ... a \code{character} ...
#'
#' @return
#'
#' @export
describe_collection <- function(URL, collection_id, ...) {

  if (missing(URL))
    stop("WLTS URL service must be provided.")

  final_url <- .build_url(URL, path = "/describe_collection")
  content <- request(final_url, query = list("collection_id" = collection_id), ...)
  content
}

#' @title ...
#'
#' @param latitude    a \code{numeric} ...
#' @param longitude   a \code{numeric} ...
#' @param collections a \code{character} ...
#' @param ...         a \code{character} ...
#'
#' @return
#'
#' @export
get_trajectory <- function(URL, latitude, longitude, collections = NULL,
                           start_date = NULL, end_date = NULL, ...) {

  if (missing(URL))
    stop("WLTS URL service must be provided.")

  .check_location(latitude, longitude)

  datetime <- list(start_date, end_date)
  if (any(!missing(start_date) & !missing(end_date)))
    datetime <- .parse_datetime(start_date, end_date)

  query <- list(datetime$start_date, datetime$end_date, latitude, longitude, collections)
  names(query) <- c("start_date", "end_date", "latitude", "longitude", "collections")
  query <- .drop_na(query)

  final_url <- .build_url(URL, path  = "/trajectory")
  content <- request(final_url, query = query, ...)

  structure(list(
    query = content$query,
    result = .build_result_tibble(content$result)),
    class = "wlts")
}

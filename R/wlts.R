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
#' @param
#' @param latitude     a \code{numeric} ...
#' @param longitude    a \code{numeric} ...
#' @param collections  a \code{character} ...
#' @param ...          a \code{character} ...
#'
#' @return
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

  if (missing(URL))
    stop("WLTS URL service must be provided.")

  # check if the latitude and longitude
  .check_location(latitude, longitude)

  if (any(!is.null(start_date) | !is.null(end_date)))
    .check_datetime(start_date, end_date)

  # build final url
  url_obj <- .build_url(URL, path  = "/trajectory",
                        query = list(start_date, end_date, collections))

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

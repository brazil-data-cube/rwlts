# http://brazildatacube.dpi.inpe.br/dev/wlts/

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
#' @param collection_id a \code{character} ...
#' @param collection_id a \code{character} ...
#' @param collection_id a \code{character} ...
#'
#' @return
#'
#' @export
describe_collection <- function(URL, ...) {

  if (missing(URL))
    stop("The WLTS URL service must be provided.")

  final_url <- .build_url(URL, path = '/describe_collection', 
                                    query = list("collection_id" = collection_id))

  content <- request(final_url)
  
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

  
  
  .parse_location(latitude, longitude)

  if (all(!missing(start_date) & !missing(end_date)))
    .parser_datetime()

  final_url <- .build_url(URL, path  = "/trajectory", 
                          query = list("latitude"    = latitude,
                                       "longitude"   = longitude,
                                       "collections" = collections,
                                       "start_date"  = start_date,
                                       "end_date"    = end_date))

  content <- request(final_url, ...)
    
  structure(query = content$query, 
            result = .build_tibble(content$result),
            class = "wlts")

  httr::content(response_obj)
}

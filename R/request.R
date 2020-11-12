#' @title Make a HTTP request
#' @name request
#'
#' @description makes an HTTP request along with HTTP query parameters
#' for a web service
#'
#' @param URL \code{character} URL of the WLTS Service
#' @param query \code{list} A named list with HTTP query parameters
#' @param ... \code{character} Parameters to httr::GET function
#'
#' @return
request <- function(URL, ..., query = NULL) {

  tryCatch({
    response_obj <- httr::GET(URL, query = query, ...)
  },
  error = function(e) {
    stop("Error in requisition: ", e)
  })

  httr::content(response_obj)
}


#' @title Create a valid URL
#' @name .build_url
#'
#' @description Checks if the URL has patterns that may cause query problems.
#'
#' @param URL \code{character} URL of the WLTS Service
#' @param path \code{character} ...
#' @param ... \code{character} ...
#'
#' @return
.build_url <- function(URL, path, ...) {
  url <- paste0(URL, path)
  url <- gsub("/$", "", url)
}

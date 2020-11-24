#' @title Make an HTTP request
#'
#' @name request
#'
#' @description makes an HTTP request along with HTTP query parameters
#' for a web service.
#'
#' @param URL \code{character} URL of the WLTS Service.
#' @param ... \code{character} Parameters to httr::GET function.
#' @param query \code{list} A named list with HTTP query parameters.
#'
#' @return a \code{object} response from httr package.
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
#'
#' @name .build_url
#'
#' @description Checks if the URL has patterns that may cause query problems.
#'
#' @param URL        a \code{character} URL of the WLTS Service.
#' @param path       a \code{character} with URL path.
#' @param query      a \code{list} A named list with HTTP query parameters.
#' @param names_list a \code{character} vector with the names of query
#'  attributes.
#'
#' @return a \code{list} with \code{url} and \code{query} attributes.
.build_url <- function(URL, path, query = NULL, names_list = NULL) {
  url <- paste0(URL, path)
  url <- gsub("/$", "", url)

  if (!is.null(query))
    names(query) <- names_list

  return(list(url = url, query = query))
}

#' @title
#'
#' @param a \code{character} ...
#'
#' @return
#'
#'
request <- function(URL, query, ...) {
  
  tryCatch({
    response_obj <- httr::GET(URL, query = query, ...)
  },
  error = function(e) {
    stop("Error in requisition: ", e)
  })

  httr::content(response_obj)
}

#' @title
#'
#' @param
#' @param
#' @param
#'
#'
#' @internal
.build_url <- function(URL, path, query = NULL, ...) {
  url <- paste0(URL, path)
  url <- gsub("/$", "", url)
}

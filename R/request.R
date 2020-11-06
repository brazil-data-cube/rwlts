#' @title
#'
#' @param a \code{character} ...
#'
#' @return
#'
#'
request <- function(URL, ...) {
  
  tryCatch({
    response_obj <- httr::GET(URL, ...)
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
  
  # TODO: implment an URL builder
  return(invisible(URL))
}
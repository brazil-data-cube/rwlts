#' @title
#'
#' @param URL \code{character} ...
#' @param query \code{character} ...
#' @param ... \code{character} ...
#'
#' @return
#'
#'
request <- function(URL, ..., query = NULL) {

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
#' @param URL \code{character} ...
#' @param path \code{character} ...
#' @param query \code{character} ...
#' @param ... \code{character} ...
#'
#'
.build_url <- function(URL, path, query) {
  url <- paste0(URL, path)
  url <- gsub("/$", "", url)

  names(query) <- c("start_date", "end_date", "collections")

  return(list(url = url, query = query))
}

#' @title ...
#'
#' @param a \code{character} ...
#' @param ... \code{character} ...
#'
#' @return
.check_location <- function(latitude, longitude) {

  if (length(latitude) != length(longitude))
    stop(paste("The number of points in latitude and",
               "longitude should be the same length."), call. = FALSE)

  if (any(latitude < -90 |  latitude > 90))
    stop("latitude is out of range (-90, 90)", call. = FALSE)

  if (any(longitude < -180 | longitude > 180))
    stop("longitude is out of range (-180, 180)", call. = FALSE)
}

#' @title ...
#'
#' @param a \code{character} ...
#' @param ... \code{character} ...
#'
.check_datetime <- function(start_date, end_date) {

  pattern_rfc  <- "^\\d{4}-\\d{2}-\\d{2}?"
  check_status <- sapply(c(start_date, end_date), grepl, pattern = pattern_rfc,
                         perl = TRUE)

  if (!all(check_status))
    stop("The dates must be in the format of RFC 3339.")

  if (all(!is.null(start_date) & !is.null(end_date)))
    if (start_date >= end_date)
      stop("The 'start_date' should be less than 'end_date'.")
}


#' @title ...
#'
#' @param elements \code{character} ...
#'
#' @return
.drop_na <- function(elements) {
  idx <- which(sapply(elements, is.null))
  elements[-idx]
}

#' @title ...
#'
#' @param a \code{character} ...
#' @param ... \code{character} ...
#'
#' @return
.check_location <- function(latitude, longitude) {
  if (latitude < -90 ||  latitude > 90)
    stop("latitude is out of range (-90, 90)")

  if (longitude < -180 || longitude > 180)
    stop("longitude is out of range (-180, 180)")
}

#' @title ...
#'
#' @param a \code{character} ...
#' @param ... \code{character} ...
#'
#' @return
.check_datetime <- function(start_date, end_date)
{
  pattern_rfc  <- "^\\d{4}-\\d{2}-\\d{2}?"
  check_status <- sapply(c(start_date, end_date), grepl, pattern = pattern_rfc, perl = TRUE)

  if (!all(check_status))
    stop("The dates must be in the format of RFC 3339")
}

#' @title ...
#'
#' @param a \code{character} ...
#' @param a \code{character} ...
#' @param ... \code{character} ...
#'
#' @return
.parse_datetime <- function(start_date, end_date) {
  if (all(!is.null(start_date) & !is.null(end_date)))
    if (start_date >= end_date)
      stop("The 'start_date' should be less than 'end_date'.")

  .check_datetime(start_date, end_date)
}

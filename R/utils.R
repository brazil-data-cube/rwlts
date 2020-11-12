#' @title Validates the location of geographic coordinates
#' @name .check_location
#'
#' @description Checks if the values defined for the location are valid
#' geographical coordinates and are within the range of values
#'
#' @param longitude \code{numeric} Longitude in WGS84 coordinate system.
#' @param latitude  \code{numeric} Latitude in WGS84 coordinate system.
.check_location <- function(latitude, longitude) {

  if (length(latitude) != length(longitude))
    stop(paste("The number of points in latitude and",
               "longitude should be the same length."), call. = FALSE)

  if (any(latitude < -90 |  latitude > 90))
    stop("latitude is out of range (-90, 90)", call. = FALSE)

  if (any(longitude < -180 | longitude > 180))
    stop("longitude is out of range (-180, 180)", call. = FALSE)
}

#' @title Validates the dates
#' @name .check_datetime
#'
#' @description Checks if the dates are in RFC 3339 format
#'
#' @param start_date \code{character} Start date in RFC 3339 format
#' @param end_date   \code{character} End date in RFC 3339 format
.check_datetime <- function(start_date, end_date) {

  pattern_rfc  <- "^\\d{4}-\\d{2}-\\d{2}?"
  check_status <- sapply(c(start_date, end_date), grepl, pattern = pattern_rfc,
                         perl = TRUE)

  if (!all(check_status))
    stop("The dates must be in the format of RFC 3339.")

#' @title Validates the dates relationship
#' @name .parse_datetime
#'
#' @description Checks if the dates are in RFC 3339 format and if they are in a
#' valid start and end date relationship
#'
#' @param start_date \code{character} Start date in RFC 3339 format
#' @param end_date   \code{character} End date in RFC 3339 format
.parse_datetime <- function(start_date, end_date) {
  if (all(!is.null(start_date) & !is.null(end_date)))
    if (start_date >= end_date)
      stop("The 'start_date' should be less than 'end_date'.")
}

#' @title Validates the dates relationship
#' @name .drop_na
#'
#' @description Check if they are in a valid start and end date relationship
#'
#' @param elements \code{character} A vector of character elements
#'
#' @return a filtered \code{list}.
.drop_na <- function(elements) {
  elements[-which(sapply(elements, is.null))]
}

#' @title ...
#'
#' @param a \code{character} ...
#'
#' @return
#'
#' @export
list_collections <- function(..., base_url = "http://brazildatacube.dpi.inpe.br/dev/wlts/") {

  if (!missing(base_url))
    stop(!is.character(base_url))

  url <- paste0(base_url, "/list_collections")

  tryCatch({
    response_obj <- httr::GET(url, ...)
  },
  error = function(e) {
    stop("Error in requisition: ", e)
  })

  httr::content(response_obj)
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
get_trajectory <- function(latitude, longitude, collections, ...,
                           base_url = "http://brazildatacube.dpi.inpe.br/dev/wlts") {

  # TODO: check parameters

  if (latitude < -90 ||  latitude > 90)
    stop("latitude is out of range (-90,90)")

  if (longitude < -180 || longitude > 180)
    stop("longitude is out of range (-180,180)")


  tryCatch({
    response_obj <-  httr::GET(base_url,
                               path = '/dev/wlts/trajectory',
                               query = list("latitude"    = latitude,
                                            "longitude"   = longitude,
                                            "collections" = collections))
  },
  error = function(e) {
    stop("Error in requisition: ", e)
  })

  content_req <- httr::content(response_obj)

  content_req

  #
  # return(
  #   data.frame(
  #     httr::content(
  #       httr::GET(base_url, path = '/dev/wlts/trajectory',
  #                 query = list('latitude' = latitude, 'longitude' = longitude, 'collections'=collections))
  #     )$result
  #   )
  # )

}

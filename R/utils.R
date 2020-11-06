.check_location <- function(latitude, longitude) {
  if (latitude < -90 ||  latitude > 90)
    stop("latitude is out of range (-90, 90)")

  if (longitude < -180 || longitude > 180)
    stop("longitude is out of range (-180, 180)")

}
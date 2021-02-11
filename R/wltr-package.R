#' @title wltr
#' @description An R client to the web land trajectory service (WLTS)
#'
#' @section WLTS API:
#'
#' Implements an R interface to a web land trajectory service (WLTS)
#' that offers a land trajectory time series of remote sensing samples API.
#'
#' The WLTS API has three commands:
#' \itemize{
#'    \item `list_collections`: lists all available collections on WLTS Service
#'    \item `trajectory`: Returns the Land Use and Land Cover for a spatio-temporal location
#'    \item `describe_collection`: retrieves the metadata of a collection
#' }
#'
#' @docType package
#' @name wlts-package
#' @aliases wlts
"_PACKAGE"
NULL

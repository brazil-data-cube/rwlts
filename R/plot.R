#' @title Plots for rwlts package
#'
#' @name plot.wlts
#'
#' @description A set of visualization methods for trajectories extracted in
#'  rwlts package.
#'
#' @param x    a \code{tibble} object from class \code{wlts}.
#' @param type a \code{character} with the type of plot.
#'  Nowadays, only the "alluvial" plot is supported. By default is "alluvial".
#' @param ...         additional functions
#'
#' @examples
#' \dontrun{
#'  wlts_bdc <- "https://brazildatacube.dpi.inpe.br/wlts/"
#'
#'  wlts_tibble <- get_trajectory(
#'                      URL        = wlts_bdc,
#'                      latitude    = c(-12, -11),
#'                      longitude   = c(-54, -55),
#'                      collections = "mapbiomas_amazonia-v5",
#'                      start_date  = "2015-07-01",
#'                      end_date    = "2017-07-01",
#'                      config = httr::add_headers("x-api-key" = "BDC-KEY"))
#'
#'  plot(wlts_tibble)
#' }
#'
#' @return a \code{gg} object from ggplot2 package.
#'
#' @export
plot.wlts <- function(x, ..., type = "alluvial") {

  if (is.null(x$result))
    stop(paste("The result provided is empty, please check your query."),
         .call = FALSE)

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop(paste("ggplot2 required for this function to work.",
               "Please install it."), call. = FALSE)
  }

  # dispatch for S3 methods
  class(x) <- c(type, class(x))
  plot(x, ...)
}

#' @rdname plot.wlts
#' @param show_count  a \code{logical} parameter, if true, is added
#' the number of points on each bar. The default value is FALSE.
#' @export
plot.alluvial <- function(x, ..., show_count = FALSE) {

  if (!requireNamespace("ggalluvial", quietly = TRUE)) {
    stop(paste("ggalluvial required for this function to work.",
               "Please install it."), call. = FALSE)
  }

  traj_data_sankey <- x$result %>%
    dplyr::mutate(date = as.factor(as.numeric(date)),
                  class = as.factor(class)) %>%
    dplyr::arrange(date) %>%
    dplyr::group_by(class, date) %>%
    dplyr::mutate(n_points = dplyr::n()) %>%
    dplyr::ungroup()

  g <- ggplot2::ggplot(traj_data_sankey,
                       ggplot2::aes_string(x = "date",
                                           stratum = "class",
                                           alluvium = "point_id",
                                           fill = "class",
                                           label = "class")) +
    ggalluvial::geom_flow(stat = "alluvium",
                          lode.guidance = "frontback",
                          curve_type = "xspline") +
    ggalluvial::geom_stratum() +
    ggplot2::scale_y_continuous(expand = c(0, 0)) +
    ggplot2::theme(legend.position = "bottom")

  if (show_count)
    g <- g + ggplot2::geom_text(stat = "stratum",
                                ggplot2::aes_string(label = "n_points"))

  if (length(unique(x$result$collection)) > 1)
    g <- g + ggplot2::facet_wrap(~ traj_data_sankey$collection)

  return(g)
}

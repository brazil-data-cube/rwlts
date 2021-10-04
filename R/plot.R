#' @title Sankey Plot
#'
#' @name plot.wlts
#'
#' @description Visualization method based on the sankey graph. In which the
#' changes between each class are presented on the time axis.
#'
#' @param wtls_tibble           a \code{tibble} object from class \code{wlts}.
#' @param show_count_transition a \code{logical} parameter, if true, is added
#' the number of points on each bar. The default value is FALSE.
#'
#' @examples
#' \donttest{
#'  wlts_bdc <- "https://brazildatacube.dpi.inpe.br/wlts/"
#'
#'  wlts_tibble <- get_trajectory(
#'                      URL        = wlts_bdc,
#'                      latitude    = c(-12, -11),
#'                      longitude   = c(-54, -55),
#'                      collections = "mapbiomas5_amazonia",
#'                      start_date  = "2015-07-01",
#'                      end_date    = "2017-07-01",
#'                      config = httr::add_headers("x-api-key" = "BDC-KEY"))
#'
#'
#'  plot(wlts_tibble)
#' }
#'
#' @return a \code{gg} object from ggplot2 package.
#'
#' @export
plot.wlts <- function(wtls_tibble, type, ...) {

  if (is.null(wtls_tibble$result))
    stop(paste("The result provided is empty, please check your query."),
         .call = FALSE)

  new_plot(wtls_tibble, type, ...)
}

new_plot <- function(wlts_tibble, type, ...) {

  UseMethod("new_plot", type)
}

new_plot.alluvial <- function(wtls_tibble, type, ...,
                                show_count_transition = FALSE) {

  traj_data_sankey <- wtls_tibble$result %>%
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

  if (show_count_transition)
    g <- g + ggplot2::geom_text(stat = "stratum",
                                ggplot2::aes_string(label = "n_points"))

  if (length(unique(wtls_tibble$result$collection)) > 1)
    g <- g + ggplot2::facet_wrap(~ traj_data_sankey$collection)

  return(g)
}


new_plot.default <- function(wtls_tibble, type, ...) {
  stop("error")
}

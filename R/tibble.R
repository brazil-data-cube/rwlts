#' @title ...
#'
#' @param a \code{character} ...
#'
#' @return
#'
#'
.build_result_tibble <- function(result) {
  do.call(rbind, sapply(result$trajectory, tibble::as_tibble, simplify = FALSE))
}

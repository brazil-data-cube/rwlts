#' @title ...
#'
#' @param a \code{character} ...
#'
#' @return
#'
#'
.build_result_tibble <- function(result) {
  result_tibble <- do.call(rbind, sapply(result$trajectory, tibble::as_tibble, simplify = FALSE))
}

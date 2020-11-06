# resultado da requisição -> {
# query: collection, start_date, end_date, latitude, longitude
# result: {'trajectory': [{class: 'Floresta', 'collection': terraclass, date: 2004}]}
# }


.build_result_tibble <- function(result) {
  do.call(rbind, sapply(result$trajectory, tibble::as_tibble, simplify = FALSE))
}


#' Retention
#' @description Retention
#' @param x input connect log data frame
#' @param all if FALSE, first date retention
#' @export
#' @examples
#' set.seed(1004)
#' library(lubridate)
#' connect_log <- tibble(
#'   id = c(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 5, 5),
#'   login_date = sample(seq(ymd_h(2018010100), ymd_h(2018010323), by = "hour"), 20)
#' ) %>%
#'   arrange(id, login_date) # must be - first col : index, second col : date
#'
#' retention(connect_log, by = "days")
#' retention(connect_log, by = "days", percent_scale = F)

retention <- function(x, by = c("days", "weeks", "months"), all = TRUE, percent_scale = TRUE){
  res <- list()
  x <- x %>%
    dplyr::rename(id = 1, date = 2)

  x <- switch(by,
    "days"   = dplyr::mutate(x, date = floor_date(date, "day")),
    "weeks"  = dplyr::mutate(x, date = floor_date(date, "week")),
    "months" = dplyr::mutate(x, date = floor_date(date, "month"))
  ) %>%
    dplyr::distinct()

  if(all){
    res$count <- x %>%
      dplyr::left_join(x, by = "id") %>%
      dplyr::rename(first_date = date.x, login_date = date.y) %>%
      dplyr::mutate(datediff = difftime(login_date, first_date, units = by)) %>%
      dplyr::filter(datediff >= 0) %>%
      dplyr::count(first_date, datediff) %>%
      tidyr::spread(datediff, n)
  } else {
    res$count <- x %>%
      dplyr::left_join(x, by = "id") %>%
      dplyr::filter(date.x == min(date.x)) %>%
      dplyr::rename(first_date = date.x, login_date = date.y) %>%
      dplyr::mutate(datediff = difftime(login_date, first_date, units = by)) %>%
      dplyr::filter(datediff >= 0) %>%
      dplyr::count(first_date, datediff) %>%
      tidyr::spread(datediff, n)
  }

  if(percent_scale){
    res$percent <- x %>%
      dplyr::left_join(x, by = "id") %>%
      dplyr::rename(first_date = date.x, login_date = date.y) %>%
      dplyr::mutate(datediff = difftime(login_date, first_date, units = by)) %>%
      dplyr::filter(datediff >= 0) %>%
      dplyr::count(first_date, datediff) %>%
      dplyr::group_by(first_date) %>%
      dplyr::mutate(percent = n / max(n)) %>% ungroup %>%
      dplyr::select(-n) %>%
      tidyr::spread(datediff, percent)
  }

  return(res)
}

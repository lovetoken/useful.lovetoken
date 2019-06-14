#' Retention
#' @description Retention
#' @param x input data frame. Must be input first column an ID value and the second column a datetype value.
#' @param by Set the interval.
#' @param plot Turn on plot option about retention. Default is TRUE
#' @export
#' @examples
#' set.seed(1004)
#' library(lubridate)
#' connect_log <- data.frame(
#'   id = c(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 5, 5),
#'   login_date = sample(seq(ymd_h(2018010100), ymd_h(2018010323), by = "hour"), 20)
#' ) %>%
#'   arrange(id, login_date)
#'
#' retention(connect_log, by = "days")

retention <- function(x, by = c("days", "weeks", "months"), plot = T){
  res <- list()
  x <- x %>%
    dplyr::rename(id = 1, date = 2)

  x <- switch(by,
              "days"   = dplyr::mutate(x, date = lubridate::floor_date(date, "day")),
              "weeks"  = dplyr::mutate(x, date = lubridate::floor_date(date, "week")),
              "months" = dplyr::mutate(x, date = lubridate::floor_date(date, "month"))
  ) %>%
    dplyr::distinct()

  res$count <- x %>%
    dplyr::left_join(x, by = "id") %>%
    dplyr::rename(first_date = date.x, login_date = date.y) %>%
    dplyr::mutate(datediff = difftime(login_date, first_date, units = by)) %>%
    dplyr::filter(datediff >= 0) %>%
    dplyr::count(first_date, datediff) %>%
    tidyr::spread(datediff, n) %>%
    tidyimpute::impute(0)

  res$percent <- x %>%
    dplyr::left_join(x, by = "id") %>%
    dplyr::rename(first_date = date.x, login_date = date.y) %>%
    dplyr::mutate(datediff = difftime(login_date, first_date, units = by)) %>%
    dplyr::filter(datediff >= 0) %>%
    dplyr::count(first_date, datediff) %>%
    dplyr::group_by(first_date) %>%
    dplyr::mutate(percent = n / max(n)) %>% ungroup %>%
    dplyr::select(-n) %>%
    tidyr::spread(datediff, percent) %>%
    tidyimpute::impute(0)

  if(plot){
    pd <- res$percent %>%
      dplyr::filter(first_date == min(first_date)) %>%
      tidyr::gather(first_date, retention_prop)

    gt <- res$percent %>%
      dplyr::filter(first_date == min(first_date)) %>%
      pull(first_date)

    p <- pd %>%
      ggplot2::ggplot(aes(x = as.integer(first_date), y = retention_prop, label = scales::percent(retention_prop))) +
      ggplot2::geom_text(alpha = .5, vjust = -.5, size = 3) +
      ggplot2::geom_line(stat = "identity") +
      ggplot2::lims(y = c(0, 1)) +
      ggplot2::labs(x = switch(by, "days" = "D+x", "weeks" = "W+x", "months" = "M+x")) +
      ggplot2::ggtitle(paste0("D+0 : ", gt))

    print(p)
  }

  return(res)
}

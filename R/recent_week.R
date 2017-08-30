#' Sequence Date Generation (only Weekend) from recent day
#' @description Sequence Date Generation (only Weekend) from recent day
#' @param to recent day. default is \code{Sys.Date()}
#' @param recent_day input integer value
#' @return "\%Y-\%m-\%d" Date class
#' @seealso \link{is.weekend}
#' @export
#' @examples
#' recent_weekend(8)
#' recent_weekend(8, as.Date("2000-08-20"))

recent_weekend <- function(recent_day, to = Sys.Date()){

  ## Pre
  stopifnot(require(chron)); stopifnot(require(tidyverse))

  ## Content
  vec <- to %>% seq(., .-recent_day*7, by = -1)
  logical <- cumsum(vec %>% is.weekend) == recent_day
  index <- logical %>% which %>% min
  resday <- vec[index]

  ## Res
  vec <- seq(resday, to, by = 1)
  vec[vec %>% is.weekend]

}

#' Sequence Date Generation (only Weekday) from recent day
#' @description Sequence Date Generation (only Weekday) from recent day
#' @param to recent day. default is \code{Sys.Date()}
#' @param recent_day input integer value
#' @return "\%Y-\%m-\%d" Date class
#' @seealso \link{is.weekend}
#' @export
#' @examples
#' recent_weekday(20)
#' recent_weekday(20, as.Date("2000-08-20"))

recent_weekday <- function(recent_day, to = Sys.Date()){

  ## Pre
  stopifnot(require(chron)); stopifnot(require(tidyverse))

  ## Content
  vec <- to %>% seq(., .-recent_day*2, by = -1)
  logical <- cumsum(!vec %>% is.weekend) == recent_day
  index <- logical %>% which %>% min
  resday <- vec[index]

  ## Res
  vec <- seq(resday, to, by = 1)
  vec[!vec %>% is.weekend]

}

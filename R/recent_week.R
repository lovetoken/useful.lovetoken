#' Sequence Date Generation (only Weekend) from recent day
#'
#' 오늘일자를 기준으로 최근일자를 주말만을 뽑아 열거합니다.
#' @param to 오늘일자기준을 정합니다. 데이터 형식은 Date 이어야 합니다.
#' @param recent_day 몇일차를 열거할 것인지 정합니다. 데이터 형식은 정수이어야 합니다.
#' @return "\%Y-\%m-\%d" 형식인 Date 형식 벡터가 반환됩니다.
#' @seealso \link{is.weekend}
#' @export
#' @examples
#' recent_weekend(8)
#' recent_weekend(8, as.Date("2000-08-20"))

recent_weekend <- function(recent_day, to = Sys.Date()){

  ## pre
  stopifnot(require(chron)); stopifnot(require(dplyr))

  ## content
  vec <- to %>% seq(., .-recent_day*7, by = -1)
  logical <- cumsum(vec %>% is.weekend) == recent_day
  index <- logical %>% which %>% min
  resday <- vec[index]

  ## res
  vec <- seq(resday, to, by = 1)
  vec[vec %>% is.weekend]

}

#' Sequence Date Generation (only Weekday) from recent day
#'
#' 오늘일자를 기준으로 최근일자를 평일만을 뽑아 열거합니다.
#' @param to 오늘일자기준을 정합니다. 데이터 형식은 Date 이어야 합니다.
#' @param recent_day 몇일차를 열거할 것인지 정합니다. 데이터 형식은 정수이어야 합니다.
#' @return "\%Y-\%m-\%d" 형식인 Date 형식 벡터가 반환됩니다.
#' @seealso \link{is.weekend}
#' @export
#' @examples
#' recent_weekday(20)
#' recent_weekday(20, as.Date("2000-08-20"))

recent_weekday <- function(recent_day, to = Sys.Date()){

  ## pre
  stopifnot(require(chron)); stopifnot(require(dplyr))

  ## content
  vec <- to %>% seq(., .-recent_day*2, by = -1)
  logical <- cumsum(!vec %>% is.weekend) == recent_day
  index <- logical %>% which %>% min
  resday <- vec[index]

  ## res
  vec <- seq(resday, to, by = 1)
  vec[!vec %>% is.weekend]

}

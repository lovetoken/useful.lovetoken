#' Accounting k diff returns
#'
#' Accounting k diff rate of returns
#' @param xts time series dataset produced by \code{xts}.
#' @param k an integer vector.
#' @param log.returns logical asking whether to calculate log returns. Default is \code{FALSE}.
#' @return \code{xts} about returns dataset.
#' @export
#' @examples
#' ror_diff(sample_index, 1)
#' ror_diff(sample_index, 1, log.returns = T)
#'
#' ror_diff(sample_index, 0:19)
#' ror_diff(sample_index, 0:19, log.returns = T)

ror_diff <- function(xts, x, log.returns = F, start.omit = T, ...){
  ## pre
  stopifnot(require(dplyr)); stopifnot(require(xts))

  nr <- dim(xts)[1]
  nc <- dim(xts)[2]
  k <- rep(k, length = nr) # recycle rule

  cd <- coredata(xts); cd[] <- NA
  returns <- xts(cd, index(xts))

  if(log.returns) {

    for(i in xts %>% nrow %>% seq){
      tryCatch(expr = {
        returns[i, ] <- log(as.vector(xts[i, ]) / as.vector(xts[i - k[i], ]))
      },
      error = function(e){})
    }

  } else {

    for(i in xts %>% nrow %>% seq){
      tryCatch(expr = {
        returns[i, ] <- as.vector(xts[i, ]) / as.vector(xts[i - k[i], ]) - 1
      },
      error = function(e){})
    }

  }

  if(start.omit) {

    returns <- returns[!is.na(k), ]

  }

  attr(returns, "k") <- k

  ## return
  returns
}

#' Accounting rolling returns
#'
#' Accounting rolling rate of returns (years, months, days)
#' @param xts time series dataset produced by \code{xts}. Should be satisfied "ymd" term of \code{index(xts)}.
#' @param k an integer vector.
#' @return \code{xts} about returns dataset.
#' @export
#' @rdname ror
#' @examples
#' ror_y(sample_index2, 1)
#' ror_m(sample_index2, 1)
#' ror_d(sample_index2, 1)
#'
#' ror_y(sample_index2, 2)
#' ror_m(sample_index2, 15)
#' ror_d(sample_index2, 50)

ror_y <- function(xts, k){
  ## pre
  stopifnot(require(dplyr)); stopifnot(require(xts)); stopifnot(require(lubridate))

  ## content
  xts <- na.omit(xts)
  cd <- coredata(xts); cd[] <- NA
  resEmptySpace <- xts(cd, index(xts))
  rangeForPool <- range(index(xts))
  poolxts <- xts(, seq(rangeForPool[1], rangeForPool[2], 1)) %>%
    merge(xts, join = "left") %>% na.locf

  for(i in 1:nrow(resEmptySpace)){
    tryCatch(expr = {
      resEmptySpace[i, ] <- as.vector(poolxts[index(resEmptySpace[i, ])]) / as.vector(poolxts[index(resEmptySpace[i, ]) %m-% years(k)]) - 1
    }, error = function(e){})
  }

  attr(resEmptySpace, "k_years") <- k
  returns <- resEmptySpace

  ## return
  returns
}

#' @export
#' @rdname ror

ror_m <- function(xts, k){
  ## pre
  stopifnot(require(dplyr)); stopifnot(require(xts)); stopifnot(require(lubridate))

  ## content
  xts <- na.omit(xts)
  cd <- coredata(xts); cd[] <- NA
  resEmptySpace <- xts(cd, index(xts))
  rangeForPool <- range(index(xts))
  poolxts <- xts(, seq(rangeForPool[1], rangeForPool[2], 1)) %>%
    merge(xts, join = "left") %>% na.locf

  for(i in 1:nrow(resEmptySpace)){
    tryCatch(expr = {
      resEmptySpace[i, ] <- as.vector(poolxts[index(resEmptySpace[i, ])]) / as.vector(poolxts[index(resEmptySpace[i, ]) %m-% months(k)]) - 1
    }, error = function(e){})
  }

  attr(resEmptySpace, "k_months") <- k
  returns <- resEmptySpace

  ## return
  returns
}

#' @export
#' @rdname ror

ror_d <- function(xts, k){
  ## pre
  stopifnot(require(dplyr)); stopifnot(require(xts)); stopifnot(require(lubridate))

  ## content
  xts <- na.omit(xts)
  cd <- coredata(xts); cd[] <- NA
  resEmptySpace <- xts(cd, index(xts))
  rangeForPool <- range(index(xts))
  poolxts <- xts(, seq(rangeForPool[1], rangeForPool[2], 1)) %>%
    merge(xts, join = "left") %>% na.locf

  for(i in 1:nrow(resEmptySpace)){
    tryCatch(expr = {
      resEmptySpace[i, ] <- as.vector(poolxts[index(resEmptySpace[i, ])]) / as.vector(poolxts[index(resEmptySpace[i, ]) %m-% days(k)]) - 1
    }, error = function(e){})
  }

  attr(resEmptySpace, "k_days") <- k
  returns <- resEmptySpace

  ## return
  returns
}

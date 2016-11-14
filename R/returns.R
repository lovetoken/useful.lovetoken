#' Accounting x diff returns
#'
#' 일괄적으로 모든 x 시차 값을 기준으로 수익률을 계산합니다.
#' @param xts an \code{xts} object
#' @param x an integer value
#' @param log.returns logical asking whether to calculate log returns
#' @return xts type about returns dataset
#' @export
#' @examples
#' xdiff_returns(sample_index, 1)
#' xdiff_returns(sample_index, 1, log.returns = T)

xdiff_returns <- function(xts, x = 1, log.returns = F, start.omit = T){

  ## pre
  stopifnot(require(dplyr)); stopifnot(require(xts))
  x <- as.integer(x)

  nr <- dim(xts)[1]
  nc <- dim(xts)[2]

  if(log.returns) {

    returns <- diff(log(xts), lag = x)

  } else {

    returns <- diff(xts, x) / apply(xts, 2, function(a) lag(a, x))

  }

  if(start.omit) {

    returns <- returns[-seq(x), ]

  }

  attr(returns, "x") <- x

  ## return
  returns

}

#' Accounting x diff returns
#'
#' 각기 다른 x 시차 값을 기준으로 수익률을 계산합니다. 따라서 \code{x}는 \code{n = nrow(xts)} 만큼의 벡터타입값을 받아야 합니다.
#' @param xts an \code{xts} object
#' @param x an integer vector
#' @param log.returns logical asking whether to calculate log returns
#' @return xts type about returns dataset
#' @export
#' @examples
#' xdiffs_returns(sample_index, x = 0:19)
#' xdiffs_returns(sample_index, x = 0:19, log.returns = T)

xdiffs_returns <- function(xts, x, log.returns = F, start.omit = T){

  ## pre
  stopifnot(require(dplyr)); stopifnot(require(xts))
  stopifnot(nrow(xts) == length(x))

  nr <- dim(xts)[1]
  nc <- dim(xts)[2]

  cd <- coredata(xts); cd[] <- NA

  returns <- xts(cd, index(xts))

  if(log.returns) {

    for(i in xts %>% nrow %>% seq){
      tryCatch(expr = {
        returns[i, ] <- log(as.vector(xts[i, ]) / as.vector(xts[i - x[i], ]))
      },
      error = function(e){})
    }

  } else {

    for(i in xts %>% nrow %>% seq){
      tryCatch(expr = {
        returns[i, ] <- as.vector(xts[i, ]) / as.vector(xts[i - x[i], ]) - 1
      },
      error = function(e){})
    }

  }

  if(start.omit) {

    returns <- returns[!is.na(x), ]

  }

  attr(returns, "x") <- x

  ## return
  returns

}

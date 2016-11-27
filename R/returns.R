#' Accounting x diff returns
#'
#' Accounting x diff returns
#' @param xts an \code{xts} object
#' @param x an integer vector
#' @param log.returns logical asking whether to calculate log returns
#' @return xts type about returns dataset
#' @export
#' @examples
#' # rolling returns
#' diff_returns(sample_index, x = 1)
#' diff_returns(sample_index, x = 1, log.returns = T)
#'
#' # changed rolling returns
#' diff_returns(sample_index, x = 0:19)
#' diff_returns(sample_index, x = 0:19, log.returns = T)

diff_returns <- function(xts, x, log.returns = F, start.omit = T, ...){

  ## pre
  stopifnot(require(dplyr)); stopifnot(require(xts))

  nr <- dim(xts)[1]
  nc <- dim(xts)[2]
  x <- rep(x, length = nr) # recycle rule

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

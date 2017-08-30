#' Adjust min & max
#' @description Adjust min & max about numeric vector
#' @param x numeric vector
#' @param min
#' @param max
#' @export
#' @examples
#' x <- c(NA, 1:100*.01, NA)
#' mmadjust(x, .2, .8)
#' mmadjust(x, .2)
#' mmadjust(x, , .8)

mmadjust <- function(x, min = NA, max = NA){

  ## Pre
  stopifnot(is.numeric(x))

  ## Content
  x[x < min] <- min
  x[x > max] <- max

  ## Return
  return(x)

}

#' Range scaling 0 to 1
#' @description Range scaling 0 to 1
#' @param x numeric vector
#' @export
#' @examples
#' x <- c(0, 4, 7, 9, 10)
#' range01(x)
#' range01(x) * 100 # Standardization 0 to 100

range01 <- function(x, ...){(x - min(x, ...)) / (max(x, ...) - min(x, ...))}

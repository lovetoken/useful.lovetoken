#' Adjust min & max
#'
#' Adjust min & max about numeric vector
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

  ## pre
  stopifnot(is.numeric(x))

  ## content
  x[x < min] <- min
  x[x > max] <- max

  ## return
  return(x)

}

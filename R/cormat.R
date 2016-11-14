#' Visualization of correlation plot using psych::pairs.panels() function
#'
#' This function is alias \code{psych::pairs.panels()}. It can visualize for standardization.
#' @export
#' @examples
#' cormat(cars)

cormat <- function(dat, pch = '.', ...){

  ## pre
  stopifnot(require(psych))

  ## content
  pairs.panels(dat, gap = 0, ellipses = F, pch = pch, hist.col = "lavender", col = "dodgerblue", lwd = 2, ...)
}

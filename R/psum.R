#' Returns the parallel sum of the input values.
#'
#' Returns the parallel sum of the input values.
#' @param ... input values
#' @param na.rm a logical indicating whether missing values should be removed.
#' @export
#' @examples
#' psum(1:5, c(1, 2, 3, 4, NA), c(1, NA, 3, 4, 5))
#' psum(1:5, c(1, 2, 3, 4, NA), c(1, NA, 3, 4, 5), na.rm=T)

psum <- function(..., na.rm = F){

  # content
  dat <- do.call(cbind, list(...))
  res <- rowSums(dat, na.rm = na.rm)
  idx_na <- !rowSums(!is.na(dat))
  res[idx_na] <- NA

  # return
  return(res)
}

#' Bound trim the sequence vector
#' @description Bound trim the sequence vector
#' @param vector input sequence. e.g \code{1:100}
#' @export
#' @examples
#' bound_trim(1:100, 5, 95)
#' bound_trim(c(1, 5, 9, 10), 0, 9)
#' bound_trim(rnorm(100), -1.96, 1.96)

bound_trim <- function(vector, min, max){
  index <- vector >= min&vector <= max
  res <- vector[index]
  return(res)
}

#' Bandwidth indexing with Bound trim
#' @description Bandwidth indexing with Bound trim
#' @param W0 Bandwidth size
#' @param c Bandwidth center point
#' @export
#' @examples
#' window(10, 0, -20, 20)
#' window(10, 0, -5, 20)

window <- function(W0, c, min, max){
  res <- bound_trim((c - W0):(c + W0), min, max)
  return(res)
}

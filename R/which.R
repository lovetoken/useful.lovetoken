#' which matrix
#'
#' which matrix index
#' @param logical.matrix logical 값이 담긴 matrix type 을 입력 받습니다.
#' @export
#' @examples
#' m <- matrix(sample(c(T,F), 30, T), 5, 6)
#' which(m)
#' which_matrix(m)

which_matrix <- function(logical.matrix){

  # pre
  stopifnot(require(plyr))
  stopifnot(is.matrix(logical.matrix))

  # content
  index <- which(logical.matrix)
  nr <- nrow(logical.matrix)
  qu <- index %/% nr
  re <- index %% nr

  res <- data.frame(row = mapvalues(re, 0, 5), col = (qu+1)-(re == 0))

  # return
  res

}

#' which approach
#'
#' which approach index
#' @param x 찾을 대상이 되는 벡터타입을 입력합니다.
#' @param k 찾아야 할 최근접점에 대한 numeric 정보를 입력합니다.
#' @export
#' @examples
#' x <- runif(100)
#' k <- .5
#' which_approach(x, k)

which_approach <- function(x, k){

  # pre
  stopifnot(require(dplyr))
  stopifnot(is.vector(x)); stopifnot(is.numeric(k))

  # content
  res <- abs(x - k) %>% which.min

  # return
  res

}

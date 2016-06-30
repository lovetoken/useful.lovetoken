#' which matrix
#'
#' which matrix index
#' @param logical.matrix logical 값이 담긴 matrix type 을 입력 받습니다.
#' @export
#' @examples
#' m <- matrix(sample(c(T,F), 30, T), 5, 6)
#' which(m)
#' which.matrix(m)

which.matrix <- function(logical.matrix){

  # pre
  stopifnot(is.matrix(logical.matrix))
  stopifnot(require(plyr))

  # content
  index <- which(logical.matrix)
  nr <- nrow(logical.matrix)
  qu <- index %/% nr
  re <- index %% nr

  res <- data.frame(row = mapvalues(re, 0, 5), col = (qu+1)-(re==0))

  # return
  res

}

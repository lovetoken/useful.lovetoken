#' which matrix
#' @description which matrix index
#' @export
#' @examples
#' m <- matrix(sample(c(T,F), 30, T), 5, 6)
#' which(m)
#' which_matrix(m)

which_matrix <- function(logical.matrix){

  ## Pre
  stopifnot(require(tidyverse))
  stopifnot(is.matrix(logical.matrix))

  ## Content
  index <- which(logical.matrix)
  nr <- nrow(logical.matrix)
  qu <- index %/% nr
  re <- index %% nr

  res <- data.frame(row = mapvalues(re, 0, 5), col = (qu+1)-(re == 0))

  ## Return
  return(res)

}

#' which approach
#' @description which approach index
#' @export
#' @examples
#' x <- runif(100)
#' k <- .5
#' which_approach(x, k)

which_approach <- function(x, k){

  ## Pre
  stopifnot(require(tidyverse))
  stopifnot(is.vector(x)); stopifnot(is.numeric(k))

  ## Content
  res <- abs(x - k) %>% which.min

  ## Return
  return(res)

}

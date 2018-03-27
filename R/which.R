#' which matrix
#' @description which matrix index
#' @export
#' @examples
#' m <- matrix(sample(c(T,F), 30, T), 5, 6)
#' which(m)
#' which_matrix(m)

which_matrix <- function(logical.matrix){

  stopifnot(is.matrix(logical.matrix))

  index <- which(logical.matrix)
  nr <- nrow(logical.matrix)
  qu <- index %/% nr
  re <- index %% nr

  res <- data.frame(row = plyr::mapvalues(re, 0, 5), col = (qu + 1) - (re == 0))

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

  stopifnot(is.vector(x), is.numeric(k), require(dplyr))

  res <- abs(x - k) %>% which.min
  return(res)

}

#' which duplicated all on data.frame
#' @description which all duplicated index on data.frame
#' @export
#' @examples
#' duplicated_all(iris)

duplicated_all <- function(x) x[duplicated(x) | duplicated(x, fromLast = T), ]

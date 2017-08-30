#' Midpoint values
#' @description returns midpoint values
#' @param x input numeric type vector
#' @export
#' @examples
#' midpoint(1:10)

midpoint <- function(x, ...){

  ## Pre
  stopifnot(is.vector(x))
  stopifnot(require(tidyverse))

  ## content
  x_lead <- lead(x)
  res <- ((x+x_lead)/2) %>% na.omit
  attributes(res) <- NULL

  ## Return
  return(res)

}

#' Midpoint values
#' @description returns midpoint values
#' @param x input numeric type vector
#' @export
#' @examples
#' midpoint(1:10)

midpoint <- function(x, ...){

  stopifnot(is.vector(x), require(tidyverse))

  x_lead <- lead(x)
  res <- ((x+x_lead)/2) %>% na.omit
  attributes(res) <- NULL

  return(res)

}

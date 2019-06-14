#' Midpoint values
#' @description returns midpoint values
#' @param x input numeric type vector
#' @export
#' @examples
#' midpoint(1:10)

midpoint <- function(x, ...){

  stopifnot(is.vector(x))

  x_lead <- dplyr::lead(x)
  res <- ((x + x_lead) / 2) %>% na.omit
  attributes(res) <- NULL

  return(res)

}

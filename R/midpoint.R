#' midpoint values
#'
#' returns midpoint values
#' @param x input numeric type vector
#' @export
#' @examples
#' midpoint(1:10)

midpoint <- function(x, ...){

  ## pre
  stopifnot(is.vector(x))
  stopifnot(require(dplyr))

  ## content
  x_lead <- lead(x)
  res <- ((x+x_lead)/2) %>% na.omit
  attributes(res) <- NULL

  ## return
  return(res)

}

#' Waffle chart (Add proportions)
#'
#' This function that transforms the \code{waffle::waffle()}.
#' It displays the proportions in the legend text.
#' @export
#' @examples
#' x <- c("Apple" = 1, "Banana" = 2, "Watermelon" = 3)
#' prop_waffle(x, 1, 4, size = 1)

prop_waffle <- function(x, rounding = 1, ...){

  ## pre
  stopifnot(require(dplyr)); stopifnot(require(waffle)); stopifnot(require(formattable))

  ## content
  d <- round(prop.table(x)*100, 0)
  names(d) <- names(x) %>% paste0(" (", prop.table(x) %>% percent(rounding), ")")

  ## return
  waffle(d, ...)

}

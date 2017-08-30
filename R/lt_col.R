#' Color Palettes
#' @description Color Palettes for lovetoken
#' @param n the number of colors (≥ 1) to be in the palette.
#' @param alpha	the alpha transparency, a number in [0,1].
#' @export
#' @examples
#' (colors1 <- lt_col(9, alpha = .5))
#' pie(rep(1, 9), col = colors1, clockwise = T)

lt_col <- function(n, alpha = 1, random = F, ...){

	## Pre
	n <- as.integer(n)

	pal <- c(
	  rgb(228, 228, 228, alpha * 255, maxColorValue = 255, ...),
	  rgb(216, 227, 240, alpha * 255, maxColorValue = 255, ...),
	  rgb(158, 185, 218, alpha * 255, maxColorValue = 255, ...),
	  rgb(185, 225, 215, alpha * 255, maxColorValue = 255, ...),
	  rgb(81 , 179, 156, alpha * 255, maxColorValue = 255, ...),
	  rgb(151, 194, 61 , alpha * 255, maxColorValue = 255, ...),
	  rgb(213, 231, 177, alpha * 255, maxColorValue = 255, ...),
	  rgb(38 , 59 , 191, alpha * 255, maxColorValue = 255, ...),
	  rgb(191, 191, 191, alpha * 255, maxColorValue = 255, ...)
	  )

	if(random) pal <- sample(pal)

	## Return
	rep(pal, length = n)

}

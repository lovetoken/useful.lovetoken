#' Describe dataset using psych::describe() function
#' @description Alias function of \code{psych::describe()}
#' @param x A data frame or matrix
#' @param choice
#' @param ... Arguments to be passed to \code{psych::describe()}
#' @export
#' @examples
#' mtcars
#' descr(mtcars)
#' descr(mtcars, c("n", "mean", "range"))

descr <- function(x, choice = c("n", "mean", "sd", "median", "min", "max", "range"), ...){

	bres <- psych::describe(x, ...)
	res <- bres %>%
	   dplyr::select(choice)

	return(res)
}

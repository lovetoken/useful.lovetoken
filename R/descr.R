#' Describe dataset using psych::describe() function
#'
#' Alias function of \code{psych::describe()}
#' @param x A data frame or matrix
#' @param choice
#' @param ... Arguments to be passed to \code{psych::describe()}
#' @export
#' @examples
#' mtcars
#' descr(mtcars)
#' descr(mtcars, c("vars", "n", "mean", "range"))

descr <- function(x, choice=c("vars", "n", "mean", "sd", "median", "min", "max", "range"), ...){

  ## pre
	stopifnot(require(psych))

	## content
	bres <- describe(x, ...)
	res <- bres[names(bres) %in% choice]

	## return
	return(res)

}

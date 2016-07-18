#' Describe dataset using psych::describe() function
#'
#' psych 패키지의 \code{describe()} 를 이용하여 알맞게 수정한 alias 함수 입니다.
#' @param x A data frame or matrix
#' @param choice 
#' @param ... Arguments to be passed to \code{psych::describe()}
#' @export
#' @examples
#' desc(mtcars)
#' desc(mtcars, boxplot = T)
#' bound_trim(c(1, 5, 9, 10), 0, 9)
#' bound_trim(rnorm(100), -1.96, 1.96)

desc <- function(x, choice=c("vars", "n", "mean", "sd", "median", "min", "max", "range"), ...){

	# pre
	stopifnot(require(psych))

	# content
	bres <- describe(x, ...)
	res <- bres[names(bres) %in% choice]

	# return
	return(res)

}
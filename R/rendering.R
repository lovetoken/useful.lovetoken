#' Open files after rmarkdown::render()
#'
#' Open files after rmarkdown::render(..., encoding = "UTF-8") about \code{.rmd} format script.
#' @export
#' @examples
#' rendering()

rendering <- function(...){

  ## pre
	stopifnot(require(rmarkdown))

	## content
	input <- grep("\\.[rR][mM][dD]$", list.files(), perl = T, value = T)

	for(i in input){
		res <- render(i, encoding = "UTF-8", ...)
		openfd(res)
	}

}

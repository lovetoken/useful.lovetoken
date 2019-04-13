#' Open files after rmarkdown::render()
#' @description Open files after rmarkdown::render(..., encoding = "UTF-8") about \code{.rmd} format script.
#' @export
#' @examples
#' rendering()

rendering <- function(pattern = NULL, ...){

  if(is.null(pattern)){
    input <- grep("\\.[rR][mM][dD]$", list.files(), perl = T, value = T)
  } else {
    input <- grep(pattern, list.files(), perl = T, value = T)
  }

	for(i in input){
		res <- rmarkdown::render(i, encoding = "UTF-8", ...)
		openfd(res)
	}

}

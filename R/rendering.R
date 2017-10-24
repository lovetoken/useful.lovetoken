#' Open files after rmarkdown::render()
#' @description Open files after rmarkdown::render(..., encoding = "UTF-8") about \code{.rmd} format script.
#' @export
#' @examples
#' rendering()

rendering <- function(pattern = NULL, ...){

  ## Pre
	stopifnot(require(rmarkdown))

	## Content
  if(is.null(pattern)){
    input <- grep("\\.[rR][mM][dD]$", list.files(), perl = T, value = T)
  } else {
    input <- grep(pattern, list.files(), perl = T, value = T)
  }

	for(i in input){
		res <- render(i, encoding = "UTF-8", ...)
		openfd(res)
	}

}

#' Code run about .rmd
#' @description \code{.rmd} 를 소스코드로 변환 후 (\code{purl()}에 의하여) R script 를 실행합니다.
#' @export
#' @examples
#'
source.rmd <- function(file, ...) {

  ## Pre
  stopifnot(require(knitr))

  ## Content
  source(purl(file), ...)
}

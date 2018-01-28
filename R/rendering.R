#' Open files after rmarkdown::render()
#' @description Open files after rmarkdown::render(..., encoding = "UTF-8") about \code{.rmd} format script.
#' @export
#' @examples
#' rendering()

rendering <- function(pattern = NULL, ...){

	stopifnot(require(rmarkdown))

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
#' @description \code{knitr::purl()}에 의하여 \code{.rmd} 스크립트를 R 스크립트로 변환 후 실행합니다. \code{rmarkdown::render()} 함수 보다 저수준 함수로 보는 것이 좋습니다. R 스크립트의 변환을 통해 중간과정을 남기고 추적하기 위한 저수준 함수로 볼 수 있습니다.
#' @param delete 순수한 R 스크립트 기본적으로 반환되나 필요하지 않을 경우 \code{delete = T} 로 설정하여 지울 수 있습니다.
#' @export
#' @examples

source.rmd <- function(file, delete = F, ...) {

  stopifnot(require(knitr))

  rcode <- purl(file)
  source(rcode, ...)
  if(delete) file.remove(rcode)

}

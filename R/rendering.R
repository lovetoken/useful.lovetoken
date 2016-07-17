#' Open files after rmarkdown::render()
#'
#' rmarkdown 패키지의 \code{render()} 를 보다 편리하게 사용하는 상속함수 입니다.
#' 현재 워킹디렉토리에 있는 \code{.rmd} 파일을 자동으로 rendering 한 이후 생성된 결과물을 바로 실행합니다.
#' @export
#' @examples
#' rendering()

rendering <- function(...){

	# pre

	stopifnot(require(rmarkdown))
	stopifnot(require(dplyr))

	# content

	input <- list.files() %>%
		grep("\\.rmd$", ., perl=T, value=T)

	for(i in input){
		res <- render(i, encoding="UTF-8", ...)
		openfd(res)
	}

}

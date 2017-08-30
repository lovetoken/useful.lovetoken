#' Open the file or directory directly on R console
#' @description Open the file or directory directly on R console
#' @param path character, default is \code{getwd()}
#' @export
#' @examples
#' openfd()

openfd <- function(path = NULL){

	## Pre
	if(is.null(path)) r_path <- "." else r_path <- path
	whatplatform <- .Platform["OS.type"]

	## Content
	if(whatplatform == "windows") shell.exec(r_path) else system(paste("open", r_path))

}

#' Open the file or directory directly on R console
#'
#' Open the file or directory directly on R console
#' @param path character, default is \code{getwd()}
#' @export
#' @examples
#' openfd()

openfd <- function(path = NULL){
	# pre
	if(is.null(path)) r_path <- "." else r_path <- path
	whatplatform <- .Platform["OS.type"]

	# content
	if(whatplatform == "windows") shell.exec(r_path) else system(paste("open", r_path))
}
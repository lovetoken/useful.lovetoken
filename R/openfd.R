#' Open the file or directory directly on R console
#'
#' Open the file or directory directly on R console
#' @param path path the file or directory. default is \code{getwd()}
#' @export
#' @examples
#' openfd()

openfd <- function(path = NULL){

	# pre
	if(is.null(path)){

		r_path <- "."

	} else {

		stopifnot(is.character(path))
		r_path <- path

	}

	whatplatform <- .Platform['OS.type']

	# content
	if (whatplatform == "unix"){

		system(paste(Sys.getenv("R_BROWSER"), r_path))

	} else if (whatplatform == "windows"){

		shell.exec(r_path)
		
	}

}
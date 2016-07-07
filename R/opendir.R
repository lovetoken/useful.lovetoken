#' open the working directory directly on R console
#'
#' open the working directory directly on R console
#' @param dir default is \code{getwd()}
#' @export
#' @examples
#' opendir()

opendir <- function(dir = getwd()){

  # content
  if (.Platform['OS.type'] == "windows"){
    shell.exec(dir)
  } else {
    system(paste(Sys.getenv("R_BROWSER"), dir))
  }

}

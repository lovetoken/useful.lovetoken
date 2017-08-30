#' Match string using Regex patterns
#' @description Match string out directly
#' @export
#' @examples
#' t <- c("Ab80", "bU09", "CD11", "DA01", "EW", "fP39")
#' regmatch("^[A-Z]*", t)

regmatch <- function(pattern, text, ...){

  ## Content
  m <- gregexpr(pattern, text)
  return(unlist(regmatches(text, m)))

}

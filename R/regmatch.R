#' Match string using Regex patterns
#'
#' Match string using Regex patterns
#' @export
#' @examples
#' t <- c("A80", "B09", "C11", "D01", "E", "f39")
#' regmatch("[A-Z]", t)

regmatch <- function(pattern, text){

  ## pre
  stopifnot(require(tidyverse))

  ## content
  m <- gregexpr(pattern, text)
  return(regmatches(text, m))

}
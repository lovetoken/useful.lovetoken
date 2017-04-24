#' Match string using Regex patterns
#'
#' Match string using Regex patterns
#' @export
#' @examples
#' t <- c("A80", "B09", "C11", "D01", "E")
#' regmatch("[A-Z]", t)

regmatch <- function(pattern, text){

  ## pre
  stopifnot(require(tidyverse))

  ## content
  res <- regexpr(pattern, text) %>% regmatches(text, .)
  return(res)

}

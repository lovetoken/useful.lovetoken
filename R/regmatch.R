#' Match string using Regex patterns
#' @description Match string out directly
#' @export
#' @examples
#' t <- c("Ab80", "bU09", "CC11", "D0A1", "EW19", "fp39")
#' regmatch("[A-Z]", t)
#' regmatch("[A-Z]", t, global = T)

regmatch <- function(pattern, text, global = F, ...){

  ## content
  if(global){
    m <- gregexpr(pattern, text, ...)
    res <- regmatches(text, m)
  }

  if(global == F){
    m <- regexpr(pattern, text, ...)
    res <- regmatches(text, m)
  }

  return(res)
}

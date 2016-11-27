#' Trimming of whitespace in character
#'
#' Trimming of whitespace in character
#' @param cha input character type
#' @param method trimming method
#' @export
#' @examples
#' trim("  Wow!  ", "leading")
#' trim("  Wow!  ", "trailing")

trim <- function(cha, method = c("leading", "trailing")){

  ## pre
  stopifnot(is.character(cha))
  method <- match.arg(method)

  ## content
  switch(method,
         leading = sub("^\\s+", "", cha),
         trailing = sub("\\s+$", "", cha))

}

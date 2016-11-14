#' Trimming of whitespace in character
#'
#' 공란(whitespace)을 잘라냅니다.
#' @param cha 가공의 대상이 되는 character type 자료를 입력합니다.
#' @param method 잘라내는 방법을 택합니다.
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

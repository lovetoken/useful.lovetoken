#' Trimming of whitespace in character
#'
#' 공란(whitespace)을 잘라냅니다.
#' @param cha 가공의 대상이 되는 character type 자료를 입력합니다.
#' @param method 잘라내는 방법을 택합니다.
#' @export
#' @examples
#' trim("  Wow!  ", method="leading")
#' trim("  Wow!  ", method="trailing")

trim <- function(cha, method = "trailing"){
  # pre
  stopifnot(is.character(cha))
  stopifnot(method %in% c("leading", "trailing"))

  # content
  if(method == "leading"){

    res <- sub("^\\s+", "", cha)

  } else if(method == "trailing"){

    res <- sub("\\s+$", "", cha)

  }

  return(res)
}

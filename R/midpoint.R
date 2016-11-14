#' midpoint values
#'
#' 실수 벡터에 대해 midpoint 를 반환합니다.
#' @param x 가공의 대상이 되는 numeric type 벡터를 입력합니다.
#' @param ... \code{lead()} 함수의 상속 부분입니다.
#' @export
#' @examples
#' midpoint(1:10)

midpoint <- function(x, ...){

  ## pre
  stopifnot(is.vector(x))
  stopifnot(require(dplyr))

  ## content
  x_lead <- lead(x)
  res <- ((x+x_lead)/2) %>% na.omit
  attributes(res) <- NULL

  ## return
  return(res)

}

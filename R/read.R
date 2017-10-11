#' Read a CSV before infrence encoding type
#' @description CSV 파일을 읽어들이기 전 인코딩 타입추론 이후 인코딩매칭을 시킨다음 읽어들입니다. \code{read.csv()} 함수를 기반으로 합니다.
#' @export
#' @examples

read.csv3 <- function(file, ...){

  ## Pre
  stopifnot(require(tidyverse))

  ## Content
  guessed <- guess_encoding(file)[1, 1] %>% as.character
  res <- read.csv(file, fileEncoding = guessed, ...)

  ## Return
  return(res)
}

#' Read a CSV before infrence encoding type
#' @description CSV 파일을 읽어들이기 전 인코딩 타입추론 이후 인코딩매칭을 시킨다음 읽어들입니다. \code{readr::read_csv()} 함수를 기반으로 합니다.
#' @export
#' @examples

read_csv3 <- function(file, ...){

  ## Pre
  stopifnot(require(tidyverse))

  ## Content
  guessed <- guess_encoding(file)[1, 1] %>% as.character
  res <- read_csv(file, locale = locale(encoding = guessed), ...)

  ## Return
  return(res)
}

#' Write rda about imported tables
#' @description 외부테이블 파일(.txt, .csv 포맷)들을 import 한 후 rda 형태로 모두 변환하여 저장합니다. 객체명은 \code{rawdata} 로 저장됩니다.
#' @param path a character vector; file paths
#' @export

csv2rda <- function(path, ...){

  ## Pre
  stopifnot(require(tidyverse))

  ## Content
  for(i in path){
    rawdata <- read_csv3(i, trim_ws = T)
    save(rawdata, file = gsub("\\.(txt|csv)$", ".rda", i))
  }

}

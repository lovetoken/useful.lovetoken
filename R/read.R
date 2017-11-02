#' Read a separated values file before infrence encoding type
#' @description 구분자로 분리된 외부테이블 파일을 읽어들이기 전 인코딩 타입추론 이후 인코딩매칭을 시킨다음 읽어들입니다. \code{readr::read_delim()} 함수를 기반으로 합니다.
#' @export
#' @examples

read_svf <- function(file, ...){

  ## Pre
  stopifnot(require(tidyverse))

  ## Content
  guessed <- guess_encoding(file)[1, 1] %>% as.character
  res <- read_delim(file, locale = locale(encoding = guessed), ...)

  ## Return
  return(res)
}

#' Write .rda about separated values file
#' @description 구분자로 분리된 외부테이블 파일을 import 한 후 .rda 형태로 변환 및 압축하여 저장합니다. 객체명은 \code{rawdata} 로 저장됩니다. 저장되는 위치는 원본 외부테이블 파일이 있는 디렉토리입니다.
#' @param path a character vector; file paths
#' @export
#' @examples
#' svf2rda("data/hangle.csv", ",")

svf2rda <- function(file, ...){

  ## Pre
  stopifnot(require(tidyverse))

  ## Content
  for(i in file){
    rawdata <- read_svf(i, trim_ws = T, ...) # TODO : object name 을 assign() function 을 이용해 선택할 수 있는 기능이 필요할듯
    save(rawdata, file = gsub("\\..*$", ".rda", i), compress = T) # TODO : 뒷부분 확장명을 대치시키는 로직을 더 개선시켜야함
  }

}

#' Write .rds about separated values file
#' @description 구분자로 분리된 외부테이블 파일을 import 한 후 .rds 형태로 변환 및 압축하여 저장합니다. 저장되는 위치는 원본 외부테이블 파일이 있는 디렉토리입니다.
#' @param path a character vector; file paths
#' @export
#' @examples

svf2rds <- function(file, ...){

  ## Pre
  stopifnot(require(tidyverse))

  ## Content
  for(i in file){
    rawdata <- read_svf(i, trim_ws = T, ...)
    saveRDS(rawdata, file = gsub("\\..*$", ".rds", i)) # TODO : 뒷부분 확장명을 대치시키는 로직을 더 개선시켜야함
  }

}

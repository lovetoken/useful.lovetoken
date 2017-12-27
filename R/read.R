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
#' @description 구분자로 분리된 외부테이블 파일을 import 한 후 .rda 형태로 변환하여 저장합니다. 객체명은 \code{rawdata} 로 저장됩니다.
#' @param x a character vector; file paths
#' @param file a connection or the name of the file where the data will be saved. if null same \code{x} paths as save name after pasted \code{.rda}
#' @export
#' @return \code{file} 로 .rda 파일이 저장되며, 이를 로드할 때 \code{rawdata} 객체가 반환됩니다.
#' @examples
#' svf2rda("data/hangle.csv", "data/hangle.rda", delim = ",")

svf2rda <- function(x, file = NULL, ...){

  ## Pre
  stopifnot(require(tidyverse))

  ## Content
  for(i in x){
    rawdata <- read_svf(i, trim_ws = T, ...) # TODO : object name 을 assign() function 을 이용해 선택할 수 있는 기능이 필요할듯
    save(rawdata, file = if(is.null(file)) paste0(x, ".rda") else file, compress = T)
  }

}

#' Write .rds about separated values file
#' @description 구분자로 분리된 외부테이블 파일을 import 한 후 .rds 형태로 변환하여 저장합니다. 저장되는 위치는 원본 외부테이블 파일이 있는 디렉토리입니다.
#' @param x a character vector; file paths
#' @param file a connection or the name of the file where the data will be saved. if null same \code{x} paths as save name after pasted \code{.rds}
#' @export
#' @examples

svf2rds <- function(x, file = NULL, ...){

  ## Pre
  stopifnot(require(tidyverse))

  ## Content
  for(i in x){
    rawdata <- read_svf(i, trim_ws = T, ...)
    saveRDS(rawdata, file = if(is.null(file)) paste0(x, ".rda") else file, compress = T)
  }

}

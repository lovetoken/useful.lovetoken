#' Loading of many packages (using vector type) before auto update packages
#'
#' 2개 이상의 Package들을 한번에 로드하며, 동시에 업데이트 가능 패키지를 업데이트 한 후 이전버전과 설치된 버전을 요약하여 출력합니다.
#' @param packages 불러올 패키지를 vector 형을 작성합니다. 문자열로 작성 합니다.
#' @param auto.ins 만약 불러올 패키지 중에 설치가되어있지 않은 패키지가 있다면 자동으로 설치할 것인지 여부를 정합니다.
#' @param message 패키지 로드 결과 summary 를 출력할 것인지 여부를 정합니다.
#' @return summary 결과를 data.frame 형으로 반환하며, \code{message=FALSE} 시 반환되는 것은 없습니다.
#' @seealso \link{library}
#' @export
#' @examples
#' librarys(packages=c("devtools", "utils", "knitr", "bmp", "ggplot2"))
librarys <- function(packages, auto.ins=FALSE, message=TRUE){

  # pre
  options(warn=-1)
  stopifnot(is.character(packages))
  stopifnot(is.logical(auto.ins))
  stopifnot(is.logical(message))

  open_packages <- unique(packages)
  is_opened <- c()
  for(i in seq(length(open_packages))){
    is_opened[i] <- library(open_packages[i], character.only=T, logical.return=T)
  }

  # summary
  d1 <- data.frame(open_packages, is_opened)
  td1 <- data.frame(installed.packages(), stringsAsFactors=F)
  summary <- merge(d1, td1[c(1,3)], by.x="open_packages", by.y="Package", all.x=T)
  names(summary)[3] <- "before_version"

  # auto.ins?
  if(auto.ins){

    # install
    ins_package <- as.character(summary$open_packages[is.na(summary$before_version)])
    for(i in ins_package){
      install.packages(i)
    }

    # auto update packages
    update.packages(ask=F)

  } else {

    # auto update packages
    update.packages(ask=F)

  }

  # resummary
  td2 <- data.frame(installed.packages(), stringsAsFactors=F)
  resummary <- merge(summary, td2[c(1,3)], by.x="open_packages", by.y="Package", all.x=T)
  names(resummary)[4] <- "current_version"

  # reload
  for(i in seq(length(open_packages))){
    is_opened[i] <- library(open_packages[i], character.only=T, logical.return=T)
  }
  resummary$is_opened <- is_opened

  # retrieve
  options(warn=0)

  if(message){
    return(resummary[-2])
  }

}

#' Ignore NA paste function
#'
#' 결측치 NA 가 존재할 때, NA를 문자열로 인식하지 않고 공란으로 paste 를 수행합니다.
#' @seealso \link{paste0}
#' @export
#' @examples
#' A <- "Hello "
#' B <- c("world", "world!", NA)
#' paste0(A, B)
#' paste2(A, B)

paste2 <- function(...){

  ## pre
  stopifnot(require(dplyr))

  ## content
  li <- list(...)
  lapply(li, function(x){
    x[is.na(x)] <- "" ;x
  }) %>%
    data.frame %>%
    apply(1, function(x, ...) paste0(x, collapse = ""))

}

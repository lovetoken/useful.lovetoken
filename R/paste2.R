#' Ignore NA paste function
#'
#' Ignore NA paste function
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

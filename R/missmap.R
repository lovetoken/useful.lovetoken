#' Missingness Map after sampling
#' @description Plots a Missingness Map showing after sampling
#' @param x A dataframe
#' @export
#' @examples
#' d <- matrix(rnorm(25), 5)
#' d[c(2, 4), c(1, 5)] <- NA
#' as.data.frame(d) %>% missmap2

# missmap2 <- function(x, only_miss_var = F){
#
#   stopifnot(require(ggplot2), require(reshape2), require(tidyverse))
#
#   meltData <- x %>%
#     is.na %>%
#     melt %>%
#     tbl_df
#
#   varNames <- names(meltData)
#
#   if(only_miss_var){
#     naVars <- meltData %>%
#       group_by(Var2) %>%
#       summarize(sum_na = sum(value)) %>%
#       dplyr::filter(sum_na != 0) %>%
#       pull(get(varNames[2]))
#
#     meltData <- meltData %>%
#       dplyr::filter(get(varNames[2]) %in% naVars)
#   }
#
#   meltData %>%
#     ggplot(aes(x = get(varNames[2]), y = get(varNames[1]))) +
#     geom_raster(aes(fill = get(varNames[3]))) +
#     scale_fill_grey(name = "", labels = c("Present", "Missing")) +
#     theme_minimal() +
#     theme(axis.text.x  = element_text(angle = 45, vjust = 0.5)) +
#     labs(x = "Variables in Dataset", y = "Rows / observations")
#
# }

missmap2 <- function(x, rep = T, ...){

  stopifnot(require(dplyr))

  x %>%
    dplyr::sample_n(10^3, replace = rep) %>%
    Amelia::missmap(...)

}

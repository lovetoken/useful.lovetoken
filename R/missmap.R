#' Missingness Map after sampling
#' @description Plots a Missingness Map showing after sampling
#' @param x A data.frame
#' @export
#' @examples
#' d <- matrix(rnorm(25), 5)
#' d[c(2, 4), c(1, 5)] <- NA
#' as.data.frame(d) %>% missmap2
#' as.data.frame(d) %>% missmap2(only_miss = T)

missmap2 <- function(x, only_miss = F){

  stopifnot(require(ggplot2))

  meltData <- x %>%
    is.na() %>%
    reshape2::melt() %>%
    tbl_df()

  varNames <- names(meltData)

  if(only_miss){
    naVars <- meltData %>%
      dplyr::group_by(Var2) %>%
      dplyr::summarize(sum_na = sum(value)) %>%
      dplyr::filter(sum_na != 0) %>%
      dplyr::pull(get(varNames[2]))

    meltData <- meltData %>%
      dplyr::filter(get(varNames[2]) %in% naVars)
  }

  p <- meltData %>%
    ggplot(aes(x = get(varNames[2]), y = get(varNames[1]))) +
    geom_raster(aes(fill = get(varNames[3]))) +
    scale_fill_grey(name = "", labels = c("Present", "Missing")) +
    theme_minimal() +
    theme(axis.text.x  = element_text(angle = 45, vjust = 0.5)) +
    labs(x = "Variables in Dataset", y = "Rows / observations")

  print(p)

}

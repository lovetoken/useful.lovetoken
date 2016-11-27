#' Ranking assess funds using returns xts dataset
#'
#' Ranking assess funds using returns xts dataset & rank plotting
#' @param returns.xts an \code{xts} object about returns dataset
#' @param method returns mean or sd or Sharpe ratio
#' @return data.frame type about assessment result
#' @export
#' @examples
#' sample_index %>% xdiff_returns(2) %>% assess_rank("Fund_2")
#' sample_index %>% xdiff_returns(2) %>% assess_rank("Fund_2", step = T)

assess_rank <- function(returns.xts, choice.stock, step = F, ...){

  ## pre
  stopifnot(require(dplyr)); stopifnot(require(xts)); stopifnot(require(ggplot2))

  ## content
  rank_output <- apply(returns.xts, 1, function(x) rank(-x, ties.method = "max", na.last = "keep")) %>% t
  length <- apply(rank_output, 1, function(x) max(x, na.rm = T))
  pd <- as.data.frame(cbind(subset(rank_output, select = choice.stock), length))
  names(pd) <- c("rank", "max_rank")
  pd$label <- paste0(pd$rank, "/", pd$max_rank)

  tryCatch(expr={
    pd$rank <- factor(pd$rank, exclude = NULL, levels = max(pd$rank, na.rm = T):1);
    }, error = function(e) print("all NA")
  )

  ## plotting
  p <- ggplot(pd, aes(x = row.names(pd), y = rank, group = NA, label = label))

  if(step){
    p <- p + geom_step(alpha = .3, col = "blue") +
      geom_point() +
      theme(axis.text.x = element_text(angle = 90)) +
      geom_text(aes(vjust = -1), size = 3, alpha = .3) +
      labs(x = "", y = "Rank")
  } else {
    p <- p + geom_line(alpha = .3, col = "blue") +
      geom_point() +
      theme(axis.text.x = element_text(angle = 90)) +
      geom_text(aes(vjust = -1), size = 3, alpha = .3) +
      labs(x = "", y = "Rank")
  }

  names(pd)[1] <- paste0(choice.stock, "_rank")

  ## res
  print(p)
  attr(pd, "plot") <- p
  return(pd)

}

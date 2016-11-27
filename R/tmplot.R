#' ts and moving average plot for all fund items
#'
#' ts and (three lines) moving average plot for all fund items
#' @param xts an \code{xts} object
#' @param mv moving average parameters
#' @param plotly logical asking whether to using plotly class plotting
#' @param ... additional parameters passed to \code{facet_grid()}
#' @return \code{plotly} If TRUE, plotly class ploting. else ggplot2 class ploting. Default value is FALSE
#' @export
#' @examples
#' library("quantmod")
#'
#' data <- getSymbols("^ks11", from = Sys.Date() - 1000, to = Sys.Date(), auto.assign = F)
#'
#' tmplot(data)

tmplot <- function(xts, mv = c(20, 60, 120), ...){

  ## pre
  stopifnot(require(dplyr)); stopifnot(require(xts)); stopifnot(require(ggplot2)); stopifnot(require(reshape2))
  stopifnot(is.numeric(mv))

  mv <- as.integer(mv)
  mv1 <- mv[1]; mv2 <- mv[2]; mv3 <- mv[3]

  ## content
  pd1 <- xts %>%
    coredata %>%
    data.frame(Index = index(xts)) %>%
    melt(id = "Index")

  pd2 <- xts %>%
    rollapplyr(mv1, function(x) mean(x, na.rm = T), na.pad = T) %>%
    coredata %>%
    data.frame(Index = index(xts)) %>%
    melt(id = "Index", value.name = "moving_average_1")

  pd3 <- xts %>%
    rollapplyr(mv2, function(x) mean(x, na.rm = T), na.pad = T) %>%
    coredata %>%
    data.frame(Index = index(xts)) %>%
    melt(id = "Index", value.name = "moving_average_2")

  pd4 <- xts %>%
    rollapplyr(mv3, function(x) mean(x, na.rm = T), na.pad = T) %>%
    coredata %>%
    data.frame(Index = index(xts)) %>%
    melt(id = "Index", value.name = "moving_average_3")

  pd <- left_join(pd1, pd2) %>%
    left_join(pd3) %>%
    left_join(pd4)

  p <- ggplot(pd, aes(x = Index)) +
    geom_line(col = "grey", aes(y = value), stat = "identity", size = .8) +
    geom_line(col = "purple", aes(y = moving_average_1), stat = "identity") +
    geom_line(col = "blue", aes(y = moving_average_2), stat = "identity") +
    geom_line(col = "red", aes(y = moving_average_3), stat = "identity") +
    facet_grid(variable ~ ., scales = "free", ...) +
    labs(x = "", y = "")

  ## return
  p

}

#' ts and moving average plot for single fund item
#'
#' ts and moving average plot for single fund item
#' @param xts
#' @param choice.stock
#' @param mv
#' @param plotly
#' @export
#' @examples
#' library("quantmod")
#'
#' data <- getSymbols("^ks11", from = Sys.Date() - 1000, to = Sys.Date(), auto.assign = F)
#'
#' tm1plot(data, "KS11.Close")

# tm1plot <- function(xts, choice.stock, mv = c(20, 60, 120), plotly = F, ...){

#   ## pre
#   stopifnot(require(dplyr)); stopifnot(require(xts)); stopifnot(require(ggplot2)); stopifnot(require(plotly)); stopifnot(require(reshape2))
#   stopifnot(is.character(choice.stock)); stopifnot(is.numeric(mv))

#   mv <- as.integer(mv)
#   mv1 <- mv[1]; mv2 <- mv[2]; mv3 <- mv[3]

#   ## content
#   ### subset dataset
#   D <- subset(xts, select = choice.stock) %>% data.frame(date = index(.), .)

#   ### melt for ggplot plotting
#   PD <- melt(D, id = 1)

#   ### base ggplot
#   P <- ggplot(PD, aes(x = date, y = value, group = variable)) +
#     geom_line(size = .8, color = "grey") + labs(x = "Date", y = "") +
#     theme(axis.text.x = element_text(angle = 90))

#   ### moving average line
#   pd1 <- subset(xts, select = choice.stock) %>%
#     rollapplyr(mv1, function(x) mean(x, na.rm = T), na.pad = T) %>%
#     coredata %>%
#     data.frame(date = index(xts)) %>%
#     melt(id = "date", value.name = "moving_average_1")

#   pd2 <- subset(xts, select = choice.stock) %>%
#     rollapplyr(mv2, function(x) mean(x, na.rm = T), na.pad = T) %>%
#     coredata %>%
#     data.frame(date = index(xts)) %>%
#     melt(id = "date", value.name = "moving_average_2")

#   pd3 <- subset(xts, select = choice.stock) %>%
#     rollapplyr(mv3, function(x) mean(x, na.rm = T), na.pad = T) %>%
#     coredata %>%
#     data.frame(date = index(xts)) %>%
#     melt(id = "date", value.name = "moving_average_3")

#   P <- P + geom_line(data = pd1, aes(y = moving_average_1), color="purple") +
#     geom_line(data=pd2, aes(y = moving_average_2), color = "blue") +
#     geom_line(data=pd3, aes(y = moving_average_3), color = "red") +
#     facet_grid(. ~ variable, scales = "free", ...) +
#     guides(fill = F) + labs(x = "", y = "")

#   ## return
#   if(plotly) ggplotly(P) else P

# }

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
  PD1_1 <- xts %>%
    coredata %>%
    data.frame(Index = index(xts)) %>%
    melt(id = "Index")

  PD1_2 <- xts %>%
    rollapplyr(mv1, function(x) mean(x, na.rm = T), na.pad = T) %>%
    coredata %>%
    data.frame(Index = index(xts)) %>%
    melt(id = "Index", value.name = "moving_average_1")

  PD1_3 <- xts %>%
    rollapplyr(mv2, function(x) mean(x, na.rm = T), na.pad = T) %>%
    coredata %>%
    data.frame(Index = index(xts)) %>%
    melt(id = "Index", value.name = "moving_average_2")

  PD1_4 <- xts %>%
    rollapplyr(mv3, function(x) mean(x, na.rm = T), na.pad = T) %>%
    coredata %>%
    data.frame(Index = index(xts)) %>%
    melt(id = "Index", value.name = "moving_average_3")

  PD1 <- left_join(PD1_1, PD1_2) %>%
    left_join(PD1_3) %>%
    left_join(PD1_4)

  P <- ggplot(PD1, aes(x = Index)) +
    geom_line(col = "grey", aes(y = value), stat = "identity", size = .8) +
    geom_line(col = "purple", aes(y = moving_average_1), stat = "identity") +
    geom_line(col = "blue", aes(y = moving_average_2), stat = "identity") +
    geom_line(col = "red", aes(y = moving_average_3), stat = "identity") +
    facet_grid(variable ~ ., scales = "free", ...) +
    labs(x = "", y = "")

  ## return
  P

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
#   PD1_1 <- subset(xts, select = choice.stock) %>%
#     rollapplyr(mv1, function(x) mean(x, na.rm = T), na.pad = T) %>%
#     coredata %>%
#     data.frame(date = index(xts)) %>%
#     melt(id = "date", value.name = "moving_average_1")

#   PD1_2 <- subset(xts, select = choice.stock) %>%
#     rollapplyr(mv2, function(x) mean(x, na.rm = T), na.pad = T) %>%
#     coredata %>%
#     data.frame(date = index(xts)) %>%
#     melt(id = "date", value.name = "moving_average_2")

#   PD1_3 <- subset(xts, select = choice.stock) %>%
#     rollapplyr(mv3, function(x) mean(x, na.rm = T), na.pad = T) %>%
#     coredata %>%
#     data.frame(date = index(xts)) %>%
#     melt(id = "date", value.name = "moving_average_3")

#   P <- P + geom_line(data = PD1_1, aes(y = moving_average_1), color="purple") +
#     geom_line(data=PD1_2, aes(y = moving_average_2), color = "blue") +
#     geom_line(data=PD1_3, aes(y = moving_average_3), color = "red") +
#     facet_grid(. ~ variable, scales = "free", ...) +
#     guides(fill = F) + labs(x = "", y = "")

#   ## return
#   if(plotly) ggplotly(P) else P

# }

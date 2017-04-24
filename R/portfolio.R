#' Efficient Frontier
#'
#' Efficient Frontier using excess returns
#' @param returns xts or zoo value
#' @param rg numeric value, returns of goal
#' @export
#' @examples
#' returns <- xdiff_returns(sample_index, x = 1)
#' efff(returns, rg = .01, rfr = .001)

efff <- function(returns, rg = .01, rfr = .001, short = "no", max.allocation = NULL, risk.premium.up = .9,
                 risk.increment = .0001, plot.only.efff = F, ...){

  ## pre
  stopifnot(require(quadprog)); stopifnot(require(tidyverse)); stopifnot(require(ggplot2));
  stopifnot(is.numeric(rg)); stopifnot(is.numeric(rfr)); stopifnot(is.numeric(risk.premium.up)); stopifnot(is.numeric(risk.increment))

  ## content
  returns <- returns - rfr
  covariance <- cov(returns)
  nc <- ncol(covariance)

  Amat <- matrix(1, nrow = nc)
  bvec <- 1
  meq <- 1

  if(short == "no"){
    Amat <- cbind(1, diag(nc))
    bvec <- c(bvec, rep(0, nc))
  }

  if(!is.null(max.allocation)){

    if(max.allocation > 1 | max.allocation < 0) stop("max.allocation must be greater than 0 and less than 1")
    if(max.allocation * nc < 1) stop("Need to set max.allocation higher; not enough assets to add to 1")

    Amat <- cbind(Amat, -diag(nc))
    bvec <- c(bvec, rep(-max.allocation, nc))
  }

  loops <- risk.premium.up / risk.increment + 1
  loop <- 1

  eff <- matrix(nrow = loops, ncol = nc + 3)

  colnames(eff) <- c(colnames(returns), "Excess_Return", "Std_Dev", "Sharpe")

  for (i in seq(from = 0, to = risk.premium.up, by = risk.increment)){
    dvec <- colMeans(returns) * i

    sol <- solve.QP(covariance, dvec = dvec, Amat = Amat, bvec = bvec, meq = meq)
    eff[loop, "Std_Dev"] <- sqrt(sum(sol$solution * colSums(covariance*sol$solution)))
    eff[loop, "Excess_Return"] <- as.numeric(sol$solution %*% colMeans(returns))
    eff[loop, "Sharpe"] <- eff[loop,"Excess_Return"] / eff[loop,"Std_Dev"]
    eff[loop, 1:nc] <- sol$solution
    loop <- loop + 1
  }

  pool <- as.data.frame(eff)

  ### choice portfolios
  res <- pool[c(which.max(pool$Sharpe), which.min((pool$Excess_Return - rg)^2)), ]
  rownames(res) <- c("Market", "Return of goal")
  res["Theoretically Return of goal",] <- res["Market", ] * rg/res["Market", "Excess_Return"]
  res["Theoretically Return of goal", "Sharpe"] <- res["Theoretically Return of goal","Excess_Return"] / res["Theoretically Return of goal","Std_Dev"]

  ### ploting
  pd1 <- descr(returns, c("mean", "sd")) %>% tbl_df %>%
    mutate(labels = rownames(.)) %>% rename(Excess_Return = mean, Std_Dev = sd)

  p <- ggplot() +
    geom_point(data = pool, aes(x = Std_Dev, y = Excess_Return), size = .2, color = "#DAC0C0") +
    geom_point(data = pd1, aes(x = Std_Dev, y = Excess_Return, text = labels), size = 1, col = "#666666") +
    geom_abline(intercept = 0, slope = res["Market","Sharpe"], lty = "dashed", alpha = .3) + xlim(0, NA) + ylim(0, NA) +  # for CML
    geom_point(data = res, aes(x = Std_Dev, y = Excess_Return, color = rownames(res)), size = 2) +
    labs(title = paste0("Efficient Frontier (rfr = ", rfr, ")"), color = "") +
    theme(plot.title = element_text(size = rel(1.4)))

  ## return
  print(p)
  attr(res, "poolset") <- pool %>% tbl_df
  attr(res, "plot") <- p
  return(res)

}

#' All available portfolio
#'
#' Return of all available portfolio
#' @param returns xts or zoo value
#' @param rg goal of returns
#' @param rfr risk free rate
#' @param precision grid precision about investment weight
#' @param mirc maximum investment ratio constraint
#' @export
#' @examples
#' returns <- xdiff_returns(sample_index, 1)
#' aap(returns, rg = .01, rfr = .001)

aap <- function(returns, rg = .01, rfr = .001, precision = .01, mirc = 1, ...){

  ## pre
  stopifnot(require(dplyr)); stopifnot(require(xts)); stopifnot(require(dplyr)); stopifnot(require(ggplot2)); stopifnot(require(formattable))
  stopifnot(is.numeric(precision)); stopifnot(is.numeric(rfr)); stopifnot(is.numeric(rg)); stopifnot(is.numeric(mirc))

  ## content
  returns <- returns - rfr
  nc <- dim(returns)[2]

  poolset <- seq(0, 1, by = precision) %>%
    rep(nc) %>%
    matrix(length(seq(0, 1, by = precision)), nc) %>%
    data.frame %>%
    expand.grid %>% # !! : slow factor
    as.matrix

  w <- poolset[rowSums(poolset) == 1, ]
  w <- w[apply(w <= mirc, 1, all), ] %>% t
  attr(w, "dimnames")[[1]] <- names(returns)

  mu <- returns %>% colMeans(na.rm = T)
  mu_p <- c(t(w) %*% mu)

  sigma <- cov(returns)
  var_p <- diag(sqrt(t(w) %*% sigma %*% w))

  pool <- cbind(t(w), Excess_Return = mu_p, Std_Dev = var_p) %>% as.data.frame %>%
    mutate(Sharpe = mu_p/var_p)

  res <- pool[c(which.max(pool$Sharpe), which.min((pool$Excess_Return - rg)^2)), ]
  rownames(res) <- c("Market", "Return of goal")
  res["Theoretically Return of goal",] <- res["Market", ] * rg/res["Market", "Excess_Return"]
  res["Theoretically Return of goal", "Sharpe"] <- res["Theoretically Return of goal", "Excess_Return"] / res["Theoretically Return of goal", "Std_Dev"]

  ### ploting
  pd1 <- descr(returns, c("mean", "sd")) %>% tbl_df %>%
    mutate(labels = rownames(.)) %>% rename(Excess_Return = mean, Std_Dev = sd)

  p <- ggplot() +
    geom_point(data = pool, aes(x = Std_Dev, y = Excess_Return), size = .2, col = "#DAC0C0", alpha = .8) +
    geom_point(data = pd1, aes(x = Std_Dev, y = Excess_Return, text = labels), size = 1, col = "#666666") +
    geom_point(data = res, aes(x = Std_Dev, y = Excess_Return, color = rownames(res))) +
    geom_abline(intercept = 0, slope = res["Market","Sharpe"], lty = "dashed", alpha = .3) + xlim(0, NA) + ylim(0, NA) + # for CML
    labs(title = paste0("All available portfolio (rfr = ", rfr, ")"), color = "") +
    theme(plot.title = element_text(size = rel(1.4)))

  ## return
  print(p)
  attr(res, "poolset") <- pool %>% tbl_df
  attr(res, "plot") <- p
  return(res)

}

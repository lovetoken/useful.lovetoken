% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/regmatch.R
\name{regmatch}
\alias{regmatch}
\title{Match string using Regex patterns}
\usage{
regmatch(pattern, text, global = F, ...)
}
\description{
Match string out directly
}
\examples{
t <- c("Ab80", "bU09", "CC11", "D0A1", "EW19", "fp39")
regmatch("[A-Z]", t)
regmatch("[A-Z]", t, global = T)
}

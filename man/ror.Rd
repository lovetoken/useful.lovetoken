% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/returns.R
\name{ror_y}
\alias{ror_y}
\alias{ror_m}
\alias{ror_d}
\title{Accounting rolling returns}
\usage{
ror_y(xts, k)

ror_m(xts, k)

ror_d(xts, k)
}
\arguments{
\item{xts}{time series dataset produced by \code{xts}. Should be satisfied "ymd" term of \code{index(xts)}.}

\item{k}{an integer vector.}
}
\value{
\code{xts} about returns dataset.
}
\description{
Accounting rolling rate of returns (years, months, days)
}
\examples{
ror_y(sample_index2, 1)
ror_m(sample_index2, 1)
ror_d(sample_index2, 1)

ror_y(sample_index2, 2)
ror_m(sample_index2, 15)
ror_d(sample_index2, 50)
}

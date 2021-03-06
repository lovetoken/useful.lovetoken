% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recent_week.R
\name{recent_weekday}
\alias{recent_weekday}
\title{Sequence Date Generation (only Weekday) from recent day}
\usage{
recent_weekday(recent_day, to = Sys.Date())
}
\arguments{
\item{recent_day}{input integer value}

\item{to}{recent day. default is \code{Sys.Date()}}
}
\value{
"\%Y-\%m-\%d" Date class
}
\description{
Sequence Date Generation (only Weekday) from recent day
}
\examples{
recent_weekday(20)
recent_weekday(20, as.Date("2000-08-20"))
}
\seealso{
\link{is.weekend}
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/outliers0.R
\name{outlierLineages}
\alias{outlierLineages}
\title{Detect lineages with unusually large evolutionary divergence under the fitted treedater model}
\usage{
outlierLineages(td, alpha = 0.05, type = c("tips", "internal", "all"))
}
\arguments{
\item{td}{A fitted treedater object}

\item{alpha}{The tail probability used for classifying lineages as outliers}

\item{type}{Should outliers be detected on tip lineages, interal lineages, or all lineages?}
}
\value{
A data frame summarizing for each lineage the p values, adjusted p values ('q'), likelihood, rates, and branch lengths.
}
\description{
Outliers are detected using the *stats::p.adjust* function and the 'fdr' function. The test requires that *dater* was used with the temporalConstraints=TRUE.
}
\seealso{
dater
outlier.tips
}

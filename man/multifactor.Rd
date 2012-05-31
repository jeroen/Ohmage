\name{multifactor}
\alias{as.vector.multifactor}
\alias{expand.multifactor}
\alias{facdim}
\alias{is.multifactor}
\alias{multifactor}
\alias{[.multifactor}
\alias{[[.multifactor}
\alias{rep.multifactor}
\title{Multifactor is a datastructure for survey items in the form of 'check all that apply'. Every response has multiple values.}
\usage{
  multifactor(values, levels = unique(unlist(values)),
    labels = levels, ordered = TRUE)
}
\arguments{
  \item{values}{a list of vectors with response values}

  \item{levels}{a vector with possible values}

  \item{labels}{a vector with labels}

  \item{ordered}{ordered or unordered factor}
}
\value{
  a multifactor object
}
\description{
  Multifactor is a datastructure for survey items in the
  form of 'check all that apply'. Every response has
  multiple values.
}


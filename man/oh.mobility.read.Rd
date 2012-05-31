\name{oh.mobility.read}
\alias{oh.mobility.read}
\title{Read Mobility data}
\usage{
  oh.mobility.read(date = today(),
    username = getOption("ohmage_username"), column_list,
    ...)
}
\arguments{
  \item{date}{date in ISO format}

  \item{username}{name of user to query (only works when
  server allows to see others data).}

  \item{column_list}{variables to be returned}

  \item{...}{stuff passed to oh.call}
}
\value{
  a dataframe with mobility data
}
\description{
  Read Mobility data
}


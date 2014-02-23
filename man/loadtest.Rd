\name{loadtest}
\alias{loadtest}
\title{Data generations for loadtesting}
\usage{
loadtest(n.users = 10, n.days = 5, n.responses = 2,
  xmlfile = system.file(package = "Ohmage", "files/jeroen.xml"),
  recycle = TRUE, verbose = FALSE, shareall = TRUE,
  user.prefix = "loadtest")
}
\arguments{
  \item{n.users}{number of users to generate}

  \item{n.days}{number of days per user}

  \item{n.responses}{number of responses per day}

  \item{xmlfile}{xml file or string}

  \item{recycle}{if https connection should be kept alive
  (recommended)}

  \item{verbose}{verbose output}

  \item{shareall}{should data be shared? T/F}

  \item{user.prefix}{prefix used for campaign and user
  names.}
}
\description{
Data generations for loadtesting
}


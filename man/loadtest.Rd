\name{loadtest}
\alias{loadtest}
\title{Data generations for loadtesting}
\usage{
  loadtest(xmlfile, n.users, n.days = 7, n.responses = 3,
    recycle = TRUE, verbose = FALSE)
}
\arguments{
  \item{xmlfile}{xml file or string}

  \item{n.users}{number of users to generate}

  \item{n.days}{number of days per user}

  \item{n.responses}{number of responses per day}

  \item{recycle}{if https connection should be kept alive
  (recommended)}

  \item{verbose}{verbose output}
}
\description{
  Data generations for loadtesting
}


\name{oh.login}
\alias{oh.login}
\title{Authenticate with an ohmage server}
\usage{
oh.login(user, password, serverurl, ...)
}
\arguments{
  \item{user}{ohmage username}

  \item{password}{ohmage passwd}

  \item{serverurl}{url to the ohmage server}

  \item{...}{extra parameters for oh.call}
}
\description{
Authenticate with an ohmage server
}
\examples{
library(Ohmage)
\dontrun{
#authentication works like a cookie.
#oh.login("ohmage.admin", "ohmage.passwd", "https://example.com/app")

#list campaigns you are in
#oh.campaign.read()

#read some data
#oh.survey_response.read("urn:ohmage:campaign:mycampaign");
}
}


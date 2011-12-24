\name{oh.survey.upload}
\alias{oh.survey.upload}
\title{Upload a survey response}
\usage{
  oh.survey.upload(campaign_urn, user, password, surveys,
    campaign_creation_timestamp, ...)
}
\arguments{
  \item{campaign_urn}{campaign id}

  \item{user}{username}

  \item{password}{password}

  \item{surveys}{surveys}

  \item{campaign_creation_timestamp}{ISO 8601}

  \item{...}{other arguments passed to ohmage}
}
\value{
  data frame with responses
}
\description{
  Upload a survey response
}


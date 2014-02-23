\name{oh.survey_response.update}
\alias{oh.survey_response.update}
\title{Update the privacy status of a survey response}
\usage{
oh.survey_response.update(campaign_urn, survey_key, privacy_state = "shared",
  ...)
}
\arguments{
  \item{campaign_urn}{campaign id}

  \item{survey_key}{survey id}

  \item{privacy_state}{Must be one of shared or private.}

  \item{...}{other arguments passed to oh.call}
}
\description{
Update the privacy status of a survey response
}


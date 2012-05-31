\name{oh.survey_response.function.read}
\alias{oh.survey_response.function.read}
\title{Survey Response Function Read}
\usage{
  oh.survey_response.function.read(campaign_urn,
    id = "privacy_state", privacy_state = NULL,
    privacy_state_item_list = "date,survey", ...)
}
\arguments{
  \item{campaign_urn}{campaign urn}

  \item{id}{Function id. The currently supported id is
  privacy_state}

  \item{privacy_state}{depricated. Should be NULL.}

  \item{privacy_state_item_list}{comma seperated list of
  output}

  \item{...}{other stuff passed to oh.call}
}
\value{
  a list
}
\description{
  Allows users with the appropriate permissions to read
  aggregate data about survey responses. The API takes an
  id parameter that tells the system which function to
  perform on the data.
}


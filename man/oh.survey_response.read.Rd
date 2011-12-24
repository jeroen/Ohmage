\name{oh.survey_response.read}
\alias{oh.survey_response.read}
\title{Read survey responses}
\usage{
  oh.survey_response.read(campaign_urn,
    prompt_id_list = "urn:ohmage:special:all",
    privacy_state = "both",
    column_list = "urn:ohmage:user:id,urn:ohmage:prompt:response,urn:ohmage:context:timestamp",
    output_format = "json-columns",
    user_list = "urn:ohmage:special:all",
    to.data.frame = TRUE, ...)
}
\arguments{
  \item{campaign_urn}{campaign id}

  \item{prompt_id_list}{comma seperated ist of promt id's}

  \item{privacy_state}{shared or private}

  \item{column_list}{ohmage columns}

  \item{output_format}{should be json-columns}

  \item{user_list}{list of users}

  \item{to.data.frame}{if data should be converted to a
  dataframe}

  \item{...}{other args passed to ohmage}
}
\description{
  Read survey responses
}


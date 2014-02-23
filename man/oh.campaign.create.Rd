\name{oh.campaign.create}
\alias{oh.campaign.create}
\title{Create a new campaign}
\usage{
oh.campaign.create(xml, running_state = "running", privacy_state = "shared",
  class_urn_list = "", description = "My campaign.", ...)
}
\arguments{
  \item{xml}{campaign.xml}

  \item{running_state}{if campaign is running or not}

  \item{privacy_state}{private or shared}

  \item{class_urn_list}{classes to add}

  \item{description}{a description}

  \item{...}{other stuff passed to the server}
}
\description{
Create a new campaign
}


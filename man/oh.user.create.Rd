\name{oh.user.create}
\alias{oh.user.create}
\title{Create a new user}
\usage{
oh.user.create(username, password, admin = FALSE, enabled = TRUE,
  new_account = FALSE, campaign_creation_privilege = FALSE, ...)
}
\arguments{
  \item{username}{username}

  \item{password}{password}

  \item{admin}{if the user should be an admin}

  \item{enabled}{if new account should be enabled}

  \item{new_account}{user marked as new_account have to
  change their passwd}

  \item{campaign_creation_privilege}{if user can create
  campaigns}

  \item{...}{other arguments passed on to ohmage}
}
\description{
Create a new user
}


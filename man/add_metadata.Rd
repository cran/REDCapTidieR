% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_redcap.R
\name{add_metadata}
\alias{add_metadata}
\title{Supplement a supertibble with additional metadata fields}
\usage{
add_metadata(supertbl, db_metadata, redcap_uri, token)
}
\arguments{
\item{supertbl}{a supertibble object to supplement with metadata}

\item{db_metadata}{a REDCap metadata tibble}

\item{redcap_uri}{The
URI/URL of the REDCap server (e.g.,
"https://server.org/apps/redcap/api/"). Required.}

\item{token}{The user-specific string that serves as the password for a
project. Required.}
}
\value{
The original supertibble with additional fields:
\itemize{
\item \code{instrument_label} containing labels for each instrument
\item \code{redcap_metadata} containing metadata for the fields in each
instrument as a list column
}
}
\description{
Supplement a supertibble with additional metadata fields
}
\details{
This function assumes that \code{db_metadata} has been processed to
include a row for each option of each multiselection field, i.e. with
\code{update_field_names()}
}
\keyword{internal}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/labelled.R
\name{make_labelled}
\alias{make_labelled}
\title{Apply variable labels to a REDCapTidieR supertibble}
\usage{
make_labelled(supertbl, format_labels = NULL)
}
\arguments{
\item{supertbl}{a supertibble generated using \code{read_redcap()}}

\item{format_labels}{one or multiple optional label formatting functions.
A label formatting function is a function that takes a character vector and
returns a modified character vector of the same length. This function is
applied to field labels before attaching them to variables. One of:
\itemize{
\item \code{NULL} to apply no additional formatting. Default.
\item A label formatting function.
\item A character with the name of a label formatting function.
\item A vector or list of label formatting functions or function names to be applied
in order. Note that ordering may affect results.
}}
}
\value{
A labelled supertibble.
}
\description{
Take a supertibble and use the \code{labelled} package to apply variable labels to
the columns of the supertibble as well as to each tibble in the
\code{redcap_data}, \code{redcap_metadata}, and \code{redcap_events} columns
of that supertibble.
}
\details{
The variable labels for the data tibbles are derived from the \code{field_label}
column of the metadata tibble.
}
\examples{
supertbl <- tibble::tribble(
  ~redcap_data, ~redcap_metadata,
  tibble::tibble(x = letters[1:3]), tibble::tibble(field_name = "x", field_label = "X Label"),
  tibble::tibble(y = letters[1:3]), tibble::tibble(field_name = "y", field_label = "Y Label")
)

make_labelled(supertbl)

make_labelled(supertbl, format_labels = tolower)

\dontrun{
redcap_uri <- Sys.getenv("REDCAP_URI")
token <- Sys.getenv("REDCAP_TOKEN")

supertbl <- read_redcap(redcap_uri, token)
make_labelled(supertbl)
}
}

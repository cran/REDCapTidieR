## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(httptest)
library(REDCapTidieR)

start_vignette("longitudinal_redcap")

# creds object is created in start-vignette.R which gets sourced when
# start_vignette runs
redcap_uri <- creds["REDCAP_URI"]
token <- creds["REDCAPTIDIER_LONGITUDINAL_API"]

library(dplyr)

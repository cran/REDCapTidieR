## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=!(Sys.getenv("NOT_CRAN") == "true"), include=FALSE-----------------
#  knitr::knit_exit()

## ---- include = FALSE---------------------------------------------------------
# Load credentials
redcap_uri <- Sys.getenv("REDCAP_URI")
superheroes_token <- Sys.getenv("SUPERHEROES_REDCAP_API")

## -----------------------------------------------------------------------------
library(REDCapTidieR)

## ---- eval=FALSE--------------------------------------------------------------
#  redcap_uri <- "https://my.institution.edu/redcap/api/"
#  token <- "123456789ABCDEF123456789ABCDEF04"
#  
#  my_redcap_data <- read_redcap(redcap_uri, token)
#  write_redcap_xlsx(my_redcap_data, file = "my_redcap_data.xlsx")

## -----------------------------------------------------------------------------
superheroes <- read_redcap(redcap_uri, superheroes_token)

superheroes |>
  rmarkdown::paged_table()

## ---- eval=FALSE--------------------------------------------------------------
#  superheroes |>
#    write_redcap_xlsx(file = "superheroes.xlsx")

## ---- eval=FALSE--------------------------------------------------------------
#  superheroes |>
#    make_labelled() |>
#    write_redcap_xlsx("superheroes-labelled.xlsx")

## ---- eval = FALSE------------------------------------------------------------
#  supertbl |>
#    write_redcap_xlsx(recode_logical = TRUE)


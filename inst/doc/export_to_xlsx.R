## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- include = FALSE---------------------------------------------------------
library(httptest)
# Make sure REDCapTidieR is loaded so httptest can find redact.R
library(REDCapTidieR)

# Use fake credentials if mocks exist, otherwise use real credentials to create mocks
fake <- dir.exists("export_to_xlsx")

creds <- REDCapTidieR:::get_credentials(
  c("REDCAP_URI", "SUPERHEROES_REDCAP_API", "REDCAPTIDIER_CLASSIC_API"),
  fake = fake
)

redcap_uri <- creds$REDCAP_URI
superheroes_token <- creds$SUPERHEROES_REDCAP_API
classic_token <- creds$REDCAPTIDIER_CLASSIC_API

start_vignette("export_to_xlsx")

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

## ---- include=FALSE-----------------------------------------------------------
end_vignette()


## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

library(httptest)

if (dir.exists("diving_deeper")) {
  # Make sure these match inst/misc/fake_credentials.csv
  redcap_uri <- "https://my.institution.edu/redcap/api/"
  superheroes_token <- "123456789ABCDEF123456789ABCDEF04"
  longitudinal_token <- "123456789ABCDEF123456789ABCDEF06"
  survey_token <- "123456789ABCDEF123456789ABCDEF01"
} else {
  redcap_uri <- Sys.getenv("REDCAP_URI")
  superheroes_token <- Sys.getenv("SUPERHEROES_REDCAP_API")
  longitudinal_token <- Sys.getenv("REDCAPTIDIER_DEEP_DIVE_VIGNETTE_API")
  survey_token <- Sys.getenv("REDCAPTIDIER_CLASSIC_API")
}

# Make sure REDCapTidieR is attached so start_vignette() can find start-vignette.R
library(REDCapTidieR)

start_vignette("diving_deeper")

## ---- include = TRUE, message = FALSE-----------------------------------------
superheroes_ugly <- REDCapR::redcap_read_oneshot(redcap_uri, superheroes_token)$data

superheroes_ugly |>
  rmarkdown::paged_table()

## -----------------------------------------------------------------------------
library(REDCapTidieR)

read_redcap(redcap_uri, superheroes_token) |>
  bind_tibbles()

heroes_information |>
  rmarkdown::paged_table()

## -----------------------------------------------------------------------------
super_hero_powers |>
  rmarkdown::paged_table()

## ---- include = TRUE----------------------------------------------------------
library(REDCapTidieR)

longitudinal <- read_redcap(redcap_uri, longitudinal_token)

longitudinal |>
  dplyr::select(redcap_form_name, redcap_form_label, structure) |>
  rmarkdown::paged_table()

## -----------------------------------------------------------------------------
longitudinal |>
  bind_tibbles()

demographics |>
  rmarkdown::paged_table()

## -----------------------------------------------------------------------------
chemistry |>
  rmarkdown::paged_table()

## -----------------------------------------------------------------------------
adverse_events |>
  rmarkdown::paged_table()

## -----------------------------------------------------------------------------
adverse_events$adverse_event_serious |>
  dplyr::glimpse()

## -----------------------------------------------------------------------------
adverse_events$adverse_event_grade

## -----------------------------------------------------------------------------
ae_grade <- adverse_events$adverse_event_grade

ae_grade |>
  factor(ordered = TRUE, levels = levels(ae_grade))

## -----------------------------------------------------------------------------
adverse_events |>
  dplyr::select(dplyr::starts_with("adverse_event_relationship_other___")) |>
  dplyr::glimpse()

## ---- warning = FALSE---------------------------------------------------------
survey <- read_redcap(redcap_uri, survey_token) |>
  extract_tibble("survey")

survey |>
  dplyr::glimpse()

## ---- include=FALSE-----------------------------------------------------------
end_vignette()


## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- include=FALSE-----------------------------------------------------------
library(httptest)

if (dir.exists("REDCapTidieR")) {
  # Make sure these match inst/misc/fake_credentials.csv
  redcap_uri <- "https://my.institution.edu/redcap/api/"
  token <- "123456789ABCDEF123456789ABCDEF04"
} else {
  redcap_uri <- Sys.getenv("REDCAP_URI")
  token <- Sys.getenv("SUPERHEROES_REDCAP_API")
}

# Make sure REDCapTidieR is attached so start_vignette() can find start-vignette.R
library(REDCapTidieR)

start_vignette("REDCapTidieR")

## -----------------------------------------------------------------------------
library(REDCapTidieR)
superheroes <- read_redcap(redcap_uri, token)

superheroes |>
  rmarkdown::paged_table()

## -----------------------------------------------------------------------------
superheroes_list <- superheroes |>
  extract_tibbles()

superheroes_list |>
  str(max.level = 1)

## -----------------------------------------------------------------------------
superheroes |>
  extract_tibbles(ends_with("powers")) |>
  str(max.level = 1)

## -----------------------------------------------------------------------------
superheroes |>
  extract_tibble("heroes_information") |>
  rmarkdown::paged_table()

## -----------------------------------------------------------------------------
lobstr::obj_size(superheroes)

## -----------------------------------------------------------------------------
superheroes |>
  bind_tibbles()

lobstr::obj_size(superheroes, heroes_information, super_hero_powers)

## -----------------------------------------------------------------------------
a <- superheroes |> extract_tibble("heroes_information")
b <- superheroes |> extract_tibbles()

lobstr::obj_size(superheroes, a, b)

## -----------------------------------------------------------------------------
superheroes |>
  make_labelled() |>
  bind_tibbles()

labelled::look_for(heroes_information)

## -----------------------------------------------------------------------------
superheroes |>
  make_labelled(format_labels = ~ gsub(":", "", .)) |>
  bind_tibbles()

labelled::look_for(heroes_information, "hero")

## -----------------------------------------------------------------------------
fmt_strip_trailing_colon("Hero name:")

## -----------------------------------------------------------------------------
superheroes |>
  make_labelled(
    format_labels = c(
      fmt_strip_trailing_colon,
      base::tolower
    )
  ) |>
  bind_tibbles()

labelled::look_for(heroes_information)

## ---- include=FALSE-----------------------------------------------------------
end_vignette()


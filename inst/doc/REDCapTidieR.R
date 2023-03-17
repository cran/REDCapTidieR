## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- include=FALSE-----------------------------------------------------------
library(httptest)
# Make sure REDCapTidieR is loaded so httptest can find redact.R
library(REDCapTidieR)

# Use fake credentials if mocks exist, otherwise use real credentials to create mocks
fake <- dir.exists("REDCapTidieR")

redcap_uri <- REDCapTidieR:::get_credentials("REDCAP_URI", fake = fake)[[1]]
token <- REDCapTidieR:::get_credentials("SUPERHEROES_REDCAP_API", fake = fake)[[1]]

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


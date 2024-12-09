## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=!(Sys.getenv("NOT_CRAN") == "true"), include=FALSE------------------
# knitr::knit_exit()

## ----include = FALSE----------------------------------------------------------
# Load credentials
redcap_uri <- Sys.getenv("REDCAP_URI")
token <- Sys.getenv("SUPERHEROES_REDCAP_API")

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

## -----------------------------------------------------------------------------
# Extract the heroes_information metadata tibble and add metadata
heroes_information_metadata <-
  superheroes |>
  add_skimr_metadata() |>
  dplyr::select(redcap_metadata) |>
  purrr::pluck(1, 1)

# Highlight the numeric summaries created by add_skimr_metadata()
heroes_information_metadata |>
  dplyr::select(field_name, skim_type:complete_rate, starts_with("numeric")) |>
  rmarkdown::paged_table()


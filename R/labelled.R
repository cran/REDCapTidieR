#' @title
#' Apply variable labels to a REDCapTidieR supertibble
#'
#' @description
#' Take a supertibble and use the `labelled` package to apply variable labels to
#' the columns of the supertibble as well as to each tibble in the
#' `redcap_data`, `redcap_metadata`, and `redcap_events` columns
#' of that supertibble.
#'
#' @details
#' The variable labels for the data tibbles are derived from the `field_label`
#' column of the metadata tibble.
#'
#' @param supertbl a supertibble generated using `read_redcap()`
#' @param format_labels one or multiple optional label formatting functions.
#' A label formatting function is a function that takes a character vector and
#' returns a modified character vector of the same length. This function is
#' applied to field labels before attaching them to variables. One of:
#' - `NULL` to apply no additional formatting. Default.
#' - A label formatting function.
#' - A character with the name of a label formatting function.
#' - A vector or list of label formatting functions or function names to be applied
#'   in order. Note that ordering may affect results.
#'
#' @return
#' A labelled supertibble.
#'
#' @examples
#' superheroes_supertbl
#'
#' make_labelled(superheroes_supertbl)
#'
#' make_labelled(superheroes_supertbl, format_labels = tolower)
#'
#' \dontrun{
#' redcap_uri <- Sys.getenv("REDCAP_URI")
#' token <- Sys.getenv("REDCAP_TOKEN")
#'
#' supertbl <- read_redcap(redcap_uri, token)
#' make_labelled(supertbl)
#' }
#' @export
make_labelled <- function(supertbl, format_labels = NULL) {
  check_installed("labelled", reason = "to use `make_labelled()`")

  formatter <- resolve_formatter(format_labels) # nolint: object_usage_linter

  check_arg_is_supertbl(supertbl)
  check_req_labelled_metadata_fields(supertbl)

  # Derive labels ----
  main_labels <- c(
    redcap_form_name = "REDCap Instrument Name",
    redcap_form_label = "REDCap Instrument Description",
    redcap_data = "Data",
    redcap_metadata = "Metadata",
    redcap_events = "Events and Arms Associated with this Instrument",
    structure = "Repeating or Nonrepeating?",
    data_rows = "# of Rows in Data",
    data_cols = "# of Columns in Data",
    data_size = "Data size in Memory",
    data_na_pct = "% of Data Missing",
    form_complete_pct = "% of Instrument Complete"
  )

  metadata_labels <- c(
    field_name = "Variable / Field Name",
    field_label = "Field Label",
    field_type = "Field Type",
    section_header = "Section Header Prior to this Field",
    select_choices_or_calculations = "Choices, Calculations, or Slider Labels",
    field_note = "Field Note",
    text_validation_type_or_show_slider_number = "Text Validation Type OR Show Slider Number",
    text_validation_min = "Minimum Accepted Value for Text Validation",
    text_validation_max = "Maximum Accepted Value for Text Validation",
    identifier = "Is this Field an Identifier?",
    branching_logic = "Branching Logic (Show field only if...)",
    required_field = "Is this Field Required?",
    custom_alignment = "Custom Alignment",
    question_number = "Question Number (surveys only)",
    matrix_group_name = "Matrix Group Name",
    matrix_ranking = "Matrix Ranking?",
    field_annotation = "Field Annotation"
  )

  ## Set some predefined labels for data fields that aren't in the metadata
  data_labels <- c( # nolint: object_usage_linter
    redcap_form_instance = "REDCap Form Instance",
    redcap_event_instance = "REDCap Event Instance",
    redcap_data_access_group = "REDCap Data Access Group",
    redcap_event = "REDCap Event",
    redcap_arm = "REDCap Arm",
    redcap_survey_timestamp = "REDCap Survey Timestamp",
    redcap_survey_identifier = "REDCap Survey Identifier",
    form_status_complete = "REDCap Instrument Completed?"
  )

  event_labels <- c(
    redcap_event = "Event Name",
    event_name = "Event Description",
    redcap_arm = "Arm Name",
    arm_name = "Arm Description",
    repeat_type = "Repeat Type"
  )

  # Define skimr labels ----

  skimr_labels <- make_skimr_labels()

  # Apply labels ----

  out <- supertbl

  # Label cols of each metadata tibble
  metadata_labels <- c(metadata_labels, skimr_labels)

  out$redcap_metadata <- map(
    out$redcap_metadata,
    .f = safe_set_variable_labels,
    labs = metadata_labels
  )

  # Label cols of each data tibble

  out$redcap_data <- map2(
    out$redcap_data,
    out$redcap_metadata,
    .f = ~ {
      # build labels from metadata + predefined labs
      labs <- c(.y$field_label, data_labels) %>%
        formatter()

      # Formatter may have wiped names so set them after
      names(labs) <- c(.y$field_name, names(data_labels))

      # set labs
      safe_set_variable_labels(.x, labs)
    }
  )

  # Label cols of each event tibble if present
  if ("redcap_events" %in% colnames(supertbl)) {
    out$redcap_events <- map(
      out$redcap_events,
      .f = safe_set_variable_labels,
      labs = event_labels
    )
  }

  # Label main cols
  # Do this last since map removes labels from columns we map over
  out <- safe_set_variable_labels(out, main_labels)

  out
}

#' @title
#' Format REDCap variable labels
#'
#' @description
#' Use these functions with the `format_labels` argument of
#' `make_labelled()` to define how variable labels should be formatted before
#' being applied to the data columns of `redcap_data`. These functions are
#' helpful to create pretty variable labels from REDCap field labels.
#'
#' - `fmt_strip_whitespace()` removes extra white space inside and at the start
#' and end of a string. It is a thin wrapper of `stringr::str_trim()` and
#' `stringr::str_squish()`.
#' - `fmt_strip_trailing_colon()` removes a colon character at the end of a string.
#' - `fmt_strip_trailing_punct()` removes punctuation at the end of a string.
#' - `fmt_strip_html()` removes html tags from a string.
#' - `fmt_strip_field_embedding()` removes text between curly braces `{}` which
#' REDCap uses for special "field embedding" logic. Note that `read_redcap()`
#' removes html tags and field embedding logic from field labels in the metadata
#' by default.
#'
#' @param x a character vector
#'
#' @return a modified character vector
#'
#' @examples
#'
#' fmt_strip_whitespace("Poorly Spaced   Label ")
#'
#' fmt_strip_trailing_colon("Label:")
#'
#' fmt_strip_trailing_punct("Label-")
#'
#' fmt_strip_html("<b>Bold Label</b>")
#'
#' fmt_strip_field_embedding("Label{another_field}")
#'
#' superheroes_supertbl
#'
#' make_labelled(superheroes_supertbl, format_labels = fmt_strip_trailing_colon)
#'
#' @name format-helpers
NULL

#' @rdname format-helpers
#' @export
fmt_strip_whitespace <- function(x) {
  x %>%
    str_squish() %>%
    str_trim()
}

#' @rdname format-helpers
#' @export
fmt_strip_trailing_colon <- function(x) {
  str_replace(x, ":$", "")
}

#' @rdname format-helpers
#' @export
fmt_strip_trailing_punct <- function(x) {
  str_replace(x, "[:punct:]$", "")
}

#' @rdname format-helpers
#' @export
fmt_strip_html <- function(x) {
  str_replace_all(x, "<.+?\\>", "")
}

#' @rdname format-helpers
#' @export
fmt_strip_field_embedding <- function(x) {
  str_replace_all(x, "\\{.+?\\}", "")
}

#' @title
#' Convert user input into label formatting function
#'
#' @param format_labels argument passed to \code{make_labelled}
#' @param env the environment in which to look up functions if
#' \code{format_labels} contains character elements. The default,
#' \code{caller_env(n = 2)}, uses the environment from which the user called
#' \code{make_labelled()}
#' @param call the calling environment to use in the error message
#'
#' @return a function
#'
#' @keywords internal
#'
resolve_formatter <- function(format_labels, env = caller_env(n = 2), call = caller_env()) {
  if (is.null(format_labels)) {
    # If NULL pass labels through unchanged
    return(identity)
  }
  if (is.function(format_labels)) {
    # If a single function then return it to apply to labels
    return(format_labels)
  }
  if (is_bare_formula(format_labels, lhs = FALSE)) {
    # If a one-sided formula convert to a function
    return(as_closure(format_labels))
  }
  if (is.list(format_labels) || is.character(format_labels)) {
    # If a list or character vector compose the functions into a function
    # that applies them in order

    # By default compose() converts character inputs to functions but we want
    # to convert them ourselves to ensure they're looked up in the right env
    fns <- map(format_labels, as_closure, env = env)
    return(compose(!!!fns, .dir = "forward"))
  }

  supported_classes <- c("NULL", "list", "function", "character") # nolint: object_usage_linter
  cli_abort(
    c(
      "!" = "{.arg format_labels} must be of class {.cls {supported_classes}}",
      "x" = "{.arg format_labels} is {.cls {class(format_labels)}}"
    ),
    class = c("unresolved_formatter", "REDCapTidieR_cond"),
    call = call
  )
}

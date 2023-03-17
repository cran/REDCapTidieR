
<!-- README.md is generated from README.Rmd. Please edit that file -->

# REDCapTidieR

<p align="center">

<img src="man/figures/REDCapTidieR.png" alt="REDCapTidieR hex logo" width="150" align="right"/>

</p>
<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/CHOP-CGTInformatics/REDCapTidieR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CHOP-CGTInformatics/REDCapTidieR/actions/workflows/R-CMD-check.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/REDCapTidieR)](https://CRAN.R-project.org/package=REDCapTidieR)
[![](https://cranlogs.r-pkg.org/badges/grand-total/REDCapTidieR)](https://cran.r-project.org/package=REDCapTidieR)
[![Codecov test
coverage](https://codecov.io/gh/CHOP-CGTInformatics/REDCapTidieR/branch/main/graph/badge.svg)](https://app.codecov.io/gh/CHOP-CGTInformatics/REDCapTidieR?branch=main)
[![OpenSSF Best Practices](https://bestpractices.coreinfrastructure.org/projects/6845/badge)](https://bestpractices.coreinfrastructure.org/projects/6845)
<!-- badges: end -->

The REDCapTidieR package provides an elegant way to
[import](https://chop-cgtinformatics.github.io/REDCapTidieR/articles/glossary.html#import)
data from a [REDCap](https://www.project-redcap.org/)
[project](https://chop-cgtinformatics.github.io/REDCapTidieR/articles/glossary.html#project)
into an R environment. It builds upon the
[REDCapR](https://ouhscbbmc.github.io/REDCapR/) package to query the
[REDCap
API](https://chop-cgtinformatics.github.io/REDCapTidieR/articles/glossary.html#redcap-api)
and then transforms the returned data into a set of
[tidy](https://chop-cgtinformatics.github.io/REDCapTidieR/articles/glossary.html#tidy)
[tibbles](https://chop-cgtinformatics.github.io/REDCapTidieR/articles/glossary.html#tibble).

REDCapTidieR is especially useful for dealing with complex REDCap
projects that are
[longitudinal](https://chop-cgtinformatics.github.io/REDCapTidieR/articles/glossary.html#longitudinal-project)
or include
[repeating](https://chop-cgtinformatics.github.io/REDCapTidieR/articles/glossary.html#repeating)
[instruments](https://chop-cgtinformatics.github.io/REDCapTidieR/articles/glossary.html#instrument)
or both.

## Installation

The release version can be installed from
[CRAN](https://cran.r-project.org/package=REDCapTidieR).

``` r
install.packages("REDCapTidieR")
```

You can install the development version of REDCapTidieR from
[GitHub](https://github.com/CHOP-CGTInformatics/REDCapTidieR):

``` r
devtools::install_github("CHOP-CGTInformatics/REDCapTidieR")
```

## Usage

Use `read_redcap()` together with `bind_tibbles()` to import data from
all instruments into your environment.

![Demonstration of using the `read_redcap()` and `bind_tibbles()`
functions](man/figures/redcaptidier-demo.gif)

Read the [Getting Started
vignette](https://chop-cgtinformatics.github.io/REDCapTidieR/articles/REDCapTidieR.html)
to learn more.

## Collaboration

We invite you to give feedback and collaborate with us! If you are
familiar with GitHub and R packages, please feel free to submit a [pull
request](https://github.com/CHOP-CGTInformatics/REDCapTidieR/pulls).
Please do let us know if REDCapTidieR fails for whatever reason with
your database and submit a bug report by creating a GitHub
[issue](https://github.com/CHOP-CGTInformatics/REDCapTidieR/issues).

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/CHOP-CGTInformatics/REDCapTidieR/blob/main/CONDUCT.md).
By participating you agree to abide by its terms.

We’d like to thank the following folks for their advice and code
contributions: [Will Beasley](https://github.com/wibeasley) and [Paul
Wildenhain](https://github.com/pwildenhain).

## Funding

This package was developed by the [Children’s Hospital of
Philadelphia](https://www.chop.edu) Cell and Gene Therapy Informatics
Team to support the needs of the [Cellular Therapy and Transplant
Section](https://www.chop.edu/centers-programs/cellular-therapy-and-transplant-section).
The development was funded using the following sources:

- *Stephan Kadauke Start-up funds.* Stephan Kadauke, PI, CHOP, 2018-2024

- *CHOP-based GMP cell manufacturing (MFG) for CAR T clinical trials*.
  Stephan Grupp, PI; Stephan Kadauke, co-PI, CHOP, 2021-2023

#' @importFrom methods is

set_country <- function(session, country) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(country) || nchar(country) != 3) {
    stop("Secondary argument must be an ISO3 country code")
  }

  session@countries <- c(country)
  return(session)
}

set_countries <- function(session, countries) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(countries)) {
    stop("Secondary argument must be a list of ISO3 country codes")
  }

  session@countries <- countries
  return(session)
}

set_countries_all <- function(session) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }

  session@countries <- ''
  return(session)
}

set_dataset <- function(session, dataset) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(dataset)) {
    stop("Secondary argument must be a dataset identifier")
  }

  session@dataset <- dataset
  return(session)
}

set_extrapolation_years_linear <- function(session, years) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.numeric(years)) {
    stop("Secondary argument must be numeric")
  }

  session@extrapolationYearsLinear <- years
  session@extrapolationYearsNearest <- 0
  return(session)
}

set_extrapolation_years_nearest <- function(session, years) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.numeric(years)) {
    stop("Secondary argument must be numeric")
  }

  session@extrapolationYearsLinear <- 0
  session@extrapolationYearsNearest <- years
  return(session)
}

set_indicator <- function(session, indicator) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(indicator)) {
    stop("Secondary argument must be an indicator identifier")
  }

  session@indicators <- c(indicator)
  return(session)
}

set_indicators <- function(session, indicators) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(indicators)) {
    stop("Secondary argument must be a list of indicator identifiers")
  }

  session@indicators <- indicators
  return(session)
}

set_interpolation <- function(session, state) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.logical(state)) {
    stop("Secondary argument must be logical")
  }

  session@interpolation <- state
  return(session)
}

set_levels <- function(session, levels) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.numeric(levels)) {
    stop("Secondary argument must be a list of level identifiers")
  }

  session@levels <- levels
  return(session)
}

set_year <- function(session, year) {
  if (is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.numeric(year)) {
    stop("Secondary argument must be numeric")
  }

  session@year <- year
  return(session)
}

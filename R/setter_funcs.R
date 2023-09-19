#' Set country to retrieve data for
#'
#' The country to retrieve GDL indicator data for.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param country
#' An ISO3 country code.
#'
#' @importFrom methods is
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' session <- set_country(session, 'IND')
set_country <- function(session, country) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(country) || nchar(country) != 3) {
    stop("Secondary argument must be an ISO3 country code")
  }

  session@countries <- c(country)
  return(session)
}

#' Set countries to retrieve data for
#'
#' The countries to retrieve GDL indicator data for.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param countries
#' A vector of ISO3 country codes.
#'
#' @importFrom methods is
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' # Customize parameters
#' session <- set_dataset(session, 'shdi')
#' session <- set_countries(session, c('BEL', 'LUX', 'NLD'))
set_countries <- function(session, countries) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(countries)) {
    stop("Secondary argument must be a list of ISO3 country codes")
  }

  session@countries <- countries
  return(session)
}

#' Set session to retrieve data for all available countries
#'
#' Switch the session to retrieve data for all available countries,
#' rather than a specific set of countries.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @importFrom methods is
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' session <- set_countries_all(session)
set_countries_all <- function(session) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }

  session@countries <- ''
  return(session)
}

#' Set session to retrieve data from a particular dataset
#'
#' Switch the session to retrieve data from the dataset specified.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param dataset
#' Dataset identifier (string)
#'
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' session <- set_dataset(session, 'shdi')
set_dataset <- function(session, dataset) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(dataset)) {
    stop("Secondary argument must be a dataset identifier")
  }

  session@dataset <- dataset
  return(session)
}

#' Set the number of years to extrapolate linearly.
#'
#' Sets the number of years to linearly extrapolate at dataset edges.
#' Turns extrapolation on if it isn't already. Overrides the number of
#' nearest years if set.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param years
#' Number of years to extrapolate (integer)
#'
#' @importFrom methods is
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' session <- set_extrapolation_years_linear(session, 3)
set_extrapolation_years_linear <- function(session, years) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.numeric(years)) {
    stop("Secondary argument must be numeric")
  }

  session@extrapolationYearsLinear <- years
  session@extrapolationYearsNearest <- 0
  return(session)
}

#' Set the number of years to fill out using nearest available data
#'
#' Sets the number of years to fill out using nearest available data
#' at dataset edges, as a means of extrapolation. Turns extrapolation on
#' if it isn't already. Overrides the number of years to linearly
#' extrapolate if set.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param years
#' Number of years to copy (integer)
#'
#' @importFrom methods is
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' session <- set_extrapolation_years_nearest(session, 3)
set_extrapolation_years_nearest <- function(session, years) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.numeric(years)) {
    stop("Secondary argument must be numeric")
  }

  session@extrapolationYearsLinear <- 0
  session@extrapolationYearsNearest <- years
  return(session)
}

#' Set the indicator to retrieve
#'
#' Sets the indicator to retrieve from the dataset.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param indicator
#' Indicator to retrieve (string)
#'
#' @importFrom methods is
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' session <- set_indicator(session, 'iwi')
set_indicator <- function(session, indicator) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(indicator)) {
    stop("Secondary argument must be an indicator identifier")
  }

  session@indicators <- c(indicator)
  return(session)
}

#' Set the indicators to retrieve
#'
#' Sets the indicators to retrieve from the dataset.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param indicators
#' Vector of indicators to retrieve (string)
#'
#' @importFrom methods is
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' session <- set_indicators(session, c('fridge', 'cellphone', 'tv'))
set_indicators <- function(session, indicators) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(indicators)) {
    stop("Secondary argument must be a list of indicator identifiers")
  }

  session@indicators <- indicators
  return(session)
}

#' Set interpolation state
#'
#' Turns interpolation on (T) or off (F).
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param state
#' Whether or not to use interpolation (boolean)
#'
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' session <- set_interpolation(session, TRUE)
set_interpolation <- function(session, state) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.logical(state)) {
    stop("Secondary argument must be logical")
  }

  session@interpolation <- state
  return(session)
}

#' Set data levels to retrieve data for
#'
#' Specify which data levels to retrieve data for.
#' A list of levels may be obtained through `gdl_levels`.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param levels
#' Vector of level identifiers (integers)
#'
#' @importFrom methods is
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' session <- set_levels(session, c(1,4))
set_levels <- function(session, levels) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.numeric(levels)) {
    stop("Secondary argument must be a list of level identifiers")
  }

  session@levels <- levels
  return(session)
}

#' Set year to retrieve data for
#'
#' Specify which year to retrieve data for.
#' Only used when retrieving multiple indicators at once.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param year
#' Year to retrieve data for (integer)
#'
#' @importFrom methods is
#' @export
#'
#' @examples
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' session <- set_year(session, 2021)
set_year <- function(session, year) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.numeric(year)) {
    stop("Secondary argument must be numeric")
  }

  session@year <- year
  return(session)
}

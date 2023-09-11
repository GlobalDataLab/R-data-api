library(httr2)

GDL_BASEURL <- "http://dev2.globaldatalab.org:8080"

# GDLSession class ----------------------------------------------------------------------------

# Introduce GDLSession class
setClass('GDLSession', slots=list(
  token="character",
  dataset="character",
  indicators="character",
  countries="character",
  year="numeric",
  interpolation="logical",
  extrapolationYearsLinear="numeric",
  extrapolationYearsNearest="numeric"
))

# Hide internals from simple print statements; just show the token used
setMethod('show', 'GDLSession', function(object) {
  cat("GDL Session Object (token = '", object@token, "')\n", sep="")
})

# Main session constructor and request function -----------------------------------------------

# Session object constructor function
gdl_session <- function(token) {
  session <- new('GDLSession',
    token = token,
    dataset = "areadata",
    indicators = c('iwi', 'phone', 'fridge'),
    year = 2021,
    interpolation = T,
    extrapolationYearsLinear = 0,
    extrapolationYearsNearest = 0
  )

  return(session)
}

# Data request function
gdl_request <- function(session) {
  if (class(session) != 'GDLSession') {
    stop("Argument must be a GDL Session Object")
  }

  # Set up a base API url
  url <- paste0(GDL_BASEURL, '/', session@dataset, '/download/')

  # Multiple indicators? Add the year
  if (length(session@indicators) > 1) {
    url <- paste0(url, session@year, '/')
  }

  # Indicators...
  url <- paste0(url, paste(session@indicators, collapse='+'), '/')

  # Countries?
  if (length(session@countries) > 0) {
    url <- paste0(url, paste(session@countries, collapse='+'), '/')
  }

  # Format and token...
  url <- paste0(url, '?format=csv&token=', session@token)

  # Interpolation
  url <- paste0(url, '&interpolation=', ifelse(session@interpolation, 1, 0))

  # Extrapolation
  if (session@extrapolationYearsLinear > 0) {
    url <- paste0(url, '&extrapolation=1&extrapolation_years=', session@extrapolationYearsLinear)
  } else if (session@extrapolationYearsNearest > 0) {
    url <- paste0(url, '&extrapolation=2&nearest_years=', session@extrapolationYearsNearest)
  }

  df <- gdl_request_csv(session, url)
  return(df)
}

# Internal function: perform and process CSV request by URL
gdl_request_csv <- function(session, url) {
  if (class(session) != 'GDLSession') {
    stop("Argument must be a GDL Session Object")
  }

  # Prepare request with error handling
  req <- request(url)
  req <- req_headers(req, "Accept" = "text/csv")
  req <- req_error(req, body=function(resp) {
    csv <- resp_body_string(resp)
    details <- read.csv(text=csv)
    return(c(details$title, details$body))
  })

  # Perform the request and return data frame
  resp <- req_perform(req)
  csv <- resp_body_string(resp)
  df <- read.csv(text=csv)
  return(df)
}

# Rerefence functions -------------------------------------------------------------------------

# List indicators
gdl_indicators <- function(session) {
  if (class(session) != 'GDLSession') {
    stop("Argument must be a GDL Session Object")
  }

  url <- paste0(GDL_BASEURL, '/', session@dataset, '/api/indicators/?token=', session@token)
  df <- gdl_request_csv(session, url)
  return(df)
}

# List countries
gdl_countries <- function(session) {
  if (class(session) != 'GDLSession') {
    stop("Argument must be a GDL Session Object")
  }

  url <- paste0(GDL_BASEURL, '/', session@dataset, '/api/countries/?token=', session@token)
  df <- gdl_request_csv(session, url)
  return(df)
}

# List regions
gdl_regions <- function(session, country) {
  if (class(session) != 'GDLSession') {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(country)) {
    stop("Secondary argument must be an ISO3 country code")
  }

  url <- paste0(GDL_BASEURL, '/', session@dataset, '/api/regions/?country=', country, '&token=', session@token)
  df <- gdl_request_csv(session, url)
  return(df)
}

# Setter functions ----------------------------------------------------------------------------

set_country <- function(session, country) {
  if (class(session) != 'GDLSession') {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(country) || nchar(country) != 3) {
    stop("Secondary argument must be an ISO3 country code")
  }

  session@countries <- c(country)
  return(session)
}

set_countries <- function(session, countries) {
  if (class(session) != 'GDLSession') {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(countries)) {
    stop("Secondary argument must be a list of ISO3 country codes")
  }

  session@countries <- countries
  return(session)
}

set_countries_all <- function(session) {
  if (class(session) != 'GDLSession') {
    stop("Primary argument must be a GDL Session Object")
  }

  session@countries <- ''
  return(session)
}

set_dataset <- function(session, dataset) {
  if (class(session) != 'GDLSession') {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(dataset)) {
    stop("Secondary argument must be a dataset identifier")
  }

  session@dataset <- dataset
  return(session)
}

set_extrapolation_years_linear <- function(session, years) {
  if (class(session) != 'GDLSession') {
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
  if (class(session) != 'GDLSession') {
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
  if (class(session) != 'GDLSession') {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(indicator)) {
    stop("Secondary argument must be an indicator identifier")
  }

  session@indicators <- c(indicator)
  return(session)
}

set_indicators <- function(session, indicators) {
  if (class(session) != 'GDLSession') {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(indicators)) {
    stop("Secondary argument must be a list of indicator identifiers")
  }

  session@indicators <- indicators
  return(session)
}

set_interpolation <- function(session, state) {
  if (class(session) != 'GDLSession') {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.logical(state)) {
    stop("Secondary argument must be logical")
  }

  session@interpolation <- state
  return(session)
}

set_year <- function(session, year) {
  if (class(session) != 'GDLSession') {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.numeric(year)) {
    stop("Secondary argument must be numeric")
  }

  session@year <- year
  return(session)
}
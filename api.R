library(httr2)

GDL_BASEURL <- "http://dev2.globaldatalab.org:8080"

# GDLSession class ----------------------------------------------------------------------------

# Introduce GDLSession class
setClass('GDLSession', slots=list(
  token="character",
  dataset="character",
  indicators="character",
  year="numeric",
  interpolation="logical",
  extrapolationYearsLinear="numeric",
  extrapolationYearsNearest="numeric"
))

# Hide internals from simple print statements; just show the token used
setMethod('show', 'GDLSession', function(session) {
  cat("GDL Session Object (token = '", session@token, "')\n", sep="")
})

# Main session constructor and request function -----------------------------------------------

# Session object constructor function
gdl_session <- function(token) {
  session <- new('GDLSession',
    token = "abcd",
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

  # Perform the request and return data frame
  req <- request(url)
  req %>% req_headers("Accept" = "text/csv")
  resp <- req_perform(req)
  csv <- resp_body_string(resp)
  df <- read.csv(text=csv)
  return(df)
}

# Setter functions ----------------------------------------------------------------------------

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
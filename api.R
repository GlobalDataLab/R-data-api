library(httr2)

GDL_BASEURL <- "http://dev2.globaldatalab.org:8080"

# Introduce a GDLSession class
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

# List indicators
gdl_indicators <- function(session) {
  if (class(session) != 'GDLSession') {
    stop("Argument must be a GDL Session Object")
  }

  url <- paste0(GDL_BASEURL, '/', session@dataset, '/api/indicators/?token=', session@token)
  df <- gdl_request_csv(session, url)
  return(df)
}

# List levels
gdl_levels <- function(session) {
  if (class(session) != 'GDLSession') {
    stop("Argument must be a GDL Session Object")
  }

  url <- paste0(GDL_BASEURL, '/', session@dataset, '/api/levels/?token=', session@token)
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

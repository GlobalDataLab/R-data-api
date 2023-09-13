#' Get indicator list
#'
#' Returns the list of indicators available in the current dataset.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @export
gdl_indicators <- function(session) {
  if (!is(session, GDLSession)) {
    stop("Argument must be a GDL Session Object")
  }

  url <- paste0(GDL_BASEURL, '/', session@dataset, '/api/indicators/?token=', session@token)
  df <- gdl_request_csv(session, url)
  return(df)
}

#' Get level list
#'
#' Returns a list of data levels available in the current dataset.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @export
gdl_levels <- function(session) {
  if (!is(session, GDLSession)) {
    stop("Argument must be a GDL Session Object")
  }

  url <- paste0(GDL_BASEURL, '/', session@dataset, '/api/levels/?token=', session@token)
  df <- gdl_request_csv(session, url)
  return(df)
}

#' Get country list
#'
#' Returns a list of countries available in the current dataset.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @export
gdl_countries <- function(session) {
  if (!is(session, GDLSession)) {
    stop("Argument must be a GDL Session Object")
  }

  url <- paste0(GDL_BASEURL, '/', session@dataset, '/api/countries/?token=', session@token)
  df <- gdl_request_csv(session, url)
  return(df)
}

#' Get region list
#'
#' Returns a list of regions available for a particular country.
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @param country
#' An ISO3 country code.
#'
#' @export
gdl_regions <- function(session, country) {
  if (!is(session, GDLSession)) {
    stop("Primary argument must be a GDL Session Object")
  }
  if (!is.character(country)) {
    stop("Secondary argument must be an ISO3 country code")
  }

  url <- paste0(GDL_BASEURL, '/', session@dataset, '/api/regions/?country=', country, '&token=', session@token)
  df <- gdl_request_csv(session, url)
  return(df)
}

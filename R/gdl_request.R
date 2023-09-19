#' @importFrom httr2 request req_headers req_error resp_body_string req_perform
#' @importFrom methods new is
#' @importFrom utils read.csv

GDL_BASEURL <- "https://globaldatalab.org"

#' Data request function
#'
#' @param session
#' A valid GDL session object to interface with.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' # Customize parameters
#' session <- set_indicator(session, 'iwi')
#' session <- set_country(session, 'IND')
#' # Finally, request the data from GDL
#' iwi_india <- gdl_request(session)
#' iwi_india[1:5, 3:8]
#' # (showing only the five rows and columns for illustrative purposes)
#' }
gdl_request <- function(session) {
  if (!is(session, GDLSession)) {
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

  # Levels?
  if (session@levels[1] != 0) {
    url <- paste0(url, '&levels=', paste(session@levels, collapse='+'))
  }

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
  if (!is(session, GDLSession)) {
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

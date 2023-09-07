library(httr2)

GDL_BASEURL <- "http://dev2.globaldatalab.org:8080"

token <- "abcd"
dataset <- "areadata"
indicators <- c('iwi')
year <- 2021
interpolation <- T
extrapolationYearsLinear <- 0
extrapolationYearsNearest <- 0

gdl_request <- function() {
  # Set up a base API url
  url <- paste0(GDL_BASEURL, '/', dataset, '/download/')

  # Multiple indicators? Add the year
  if (length(indicators) > 1) {
    url <- paste0(url, year, '/')
  }

  # Indicators...
  url <- paste0(url, paste(indicators, collapse='+'), '/')

  # Format and token...
  url <- paste0(url, '?format=csv&token=', token)

  # Interpolation
  url <- paste0(url, '&interpolation=', ifelse(interpolation, 1, 0))

  # Extrapolation
  if (extrapolationYearsLinear > 0) {
    url <- paste0(url, '&extrapolation=1&extrapolation_years=', extrapolationYearsLinear)
  } else if (extrapolationYearsNearest > 0) {
    url <- paste0(url, '&extrapolation=2&nearest_years=', extrapolationYearsNearest)
  }

  # Perform the request and return data frame
  req <- request(url)
  resp <- req_perform(req)
  csv <- resp_body_string(resp)
  df <- read.csv(text=csv)
  return(df)
}

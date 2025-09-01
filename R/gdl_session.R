#' GDLSession class
#'
#' @export
#' @exportClass GDLSession
GDLSession <- setClass('GDLSession', slots=list(
  token="character",
  dataset="character",
  indicators="character",
  countries="character",
  levels="numeric",
  year="numeric",
  interpolation="logical",
  extrapolationYearsLinear="numeric",
  extrapolationYearsNearest="numeric",
  transposition="logical"
))

#' GDLSession show function
#'
#' This is a user-friendly show function for the GDLSession class,
#' hiding internals from simple print statements.
#
#' @export
show.GDLSession <- setMethod('show', 'GDLSession', function(object) {
  cat("GDL Session Object (token = '", object@token, "')\n", sep="")
})

#' GDL session constructor
#'
#' Returns a new GDL session object
#'
#' @param token
#' A valid GDL API token, obtainable from GlobalDataLab.org
#'
#' @returns A GDL session object for the token with default indicators set.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Create a session using your API token (provided by environment here)
#' session <- gdl_session(Sys.getenv('GDL_API_TOKEN'))
#' }
gdl_session <- function(token) {
  session <- new('GDLSession',
                 token = token,
                 dataset = "wealth",
                 indicators = c('iwi', 'phone', 'fridge'),
                 levels = c(0),
                 year = 2021,
                 interpolation = T,
                 extrapolationYearsLinear = 0,
                 extrapolationYearsNearest = 0
  )

  return(session)
}

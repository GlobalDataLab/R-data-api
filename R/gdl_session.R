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
  extrapolationYearsNearest="numeric"
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
#' @export
gdl_session <- function(token) {
  session <- new('GDLSession',
                 token = token,
                 dataset = "areadata",
                 indicators = c('iwi', 'phone', 'fridge'),
                 levels = c(0),
                 year = 2021,
                 interpolation = T,
                 extrapolationYearsLinear = 0,
                 extrapolationYearsNearest = 0
  )

  return(session)
}
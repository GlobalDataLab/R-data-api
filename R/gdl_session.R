
# GDLSession class ----------------------------------------------------------------------------

#' GDLSession class
#'
#' @exportClass GDLSession
setClass('GDLSession', slots=list(
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

# Hide internals from simple print statements; just show the token used
setMethod('show', 'GDLSession', function(object) {
  cat("GDL Session Object (token = '", object@token, "')\n", sep="")
})

# Main session constructor and request function -----------------------------------------------

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

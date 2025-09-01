# gdldata

[![CRAN Status](https://www.r-pkg.org/badges/version/gdldata)](https://cran.r-project.org/package=gdldata)

Retrieve datasets from the Global Data Lab (GDL) website directly into R data frames.
Functions are provided to reference available options (indicators, regions, countries) as well.

## Prerequisites

To work with the gdldata package, an API access token is required. Such a token may be created
for free on the [Global Data Lab website](https://globaldatalab.org). Simply log in, go to 'My GDL',
and go to 'API Access'.

Note that, by default, GDL only allows one active token per user. However, for academic purposes,
this limit may be increased, e.g. to facilitate classroom settings.

## Installation

```R
# Install released version from CRAN
install.packages("gdldata")
```

```R
# Install development version from GitHub
devtools::install_github("GlobalDataLab/R-data-api")
```

## Usage

To get started, include the `gdldata` library:

```R
library(gdldata)
```

Then create a GDL session object using your personal API access token, e.g.:

```R
sess <- gdl_session("SUBSTITUTE-WITH-YOUR-ACCESS-TOKEN")
```

This session object can be used to build your next API request, and facilitates partial request reuse.
For example, we can use it to retrieve the [IWI](https://globaldatalab.org/iwi/) indicator for India:

```R
sess <- set_indicator(sess, 'iwi')
sess <- set_country(sess, 'IND')
iwi_india <- gdl_request(sess)
```

We can reuse the same session object to retrieve more data. For example, we reuse it to retrieve several
[SHDI](https://globaldatalab.org/shdi/) indicators for Belgium, Luxembourg, and The Netherlands:

```R
sess <- set_dataset(sess, 'shdi')
sess <- set_countries(sess, c('BEL', 'LUX', 'NLD'))
sess <- set_indicators(sess, c('healthindex', 'edindex', 'incindex'))
shdi_benelux <- gdl_request(sess)
```

### Using pipes instead

To reduce verbosity, popular pipe operators may be used as well. You can either use the built-in
pipe operator `|>` (R >= 4.1) or use the `%>%` operator from [`magrittr`](https://magrittr.tidyverse.org/)
as a substitute. Consider the following example:

```R
library(magrittr)

sess <- sess |>
    set_dataset('shdi') |>
    set_countries(c('BEL', 'LUX', 'NLD')) |>
    set_indicators(c('healthindex', 'edindex', 'incindex')) |>
shdi_benelux <- gdl_request(sess)
```

Note that we could prepend `gdl_session()` and append `gdl_request()` to the pipe chain as well.
However, to facilitate reuse of the session object, we recommend against this.

### Additional reference functions

The GDL database may be explored fully without having to fall back to browsing the website.
To this end, we provide the following reference functions:
```R
gdl_datasets(session)      # retrieves a list of available datasets
gdl_indicators(session)    # retrieves a list of indicators for the current dataset
gdl_levels(session)        # retrieves a list of aggregation levels
gdl_countries(session)     # retrieves a list of available countries
gdl_regions(session, iso3) # retrieves a list of regions in a particular country
```

## Contributing

We welcome bug reports and feature requests in our [issue tracker](https://github.com/GlobalDataLab/R-data-api)
on GitHub.

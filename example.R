source("api.R")

library(magrittr)

# Substitute the following line with a valid GDL token
# A token can be generated through 'My GDL' on GlobalDataLab.org
GDL_TOKEN <- "REPLACE-THIS-WITH-YOUR-TOKEN"

# Create a GDL session using the above token
# We can manipulate it using pipes to customize our request.
sess <- gdl_session(GDL_TOKEN) %>%
  set_country("IND") %>%
  set_dataset("shdi") %>%
  set_indicator("shdi")

# Retrieve data and store it in a data frame
df_shdi <- gdl_request(sess)

# A session can be reused to collect more data
sess <- sess %>% set_indicators(c('healthindex', 'edindex', 'incindex'))
df_indicators <- gdl_request(sess)
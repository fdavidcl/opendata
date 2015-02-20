# install.packages(httr)
library(httr)

get_data <- function(url) {
  filename <- tempfile()
  write.csv(content(GET(url)), filename)
  read.csv(filename)
}

parse_comma <- function(col) {
  as.numeric(sub(",", ".", col, fixed = TRUE))
}

to_numeric <- function(col) {
  if (is.factor(col))
    col <- as.character(col)

  parse_comma(col)
}

library(httr)

get_data <- function(url) {
  filename <- tempfile()
  write.csv(content(GET(url)), filename)
  read.csv(filename)
}

# install.packages('httr')
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

# Rendimiento UGR
rendimiento <- get_data("http://opendata.ugr.es/dataset/5334df3b-4a3d-4f80-b09f-7801f673057b/resource/403534ce-9135-4d60-9f8a-0ad035aceaf1/download/tasaderendimientoexitoyevaluacion.csv")

names(rendimiento)[2:6] <- c("Tipo", "Rama", "Rendimiento", "Exito", "Evaluacion")

rendimiento$Rendimiento <- to_numeric(rendimiento$Rendimiento)
rendimiento$Exito       <- to_numeric(rendimiento$Exito)
rendimiento$Evaluacion  <- to_numeric(rendimiento$Evaluacion)

summary(rendimiento)

plot(rendimiento$Rendimiento)




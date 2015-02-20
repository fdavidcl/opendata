# install.packages('httr')
library(httr)

get_data <- function(url) {
  filename <- tempfile()
  write.csv(content(GET(url)), filename)
  read.csv(filename)
}


# Rendimiento UGR
rendimiento <- get_data("http://opendata.ugr.es/dataset/5334df3b-4a3d-4f80-b09f-7801f673057b/resource/403534ce-9135-4d60-9f8a-0ad035aceaf1/download/tasaderendimientoexitoyevaluacion.csv")

names(rendimiento)[2] <- "Tipo"
names(rendimiento)[3] <- "Rama"
names(rendimiento)[4] <- "Rendimiento"
names(rendimiento)[5] <- "Exito"
names(rendimiento)[6] <- "Evaluación"

rendimiento$Rendimiento <- as.numeric(rendimiento$Rendimiento)
rendimiento$Exito       <- as.numeric(rendimiento$Exito)
rendimiento$Evaluación  <- as.numeric(rendimiento$Evaluación)
  
summary(rendimiento)

plot(rendimiento$Rendimiento)


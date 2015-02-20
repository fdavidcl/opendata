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
plot(rendimiento$Rendimiento ~ rendimiento$Rama, )
plot(rendimiento$Exito ~ rendimiento$Rama)


# Duración estudios UGR
duracion <- get_data("http://opendata.ugr.es/dataset/5334df3b-4a3d-4f80-b09f-7801f673057b/resource/b8a65ae8-4aa9-4910-8949-505ec649a48e/download/duracionmediadelosestudiostotaltitulacionesiso.csv")
summary(duracion)
View(duracion)

names(duracion)[3:12] <- c(
  "Titulacion","NumCursos",
  "NumEstudiantes0708","Media0708",
  "NumEstudiantes0809","Media0809",
  "NumEstudiantes0910","Media0910",
  "NumEstudiantes1011","Media1011")
n


# Citación de investigadores
citas <- get_data("http://opendata.ugr.es/dataset/62be6e13-0fd9-457c-a599-738a08be937b/resource/c985229e-f0a4-44b7-94d8-7744406397fd/download/investigadoresugrperfilgoogle.csv")

levels(citas$Rama.de.conocimiento) <- c("Biológicas", "Salud", "Exactas/Naturales", "Humanas/Artes", "Sociales/Jurídicas", "Ingeniería/Tecnología")
ramas <- unique(citas$Rama.de.conocimiento)
barplot(legend.text = ramas,
        height = sapply(ramas, function(r) sum(citas[citas$Rama.de.conocimiento == r, ]$Citas)),
        col = heat.colors(length(ramas)),
        main = "Citas por rama de conocimiento")

barplot(legend.text = ramas,
        height = sapply(ramas, function(r) mean(citas[citas$Rama.de.conocimiento == r, ]$Citas)),
        col = heat.colors(length(ramas)),
        main = "Media de citas por persona por rama de conocimiento")


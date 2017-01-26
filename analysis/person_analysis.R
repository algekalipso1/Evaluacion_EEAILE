#setwd("~/Documents/Person/language_improvement_analysis/gen1")
setwd("~/Documents/hard_drive/Personal/repessss/language_improvement_analysis/gen3")


d_stat = read.csv("gen1_dat.csv") # Nota: esta es gen1. "analysis of features" investiga gen2 y gen3.

head(d_stat)
colnames(d_stat)

d_stat[,1]

# Regresión para predecir: Calificaciones (#8), características lingüísticas, deserción, progreso, presencia de palabras técnicas, y uso adecuado de las palabras técnicas. (Andrés)
# Estadísticas relevantes para predecir lo anterior: 
#  Entidad.Federativa
#  Edad
#  Nivel.Educativo.Logrado
#  Institución.es..en.la.que.estudio
#  Carrera
#  Años.de.experiencia.en.la.docencia.de.inglés
#  Nivel.educativo.en.el.que.enseña
#  Pública.o.Privada
#  Nombre.del.tutor

# A predecir:
#  Mod.1.calificación.
#  Mod.2.calificación
#  Mod.3.calificación
# Y- más que nada- un promedio de los 3.

# Limpiar el dataframe:
# Transforma las variables de manera cuantitativa.
d_stat$Pública.o.Privada <- as.character(d_stat$Pública.o.Privada)
d_stat$pp <- d_stat$Pública.o.Privada
d_stat$pp[d_stat$pp == "Pública"] <- "pu"
d_stat$pp[d_stat$pp == "Privada "] <- "pr"
d_stat$pp[d_stat$pp == "Pública y privada" | d_stat$pp == "Pública y Privada"] <- "pp"
d_stat$pp[d_stat$pp != "pu" & d_stat$pp != "pr" & d_stat$pp != "pp"] <- "x"
d_stat$Sexo

# Edad:

d_stat$Edad

# Se quedaron:
d_stat$se_quedaron <- !is.na(as.numeric(as.character(d_stat$Mod.3.calificación)))
d_filt <- d_stat[d_stat$se_quedaron,]
d_filt$Mod.1.calificación. <- as.numeric(as.character(d_filt$Mod.1.calificación.))
d_filt$Mod.2.calificación <- as.numeric(as.character(d_filt$Mod.2.calificación))
d_filt$Mod.3.calificación <- as.numeric(as.character(d_filt$Mod.3.calificación))

d_stat$Mod.1.calificación.
d_stat$Mod.2.calificación
d_stat$Mod.3.calificación

d_stat$Nivel.educativo.en.el.que.enseña

# Crear promedio de calificaciones
d_filt$promedio <- (d_filt$Mod.1.calificación. + d_filt$Mod.2.calificación + d_filt$Mod.3.calificación)/3

# Regresiones
# Predecir si se quedaron:
summary(lm(se_quedaron ~ Nivel.educativo.en.el.que.enseña + Sexo + pp, data = d_stat))
# Remover los que no tienen edad para poder incluirlo como predictor.
d_stat <- d_stat[!is.na(d_stat$Edad),]
summary(lm(se_quedaron ~ Nivel.educativo.en.el.que.enseña + Sexo + pp + Edad, data = d_stat))


# Predecir Calificación
summary(lm(Mod.3.calificación ~ Mod.1.calificación. + Mod.2.calificación + Nivel.educativo.en.el.que.enseña + Sexo + pp, data = d_filt))
summary(lm(promedio ~ Nivel.educativo.en.el.que.enseña + Sexo + pp, data = d_filt))

# remueve los que no tienen edad
d_filt <- d_filt[!is.na(d_filt$Edad),]
summary(lm(promedio ~ Nivel.educativo.en.el.que.enseña + Sexo + pp + Edad, data = d_filt))



### Ahora para le generación 3:
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
d_stat3 <- read.csv("gen3_2014_03_27.csv")

# Primero cambia el formato
d_stat3$mod1_ac <- gsub(",", ".", d_stat3$Mod1.ass1..calificación..Thinking.about.what.you.teach.when.you.teach..English.Language..)
d_stat3$mod1_c <- gsub(",", ".", d_stat3$Mod1.pro.calificación.English.Language..Learning.Teaching..Constructingone.s.own.language.teaching.philosophy.)
d_stat3$mod2_c <- gsub(",", ".", d_stat3$Mod2.pro.calificación.Best.Practices.for.Developing.Language.Skills.in.the.English.Classroom)
d_stat3$mod3_c <- gsub(",", ".", d_stat3$Mod3.pro.calificación)
d_stat3$no_desertaron <- d_stat3$Calificación.de.actas.modulo.tres != "" & d_stat3$Calificación.de.actas.modulo.tres != "NP"

summary(lm(no_desertaron ~ genero,data = d_stat3))
summary(lm(no_desertaron ~ genero+ Nivel,data = d_stat3))
summary(lm(no_desertaron ~ genero+ Nivel+ Tutor,data = d_stat3))




d_stat3$c_uno <- as.numeric.factor(d_stat3$Calificación.de.actas.modulo.uno)
d_stat3$c_dos <- as.numeric.factor(d_stat3$Calificación.de.actas.modulo.dos)
d_stat3$c_tres <- as.numeric.factor(d_stat3$Calificación.de.actas.modulo.tres)

# Omito último renglón porque falta una calificación
d_stat3_subset <- d_stat3[d_stat3$no_desertaron,]
d_stat3_subset <- d_stat3_subset[1:44,]

d_stat3_subset$promedio <- as.numeric.factor(d_stat3_subset$Calificación.de.actas.modulo.uno) + as.numeric.factor(d_stat3_subset$Calificación.de.actas.modulo.dos) + as.numeric.factor(d_stat3_subset$Calificación.de.actas.modulo.tres)


summary(lm(promedio ~ genero, data = d_stat3_subset))
summary(lm(promedio ~ genero + Nivel, data = d_stat3_subset))
summary(lm(promedio ~ genero + Tutor, data = d_stat3_subset))

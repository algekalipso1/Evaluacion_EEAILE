setwd("~/Documents/Person/language_improvement_analysis/gen1")


d_stat = read.csv("gen1_dat.csv") # Nota: esta es gen1. "analysis of features" investiga gen2 y gen3.

head(d_stat)
col(d_stat)

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

# Limpiar el dataframe:
# Transforma las variables de manera cuantitativa.
d_stat$Pública.o.Privada
d_stat$pp <- d_stat$Sexo





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


# Regresiones
# Predecir si se quedaron:
summary(lm(se_quedaron ~ Nivel.educativo.en.el.que.enseña + Sexo, data = d_stat))

# Predecir Calificación
summary(lm(Mod.3.calificación ~ Mod.1.calificación. + Mod.2.calificación + Sexo, data = d_filt))
summary(glm(Mod.3.calificación ~ Nivel.educativo.en.el.que.enseña + Mod.1.calificación. + Mod.2.calificación, data = d_filt))


length(d_filt)


rm(list=ls())
setwd("~/Documents/graphs")

data=read.table("ine_estimaciones-y-proyecciones-de-población-1992-2050_base-2017_base-de-datos.csv",
                skip=1, sep = ";", header = TRUE, dec = ",")
data=subset(data, data[,2]!="" & data[,1]!="TOTAL" & data[,1]!="EDAD" )
data$sex=c(rep("Total",101),rep("Males",101),rep("Females",101))
data=reshape2::melt(data, id.vars = c("EDAD", "sex"))
data=subset(data, data$value!="")

names(data)=c("age","sex","year","pop")

data$age=as.numeric(gsub("\\+","",data$age))
data$year=as.numeric(gsub("X","",data$year))
data$pop=as.numeric(gsub("\\.","",data$pop))
data$pop2=ifelse(data$sex=="Males",-data$pop, data$pop)

# porcentaje
data$tramo=(data$age>=15 & data$age<30)
totales = aggregate(pop ~ year + sex, data = data, sum)
tramo = aggregate(pop ~ year + sex, data = subset(data, tramo), sum)
res = merge(tramo, totales, by = c("year","sex"), suffixes = c("_tramo","_total"))
res$por = 100 * res$pop_tramo / res$pop_total

data=merge(data,res,  by = c("year","sex"))
rm(tramo, totales, res)

data$label1=ifelse(data$age==22 & data$sex=="Males", paste0(round(data$por,1),"%"), NA)
data$label2=ifelse(data$age==22 & data$sex=="Females", paste0(round(data$por,1),"%"), NA)
# Paso 1: Reasignar valores válidos a alpha (entre 0 y 1)
data$alpha <- ifelse(data$tramo == TRUE, 0.9, 0.7)

# Paso 2: Crear el gráfico con los ajustes
library(ggplot2)

ggplot(subset(data, (year %in% c(2000, 2025, 2050)) & sex != "Total"), 
       aes(x = age, y = pop2, fill = sex, alpha = as.factor(alpha))) +
  geom_bar(stat = "identity") + 
  scale_y_continuous(labels = abs, limits = max(data$pop2) * c(-1, 1)) +
  coord_flip() +
  labs(title = "Pirámide Poblacional de 2025", x = "",y = "",fill = "Sexo",
       caption = "Fuente: Elaboración propia en base a datos del INE. @ox1_cl",
       subtitle="Según las proyecciones de población, el número de individuos en Chile entre 15 y 29 años supera los 4 millones, lo que representa\n el 19,9%. En el año 2000 este grupo correspondía al 24,8%, mientras que en 2050 se estima que alcanzará el 15,9%.") +
  theme_minimal() +
  scale_fill_manual(values = c("Males" = "darkslategray", "Females" = "olivedrab3")) +
  scale_alpha_manual(values = c("0.7" = 0.3, "0.9" = 1)) + # Controla la transparencia
  facet_wrap(~year) + 
  theme(legend.position = "none", text = element_text(family = "Candara", size = 13),
        plot.subtitle = element_text(size = 10)) +
  annotate('rect', xmin = 15, xmax = 29, ymin = -3.2e5, ymax = 3.2e5, alpha = 0.08, color = "grey40") +
  geom_text(aes(label = label1), family = "Candara", size = 6, fontface = "bold", color = "black", hjust = 1.2) +
  geom_text(aes(label = label2), family = "Candara", size = 6, fontface = "bold", color = "black", hjust = -0.2)

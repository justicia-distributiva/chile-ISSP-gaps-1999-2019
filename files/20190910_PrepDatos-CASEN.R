# Preparar datos CASEN 1999-2019------------------------------------

# año 2000 = isco88 = o8
# año 2009 = isco88 = c_o12
# año 2017 = isco88 = oficio4




library(sjlabelled)
library(here)
library(dplyr)

rm(list=ls())
# cs2000 <- read_stata(path = here("data","casen2000.dta"))
# cs2009 <- read_stata(path = here("data","casen2009.dta"))
# cs2017 <- read_stata(path = here("data","casen2017.dta"))

# save(cs2000,file = here("data","casen2000.RData"))
# save(cs2009,file = here("data","casen2009.RData"))
# save(cs2017,file = here("data","casen2017.RData"))

load(file = here("data","casen2000.RData"))
load(file = here("data","casen2009.RData"))
load(file = here("data","casen2017.RData"))

names(cs2000)
names(cs2009)
names(cs2017)

# Seleccionar variables de ocupacion e ingresos ---------------------------

dat00 <- cs2000 %>% select(oficio=o8,ytotaj)
dat09 <- cs2009 %>% select(oficio=c_o12,ytotaj)
dat17 <- cs2017 %>% select(oficio=oficio4,ytot)



table(dat00$ytotaj)


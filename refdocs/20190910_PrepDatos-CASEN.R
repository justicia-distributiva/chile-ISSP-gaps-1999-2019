# Preparar datos CASEN 1999-2019------------------------------------

# año 2000 = isco88 = o8
# año 2009 = isco88 = c_o12
# año 2017 = isco88 = oficio4




library(sjlabelled)
library(dplyr)
library(survey)

rm(list=ls())
# cs2000 <- read_stata(path = here("data","casen2000.dta"))
# cs2009 <- read_stata(path = here("data","casen2009.dta"))
# cs2017 <- read_stata(path = here("data","casen2017.dta"))

# save(cs2000,file = here("data","casen2000.RData"))
# save(cs2009,file = here("data","casen2009.RData"))
# save(cs2017,file = here("data","casen2017.RData"))

load(file = "data/casen2000.RData")
load(file = "data/casen2009.RData")
load(file = "data/casen2017.RData")

names(cs2000)
names(cs2009)
names(cs2017)

# Seleccionar variables de ocupacion e ingresos ---------------------------

dat00 <- cs2000 %>% select(oficio=o8,inctotal=ytotaj,estrato,expr,expc,sexo) %>% as.data.frame()
dat09 <- cs2009 %>% select(oficio=c_o12,inctotal=ytotaj,estrato,expr_p,expp_p,sexo) %>% mutate(er=is.na(expr_p)) %>% filter(er==FALSE) %>% select(-er)
dat17 <- cs2017 %>% select(oficio=oficio4,inctotal=ytot,expr,expc,varstrat,sexo)

# Declarar diseño muestral CASEN año 2000
svy00 <- svydesign(ids = ~1,strata = ~estrato,weights=~expr,data = dat00)

survey::svymean(x = dat00$inctotal,design=svy01, na.rm=TRUE)

prop.table(svytable(formula = ~ sexo,design=svy01))
margin.table(svytable(formula = ~sexo,design=svy01))

# Declarar diseño muestral CASEN año 2009
svy09 <- svydesign(ids = ~1,strata = ~estrato,weights=~expr_p ,data = dat09)

survey::svymean(x = dat09$inctotal,design=svy09, na.rm=TRUE)

prop.table(svytable(formula = ~ sexo,design=svy09))
margin.table(svytable(formula = ~sexo,design=svy09))


# Declarar diseño muestral CASEN año 2017
svy17 <- svydesign(ids = ~1,strata = ~varstrat,weights=~expr ,data = dat17)

survey::svymean(x = dat17$inctotal,design=svy17, na.rm=TRUE)
prop.table(svytable(formula = ~ sexo,design=svy17))


# Seleccionar ocupaciones -------------------------------------------------

db00 <- dat00 %>% filter(oficio %in% c(1210,1231,121)) # Corporate managers only
db09 <- dat09 %>% filter(oficio %in% c(1210,1231,121)) # Corporate managers only
db17 <- dat17 %>% filter(oficio %in% c(1210,1231,121)) # Corporate managers only

svger01 <- svydesign(ids = ~1,strata = ~estrato,weights=~expr,data = db00)
survey::svymean(x = db00$inctotal,design=svger01, na.rm=TRUE)

summary(db00$inctotal)
summary(db09$inctotal)
summary(db17$inctotal)





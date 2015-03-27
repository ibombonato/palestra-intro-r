install.packages("sqldf")
library(sqldf)
df <- mtcars
#Caso tenha instalado o RMySQL, pode dar conflito ao tentar ler um dataset,
# pois o sqldf tenta usar ele como driver padrao. Podemos corrigir com:
# paramatro "drv='SQLLite' ou
# options(sqldf.driver = "SQLite") # as per FAQ #7 force SQLite

# No MAC parece que o comando é: 
# options(gsubfn.engine = "R") # as per FAQ #5 use R code rather than tcltk

#Filtro: somente 8 cilindros
sqldf("select * from df where cyl == 8")

#sqldf("select * from df where cyl == 8", drv='SQLite')
#OU:
#options(sqldf.driver = "SQLite") # as per FAQ #7 force SQLite

#Select: somente mpg, cyl e hp
sqldf("select mpg, cyl, hp from df")

#Select com Rename
sqldf("select mpg as MilesPerGallon, cyl as Cylinders, hp as HorsePower from df")

#Adicionar coluna
sqldf("select *, (gear + carb) as GearMaisCarb from df")

# Reordenar
sqldf("Select * from df order by mpg desc, hp, cyl desc")

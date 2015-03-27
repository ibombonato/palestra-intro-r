#dplyr:
## select: return a subset of cols
## filter: return a subset of rows
## arrange: reorder rows
## rename: rename variables in a data frame
## mutate: add new variables/cols or transform existing variables
## summarize: generate summary stats of diff variables, possibly w/in strata

#"Functional", ou seja, as funções, sempre retonam um novo dataframe, 
# ao inves de modificar o existente
#Primeiro argumento é o dataframe e os outros o que fazer e quais colunas usar
# nao precisa do $ no nome, apenas o nome da coluna
install.packages("dplyr")

df <- mtcars
?mtcars
library(dplyr)

#Filtro: somente 8 cilindros
df[df$cyl == 8, ]
#dplyr
filter(df, cyl == 8)


#Select: somente mpg, cyl e hp
df[,c(1,2,4)]

#dplyr
select(df, mpg, cyl, hp)
#Já com rename
select(df, MilesPerGallon = mpg, Cylinders = cyl, HorsePower = hp)


#Rename
names(df)
colnames(df)[1] <- "mpg2"
names(df)

i <- which(colnames(df) == "mpg2")
colnames(df)[i] <- "mpg"
names(df)

#dplyr
rename(df, mpg2 = mpg)


#Adicionar coluna
df$GearMaisCarb <- df$gear + df$carb
head(df)

#dplyr
df <- mutate(df, GearMaisCarb = gear + carb)
head(df)


# Reordenar
df[order(-df$mpg, df$hp, -df$cyl),]

#dplyr
arrange(df, desc(mpg), hp, desc(cyl))
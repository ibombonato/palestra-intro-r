#dplyr:
# arrange
# filter
# select
# mutate
# rename
#summarise

#"Functional", ou seja, as funções, sempre retonam um novo dataframe, 
# ao inves de modificar o existente
#Primeiro argumento é o dataframe e os outros o que fazer e quais colunas usar
# nao precisa do $ no nome, apenas o nome da coluna
install.packages("dplyr")
library(dplyr)





## Managing dataframes with dplyr
## It's basically plyr but better, more optimized
## Provides verbs for data manipulation

## dplyr verbs
## select: return a subset of cols
## filter: return a subset of rows
## arrange: reorder rows
## rename: rename variables in a data frame
## mutate: add new variables/cols or transform existing variables
## summarize: generate summary stats of diff variables, possibly w/in strata

## dplyr properties
## first argument is a DF
## subsequent args describe what to do with it, and you can refer to cols in the DF directly w/out using the $ 
## the result is a new DF

## Look up col names
library(dplyr)
names(iris)
library(datasets)
head(iris)

## Subset certain cols using select()
head(select(iris, Sepal.Length:Petal.Length))
## Subset all but certain cols
head(select(iris, -(Sepal.Length:Petal.Length)))

## Subset rows based on conditions using filter ()
big_iris <- filter(iris, Petal.Width > 1)
head(big_iris)
big_iris2 <- filter(iris, Petal.Width > 1, Species=="virginica")
head(big_iris2)
#POde usar & ou virgula como "where"
head(filter(iris, Petal.Width > 1 & Species=="virginica"))

## Reorder rows of DF based on values of a column using arrange(), 
# first in ascending then in descending order
by_species <- arrange(iris, Species)
head(by_species)
tail(by_species)
by_species <- arrange(iris, desc(Species))
head(by_species)
tail(by_species)

## Rename vars using rename()
## rename(df, newName = oldName, newName2 = oldName2 ...)
iris <- rename(iris, Slength=Sepal.Length, Swidth=Sepal.Width)
head(iris)

## Transform or create new vars with mutate
# Here create new var that is the
# Slength value minus the mean of Slength
iris <- mutate(iris, Slength_adjusted=Slength-mean(Slength, na.rm=TRUE))
head(iris)
## Compare original var with new var
head(select(iris, Slength, Slength_adjusted))

## Split DF according to certain categorical vars and get summary stats 
## (remember to set na.rm=T in each function, if you have NA's)
by_species <- group_by(iris, Species)
head(by_species)
## Podemos definir qual funcao será utilizada no sumario, neste caso é o mean, max e median
# nestas novas colunas que criamos para o sumario acg_Slength, max_Swidth...
summary_table <- summarise(by_species, max_Swidth=max(Sepal.Width))
summary_table

## Special operator that "chains" diff operations together that make code more readable 
## It's called the pipeline operator, because you take one dataset, feed it thru pipeline of diff ops, 
## and returns final dataset; prevents you from having to create a bunch of temp variables to feed into functions
## Here, create a new variable based on the value of Slength_adjusted, and then group by it
head(iris)
##Cria uma variavell nova, já utiliza ela no group by e jah faz o sumario na mesma chamada,
# utilizando o DF inicial
iris %>% mutate(Slength_size=factor(1 * (Slength_adjusted>0), labels=c("little", "big"))) %>% group_by(Slength_size) %>% summarize(avg_Slength=mean(Slength, na.rm=T), max_Swidth=max(Swidth), med_Plength=median(Petal.Length))

## Other benefits
## dplyr can work with other data frame "backends"
## data.table for large fast tables
## SQL interface for relational databases via the DBI
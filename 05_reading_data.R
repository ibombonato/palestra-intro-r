#########################################
## MySQL
#########################################
install.packages("RMySQL")
library(RMySQL)

hg19 <- dbConnect(MySQL(),user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")

## dbGetQuery executa a query na hora da chamada
dbGetQuery(hg19, "select count(*) from affyU133Plus2 where misMatches = 1")

## dbSendQuery, monta a query, mas não executa
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
#É preciso utilizar fecth, para executar a query
results <- fetch(query); 
#Podemo fazer um "Take" no fetchm passando n=X
## Importante utilizar o dbClearResult após terminar de buscar seus dados com o dbSendQuery+Fetch
## Caso contrario,a query continua na memoria do server por algum tempo.
resultsTake <- fetch(query,n=10); 
dbClearResult(query);

## Muito importante: SEMPRE FECHAR A CONEXAO!
dbDisconnect(hg19);

head(results)
str(results)
rm(list = ls())


#########################################
## Reading from Web (Crawller)
#########################################
#Lendo o HTML de um site
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

#Utilizando XML parse para filtrar dados especificos:
install.packages("XML")
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
browseURL(url)
html <- htmlTreeParse(url, useInternalNodes=T)

#Parseando o HTML com o xpathSApply
xpathSApply(html, "//title", xmlValue)
#Parseando o HTML com o xpathSApply
xpathSApply(html, "//a[@class='gsc_a_ac']", xmlValue)


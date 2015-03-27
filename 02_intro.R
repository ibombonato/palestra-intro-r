#Rodar a linha: CTRL + ENTER
#Limpar o console: CTRL + L

#HELP
?mean
??mean
help("mean")

#Informações do working directory
getwd()
setwd("C:/Users/icaro.MINHAVIDA/Source/Repos/palestra-intro-r")
setwd("C:\\Users\\icaro.MINHAVIDA\\Source\\Repos\\palestra-intro-r")

# Manipulando arquivos:
list.files()

if(!file.exists("./data")){
    dir.create("./data")
}

file.remove("./data")
unlink("./data", recursive = TRUE)

# Environment
ls()
x <- c(1:10)
ls()
rm(x)
x
x <- c(1:10)
y <- c(30:50)
ls()
rm(list = ls())

# Variaveis randomicas
x <- rnorm(10)
x

# Vetores/DataFrame
a <- c(sample(letters[1:10], 20, replace = TRUE))
b <- c(1:20)
c <- rnorm(20)

df <- data.frame(Letras = a, Numeros = b, Randomicos = c)

head(df)
tail(df)
str(df)
summary(df)
unique(a)
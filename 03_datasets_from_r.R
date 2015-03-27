#Datasets proprios do R
library(datasets)
?datasets
library(help = "datasets")
data(mtcars)
?mtcars

head(mtcars)
str(mtcars)
summary(mtcars)

#Plots
# Grafico de peso x miles per gallon
plot(mtcars$wt, mtcars$mpg)
abline(h = mean(mtcars$mpg), lty=2)
title("MPG x Weight")

attach(mtcars)
plot(wt, mpg)
abline(h = mean(mpg), lty=2)
title("MPG x Weight")
detach(mtcars)

#Instalando e dando load em pacotes
install.packages("dplyr")
library(dplyr)
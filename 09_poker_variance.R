
# browseURL("http://www.blackrain79.com/2014/06/good-win-rates-for-micro-and-small_6.html")
# browseURL("http://www.blackrain79.com/2014/10/how-much-do-poker-players-make.html")
#
# Alguns fatos:
#
# 70 hands per table x 12 tables = 840 hands per hour.
# 
# And this would be 4200 hands per day.
# 
# 840 hands per hour x 5 hours = 4200 hands per day.
# 
# If you play 24 days in a month (so that you have a day or two off every week) then you will still hit your 100k hands a month just fine.
# 
# 4200 hands x 24 days = 100800 hands per month.

########
install.packages("zoo")
require(zoo)
simularVariancia <- function(winrate, sd){
    all <- data.frame()
    allz <- zoo(all)
    for(i in 1:50){
        #Gerar 1000 variaveis randomicas baseado na winrate e standard deviation
        #plot(rnorm(1000, 0.08, 0.957))
        #plot(cumsum(rnorm(1000, 0.08, 0.957)))
        n <- data.frame(X = cumsum(rnorm(1000, winrate, sd)))
        nz <- zoo(n)        
        allz <- cbind(allz, nz)
    }
    allz
}
gerarGraficoVariancia <- function(x){
    plot(x, type = "l", plot.type = "single", col = 1:ncol(x))
    abline(h = 0, lwd = 2)
    abline(h = rowMeans(x[nrow(x),]), lty = 2, lwd = 2)    
}

gerarTotais <- function(x){
    totals = t(x[nrow(x),])
    print(summary(totals))
    totals
}

#TOP NL25 (9-17 tables): 8bb/100
data <- simularVariancia(0.08, 0.842)
gerarGraficoVariancia(data)
totais <- gerarTotais(data)
#Lucro esperado = Media de buy-ins ~80: 80 * 25 = $2000
boxplot(totais)
#Change de terminar um mês negativo
mean(totais < 0)


#Media NL25 (9-17 tables): 2bb/100
data <- simularVariancia(0.02, 0.842)
gerarGraficoVariancia(data)
totais <- gerarTotais(data)
#Lucro esperado = Media de buy-ins ~17: 17 * 25 = $425
boxplot(totais)
#Change de terminar um mês negativo
mean(totais < 0)


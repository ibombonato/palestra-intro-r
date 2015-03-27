#Download de URL
if(!file.exists("./data")){
    dir.create("./data")
}

fileUrl <- "http://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, "./data/baltimore.csv")

data <- read.table("data/baltimore.csv")
data <- read.table("data/baltimore.csv", sep=",")
data <- read.table("data/baltimore.csv", sep=",", header = TRUE)
#Read table, le diversos tipos de arquivo, não somente .csv
?read.table

data <- read.csv("data/baltimore.csv")

head(data)
str(data)
data <- read.csv("data/baltimore.csv", stringsAsFactors = FALSE)
str(data)
View(data)
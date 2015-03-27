## When called this function will download and extract the data for your working directory
downloadAndEXtractData <- function(){
    fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileUrl, "EPA_NEI.zip")
    unzip("EPA_NEI.zip")
}

## Calling the function to get the data from web
## You can skip this step if the files "summarySCC_PM25.rds" and "Source_Classification_Code.rds"
## are already in your working directory
downloadAndEXtractData()

## Loading the dplyr package
library(dplyr)

## Reading the .rds file. This will likely take a few seconds...
NEI <- readRDS("summarySCC_PM25.rds")

## Subsettings just the PM2.5 Emissions and Year
df <- select(NEI, Emissions, year)

## Grouping and sum the data by year
data <- dplyr::group_by(df, year) %>% dplyr::summarise_each(funs(sum))

## Divide the emission by 1000 to make the plot more readable
data$Emissions <- data$Emissions/1000

# Open the PNG graphics device to create a png file
png(filename = "plot1.png")

##Plot the data
barplot(data$Emissions, names = data$year, 
        xlab = "Year", 
        ylab = "Total emission of PM2.5 (tons/1000)", 
        main = "PM2.5 emission decreased from 1999 to 2008")

#Closing the graphic device
dev.off()





## Filtering data from Baltimore City, Maryland (fips == "24510")
df <- dplyr::filter(NEI, fips == "24510")

## Subsettings just the PM2.5 Emissions and Year
df <- dplyr::select(df, Emissions, year)

## Grouping and sum the data by year
data <- dplyr::group_by(df, year) %>% dplyr::summarise_each(funs(sum))

##Plot the data
barplot(data$Emissions, names = data$year, 
        xlab = "Year", 
        ylab = "Total emission of PM2.5 (tons)", 
        main = "PM2.5 emission from 1999 to 2008 in Baltimore City")




library(ggplot2)

## Subsettings just the PM2.5 Emissions, year and type
df <- dplyr::select(NEI, Emissions, year, type, fips)

## Filtering data from Baltimore City, Maryland (fips == "24510")
df <- dplyr::filter(df, fips == "24510")

## Converting variables to factor
df$type <- as.factor(df$type)
df$year <- as.factor(df$year)

## Subsettings just the PM2.5 Emissions, year and type
df <- dplyr::select(df, Emissions, year, type)

## Grouping and sum the data by year and type in Baltimore
df <- dplyr::group_by(df, year, type) %>% dplyr::summarise_each(funs(sum))

#Plot four graphics, one for each type to answer the question 
ggplot(df, aes (x = year, y = Emissions, colour = year, fill = year)) +
    geom_bar(stat = "identity", position=position_dodge()) +
    facet_grid(.~type) + 
    labs(y = "Total emission of PM2.5 (tons)", x = "year") +
    labs(title = "PM2.5 Emission in Baltimore City by type and year")




SCC <- readRDS("Source_Classification_Code.rds")

## Subsettings just the PM2.5 Emissions, year, type and SCC
df <- dplyr::select(NEI, Emissions, year, SCC)

## Converting variables to factor
df$year <- as.factor(df$year)
df$SCC <- as.factor(df$SCC)

# Filter SCC by Coal
coalSCC <- dplyr::select(SCC, SCC, Short.Name)
coalSCC <- dplyr::filter(coalSCC, grepl("Coal", Short.Name, ignore.case = TRUE, fixed = FALSE))

## Inner Join df with coalSCC, so, only rows that matches SCC will stay in df
df <- dplyr::inner_join(df, coalSCC)

## Subsettings just the PM2.5 Emissions and Year
df <- dplyr::select(df, Emissions, year)

## Grouping and sum the data by year
df <- dplyr::group_by(df, year) %>% dplyr::summarise_each(funs(sum))

##Plot the data
ggplot(df, aes (x = year, y = Emissions/100)) +
    geom_bar(stat = "identity", position=position_dodge()) +
    labs(y = "Total emission of PM2.5 (tons/100)", x = "year") +
    labs(title = "PM2.5 Emission from Coal Related in United States")





## Subsettings just the PM2.5 Emissions, year, SCC and fips
df <- dplyr::select(NEI, Emissions, year, SCC, fips)

## Converting variables to factor
df$year <- as.factor(df$year)
df$SCC <- as.factor(df$SCC)

## Filtering data from Baltimore City and Los Angeles County
df <- dplyr::filter(df, (fips == "24510" | fips == "06037"))
## Label the fips
df$fips <- factor(df$fips, levels = c("06037", "24510"), 
                  labels = c("Los Angeles County", "Baltimore City"))

# Filter SCC by Vehicles
# We don't have a codebook to know exactly what a Motor Vehicle is, so based on the class discussion board
# I decided to filter by the word "veh", since the goal of the project, 
# is to know how to subset and filter data
vehicleSCC <- dplyr::select(SCC, SCC, Short.Name)
vehicleSCC <- dplyr::filter(vehicleSCC, grepl("veh", Short.Name, ignore.case = TRUE, fixed = FALSE))

## Inner Join df with vehicleSCC, so, only rows that matches SCC will stay in df
df <- dplyr::inner_join(df, vehicleSCC)

## Subsettings just the PM2.5 Emissions, Year and Fips
df <- dplyr::select(df, Emissions, year, fips)

## Grouping and sum the data by year and fips
df <- dplyr::group_by(df, year, fips) %>% dplyr::summarise_each(funs(sum))

##Plot the data with appropriate labels
ggplot(df, aes (x = year, y = Emissions, fill = fips)) +
    geom_bar(stat = "identity", position=position_dodge()) +
    labs(y = "Total emission of PM2.5 (tons)", x = "year") +
    labs(title = "PM2.5 Emissions for Baltimore City and Los Angeles County")

library(ggplot2)

#Data files are stored in /DATA/ folder
#Data files are stored in /DATA/ folder
#No need to read if it has already been read
if (!exists("NEI")) {
    NEI <- readRDS("./data/summarySCC_PM25.rds") 
}
if (!exists("SCC")) {
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}


#set device to plot into a PNG file
png("Plot1.png")

totalEmissions <- aggregate(NEI$Emissions, list(year = NEI$year), sum)
plot(totalEmissions$year, totalEmissions$x, type='l', ylab = "Emissions PM2.5(tons)", xlab = "Year",
     main = "Total PM2.5 emission from all sources")

##Alternate bar plot
#barplot(totalEmissions$x, names.arg = totalEmissions$year, ylab = "Emissions PM2.5 (tons)", xlab = "Year", 
#        main = "Total PM2.5 emission from all sources")

#Close the device
dev.off()
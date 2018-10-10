#Load libraries
library(ggplot2)
#Data files are stored in /DATA/ folder
#No need to read if it has already been read
if (!exists("NEI")) {
    NEI <- readRDS("./data/summarySCC_PM25.rds") 
}
if (!exists("SCC")) {
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}

#Select only the coal SCC data, easier to workwith
coal_sdata <- SCC[grep("Coal",SCC$EI.Sector),]

#Also, select only the coal NEI data
coal_ndata <- NEI[NEI$SCC %in% coal_sdata$SCC,]

# aggregate total emissions by year
coal_tot <- aggregate(Emissions~year, data=coal_ndata, sum)

#set device to plot into a PNG file
png(filename = "plot4.png")

# construct plot
plot <- ggplot(coal_tot, aes(x=factor(year), y=Emissions, fill = Emissions)) +
    geom_bar(stat="identity") +
    labs(title = "Total Coal Emissions(PM2.5) in US (1999-2008)",
         x = "Year", y = "Emissions PM2.5 (tons)")
print(plot)

#Close the device
dev.off()
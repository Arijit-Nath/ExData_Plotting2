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
#Select only Vehicle data from SCC
veh_sdata <- SCC[grep("Vehicle",SCC$EI.Sector),]

#Also, select Vehicle data from NEI
balt_data <- NEI[NEI$fips == "24510",]
veh_ndata <- balt_data[(balt_data$SCC %in% veh_sdata$SCC),]

# aggregate total emissions by year
bltm_veh_tot <- aggregate(Emissions~year, data=veh_ndata, sum)

#set device to plot into a PNG file
png(filename = "plot5.png")

# construct plot
plot <- ggplot(bltm_veh_tot,
               aes(x=factor(year), y=Emissions, fill = Emissions)) +
    geom_bar(stat="identity") +
    labs(title = "Total Vehicle Emissions(PM2.5) in Baltimore (1999-2008)",
         x = "Year", y = "Emissions PM2.5 (tons)")
print(plot)

#Close the device
dev.off()
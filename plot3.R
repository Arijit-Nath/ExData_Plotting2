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

#Filter out only baltimore data
balt_data <- NEI[NEI$fips == "24510",]

# aggregate total emissions by year and type
balt_emiss <- aggregate(Emissions~year+type, data=balt_data, sum)

# transform year into factor
balt_emiss <- transform(balt_emiss, factor(balt_emiss$year))

#set device to plot into a PNG file
png(filename = "plot3.png")

# construct plot using ggplot2
plot <- ggplot(balt_emiss, aes(x=year, y=Emissions, fill=type)) +
    geom_bar(stat="identity") +
    facet_grid(. ~ type) +
    labs(title = "Total Emissions(PM2.5) in Baltimore (1999-2008)",
         x = "Year", y = "Emissions PM2.5 (tons)")
print(plot)
#Close the device
dev.off()
#Data files are stored in /DATA/ folder
#No need to read if it has already been read
if (!exists("NEI")) {
    NEI <- readRDS("./data/summarySCC_PM25.rds") 
}
if (!exists("SCC")) {
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}

#Baltimore City, Maryland has fips(five-digit U.S. county) ="24510"
balt_emiss <- NEI %>% filter(fips == 24510) %>% group_by(year) %>% summarise(total = sum(Emissions))

#set device to plot into a PNG file
png('plot2.png')

barplot(balt_emiss$total, names.arg = balt_emiss$year, xlab = "Year", ylab = "Emissions PM2.5 (tons)", ylim=c(0, 4000), col="grey",
        main = "Baltimore Annual Emissions (PM 2.5)")

#Close the device
dev.off()


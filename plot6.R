#Load libraries
library(ggplot2)
library(stringr)

#Data files are stored in /DATA/ folder
#No need to read if it has already been read
if (!exists("NEI")) {
    NEI <- readRDS("./data/summarySCC_PM25.rds") 
}
if (!exists("SCC")) {
    SCC <- readRDS("./data/Source_Classification_Code.rds")
}

#Comparison between Baltimore City vs LA County based on vehicle emission(PM2.5)

comp_data <- NEI %>% filter(fips %in% c("24510", "06037"), type == "ON-ROAD") %>% 
         group_by(year, fips) %>% 
         summarise(total = sum(Emissions))

# Replace with actual city names, so that city name comes instead of county number
loc <- str_replace_all(comp_data$fips, c("06037" = "LA County", "24510" = "Baltimore City")) 

#Convert the year into factor variable,
comp_data <- transform(comp_data, factor(comp_data$year))

png("Plot6.png")

plot <- ggplot(comp_data, aes(x = year, y = total)) + 
    geom_bar(stat = "identity", position = "dodge",aes(fill = loc)) + 
    ggtitle("On Road Emissions(PM2.5) Baltimore City vs LA County") +
    labs(x = "Year", y = "Emissions PM2.5 (tons)")

print(plot)

dev.off()
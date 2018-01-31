##-------------------------------------------Project2---------------------------

##Plot5.R

##------------------------------Loading the data--------------------------------
# downloading the source file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
              destfile = "./FNEI_data.zip")

#Unzipping the source file
unzip("./FNEI_data.zip")

#Loading the data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

##------------------------------------------------------------------------------

##-----------------------Checking the summary of the data-----------------------
#Checking the structure of the data
str(NEI)
str(SCC)

##Checking the summary of the data
summary(NEI)
summary(SCC)

##-----------------------------------------------------------------------------

##--------Total emission filtered by Vehicle in Baltimore City-----------
library(dplyr)

vehicles_scc <- SCC %>% filter(grepl("Vehicles",EI.Sector)) %>% select(SCC)

total_emissions_vehicles <- NEI %>% filter((SCC %in% vehicles_scc$SCC)&(fips == "24510")) %>% 
  select(year,Emissions) %>%group_by(year) %>% 
  summarise(total_emissions = sum(Emissions))

##-----------------------------------------------------------------------------

##------------------------------------------------------------------------------
###---------Total Eimssion Plot for Vehicle in Baltimore City-----------

library(ggplot2)

g <- ggplot(data = total_emissions_vehicles,aes(factor(year),total_emissions,
                                                fill=year,label=round(total_emissions,2)))
g + geom_bar(stat = "identity") +xlab("year")+ylab("Total emissions in tons")+
  labs(title="Total Emissions per year in Baltimore City for Vehicles")+
  geom_label(aes(fill=year),color="white")


dev.copy(png,"plot5.png")

dev.off()

# In plot it can be seen that total emissions is decreased from 1999-2008 for 
# motor vehicle sources in Baltimore City.
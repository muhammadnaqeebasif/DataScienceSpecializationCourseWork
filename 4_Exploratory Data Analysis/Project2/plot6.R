##-------------------------------------------Project2---------------------------

##Plot6.R

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

##---Total emission filtered by Vehicle in Baltimore City and California---------
library(dplyr)

vehicles_scc <- SCC %>% filter(grepl("Vehicles",EI.Sector)) %>% select(SCC)

total_emissions_vehicles <- NEI %>% filter((SCC %in% vehicles_scc$SCC)&
                                             (fips == "24510" |fips=="06037")) %>% 
  select(year,Emissions,fips) %>%group_by(year,fips) %>% 
  summarise(total_emissions = sum(Emissions)) %>%
  mutate(County=ifelse(fips=="24510","Baltimore City","California"))

##-----------------------------------------------------------------------------

##------------------------------------------------------------------------------
###---------Total Eimssion Plot for Vehicle in Baltimore City and California----

library(ggplot2)

g <- ggplot(data = total_emissions_vehicles,aes(factor(year),total_emissions,
                                                fill=County,label=round(total_emissions,2)))
g + facet_grid(County~.,scales="free") + geom_bar(stat = "identity")+
  labs(title="Total Emissions per year for Vehicle")+xlab("year")+
  ylab("Total emissions in tons")+geom_label(aes(fill=County),color="white")


dev.copy(png,"plot6.png")

dev.off()

## As we can see from the bar plot that the values emssion is decreased 
##considerably in Baltimore city  

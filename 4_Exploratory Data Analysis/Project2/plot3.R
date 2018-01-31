##-------------------------------------------Project2---------------------------

##Plot2.R

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

##-----------Total emission per year and type in Baltimore City-----------------
library(dplyr)

total_emissions_baltimore <- NEI %>% filter(fips == "24510") %>%
  select(year,Emissions,type) %>%group_by(year,type) %>% 
  summarise(total_emissions = sum(Emissions))

##-----------------------------------------------------------------------------

##-----------------------------------------------------------------------------
###-------------------------Total Eimssion Plot---------------------------------

library(ggplot2)

g <- ggplot(data = total_emissions_baltimore,aes(year,total_emissions))
g +facet_grid(type~.) + geom_point()+geom_line() + 
  labs(title="Total Emissions per year in Baltimore City")


dev.copy(png,"plot3.png")

dev.off()

# In plot it can be seen that for Non-road, Non-point, On-road total emissions 
# is decreased from 1999 to 2008 while for point type total emissions is increased
# first from 1999-2005 and then it is decreased in 2008 and becomes nearly equal to 
# the value in 2008. 
##-------------------------------------------Project2---------------------------

##Plot4.R

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

##-----------Total emission filtered by Coal Combustion-------------------------
library(dplyr)

coal_scc <- SCC %>% filter(grepl("Coal",EI.Sector)) %>% select(SCC)

total_emissions_coal <- NEI %>% filter(SCC %in% coal_scc$SCC) %>%
  select(year,Emissions) %>%group_by(year) %>% 
  summarise(total_emissions = sum(Emissions))

##-----------------------------------------------------------------------------

##------------------------------------------------------------------------------
###------------Total Eimssion Plot for Coal Combustion--------------------------

library(ggplot2)

g <- ggplot(data = total_emissions_coal,aes(factor(year),total_emissions/1000,
                                            label=round(total_emissions/1000,2),fill=year))
g + geom_bar(stat = "identity") +
  labs(title="Total Emissions per year in United States for Coal Combustion")+
  ylab("Total emissions in kilo tons")+xlab("year")+
  geom_label(aes(fill=year),color="white")


dev.copy(png,"plot4.png")

dev.off()

# In plot it can be seen that total emissions is decreased from 1999-2008.
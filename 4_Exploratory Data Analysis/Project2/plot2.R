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

##-----------Total emission per year in Baltimore City--------------------------
library(dplyr)

total_emissions_baltimore <- NEI %>% filter(fips == "24510") %>%
  select(year,Emissions) %>%group_by(year) %>% 
  summarise(total_emissions = sum(Emissions))

##-----------------------------------------------------------------------------

##-----------------------------------------------------------------------------
###-------------------------Total Eimssion Plot---------------------------------

my_color <- colorRampPalette(c("red","green"))

p<-with(total_emissions_baltimore,barplot(height=total_emissions,names.arg = year,
                                    xlab = "Year",ylab = "Total Emsissions in kilo tons", 
                                    main="Total Emissions Per year in Baltimore CIty",
                                    ylim = c(0,8000),col = my_color(4))
)
with(total_emissions_baltimore,text(x = p, y = round(total_emissions,2), 
     label = round(total_emissions,2),
     pos = 3, cex = 0.8, col = "black"))


dev.copy(png,"plot2.png")

dev.off()

#-------------------------------------------------------------------------------
##Have total emissions from PM2.5 decreased in the Baltimore City from 1999 to 2008?"

if((total_emissions_baltimore[total_emissions_baltimore$year==2008,]$total_emissions) < 
   (total_emissions_baltimore[total_emissions_baltimore$year==1999,]$total_emissions)){
  
  bool_dec<-"Yes"

  }else {
  
    bool_dec<-"No" 

    }

cat("Have total emissions from PM2.5 decreased in the Baltimore City from 1999 to 2008?",
    bool_dec)
#---------------------------------------------------------------------------------
##-------------------------------------------Project2---------------------------

##Plot1.R

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

##-------------------------------Checking the summary of the data---------------
#Checking the structure of the data
str(NEI)
str(SCC)

##Checking the summary of the data
summary(NEI)
summary(SCC)

##-----------------------------------------------------------------------------

##----------------------------Total emission per year--------------------------
library(dplyr)
total_emission_year <- NEI %>% select(year,Emissions) %>%group_by(year) %>% 
                        summarise(total_emissions = sum(Emissions))

##-----------------------------------------------------------------------------

##-----------------------------------------------------------------------------
###-------------------------Total Eimssion Plot---------------------------------

my_color <- colorRampPalette(c("red","green"))
p<-with(total_emission_year,barplot(height=total_emissions/1000,names.arg = year,
                                xlab = "Year",ylab = "Total Emsissions in kilo tons", 
                                main="Total Emissions Per year in United States",
                                ylim = c(0,8000),col = my_color(4))
          )
text(x = p, y = round(total_emission_year$total_emissions/1000,2), 
     label = round(total_emission_year$total_emissions/1000,2),
     pos = 3, cex = 0.8, col = "black")

with(total_emission_year,lines(year,total_emissions))

dev.copy(png,"plot1.png")

dev.off()

#-------------------------------------------------------------------------------
##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?"

if((total_emission_year[total_emission_year$year==2008,]$total_emissions) < 
   (total_emission_year[total_emission_year$year==1999,]$total_emissions)){
  
  bool_dec<-"Yes"

  }else {
 
    bool_dec<-"No" 

 }

cat("Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?",
    bool_dec)
#---------------------------------------------------------------------------------
################################################################################
# plot1.R

#--------------------------downloading and extracting the file------------------

if(!file.exists("./data")){
  dir.create("./data")
}

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "./data/extdata_data_household_power_consumption.zip")

unzip("./data/extdata_data_household_power_consumption.zip",exdir = "./data")


#------------------------Reading the file--------------------------------------
library(data.table)
library(dplyr)
library(lubridate)
data <- fread(input = "./data/household_power_consumption.txt",sep = ";")

#------------------------------------------------------------------------------
# Taking subset over date from 1/2/2017 - 2/2/2017 and casting the required columns

subset <- data %>%filter(Date=="1/2/2007"|Date=="2/2/2007" )
subset$Global_active_power<- as.numeric(subset$Global_active_power)
#-----------------------------------------------------------------------------
#Plot 1
png(filename = "./plot1.png",height = 480,width = 480)
hist(subset$Global_active_power,xlab = "Global Active Power (kilowatts)",
     ylab = "Frquency",main = "Global Active Power",col="red")

dev.off()
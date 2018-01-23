################################################################################
# plot3.R

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
# Taking subset over date from 1/02/2017 - 2/2/2017 and casting the required columns

subset <- data %>%filter(Date=="1/2/2007"|Date=="2/2/2007" )
subset$Global_active_power<- as.numeric(subset$Global_active_power)
subset$Sub_metering_1 <- as.numeric(subset$Sub_metering_1)
subset$Sub_metering_2 <- as.numeric(subset$Sub_metering_2)
subset$Sub_metering_3 <- as.numeric(subset$Sub_metering_3)
datetime <- dmy_hms(paste(subset$Date,subset$Time))

#-----------------------------------------------------------------------------
#Plot 3
png(filename = "./plot3.png",height = 480,width = 480)

plot(datetime,subset$Sub_metering_1,xlab = "",
     ylab = "Energy sub metring",main = "",type = "n")

lines(datetime,subset$Sub_metering_1,xlab = "",
       ylab = "Energy sub metring",main = "",col="black")

lines(datetime,subset$Sub_metering_2,xlab = "",
     ylab = "Energy sub metring",main = "",col="red")

lines(datetime,subset$Sub_metering_3,xlab = "",
      ylab = "Energy sub metring",main = "",col="blue")

legend("topright",col=c("black","red","blue"),legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty = c(1,1,1))

dev.off()
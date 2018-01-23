###############################################################################
Question1

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "q1.csv")
list.files(".")

data_q1 <-read.csv("q1.csv")
names(data_q1)
###############################################Q1############################################
sum(data_q1$VAL==24,na.rm = TRUE)


#############################################Q2#############################################
typeof(data_q1$FES)

############################################~Q3############################################
fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

library(xlsx)
dat <- read.xlsx("q3.xlsx",1,rowIndex = 18:23,colIndex = 7:15)
dat
sum(dat$Zip*dat$Ext,na.rm=T)

###########################################Q4####################################################
library(XML)
rootNode <- xmlTreeParse("Q4.xml",useInternalNodes = TRUE)
xpathSApply(rootNode,"//name",xmlValue)

zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
length(zipcode[zipcode==21231])

#############################################Q5#################################################
fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,destfile = "Q5.csv")

library(data.table)
DT <- fread("Q5.csv",sep = ",")
DT
system.time(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(rowMeans(DT)[DT$SEX==1], rowMeans(DT)[DT$SEX==2])
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

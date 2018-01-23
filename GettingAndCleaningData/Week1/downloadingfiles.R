fileUrl <-"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/cameras.csv")
list.files("./data")

############################################################################################
library(xlsx)
cameraData <- read.csv("./data/cameras.csv",header = TRUE)
write.xlsx(cameraData,"./data/cameras.xlsx")

##########################################################################################
library(xlsx)
cameraData <-read.xlsx("./data/cameras.xlsx",sheetIndex = 1)
head(cameraData)

###########################################################################################

library(XML)
fileUrl <- "https://www.w3schools.com/xml/simple.xml"
download.file(fileUrl,destfile = "test.xml")
doc <- xmlTreeParse(fileUrl ,useInternalNodes = TRUE)
rootNode <-xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]

xmlSApply(rootNode,xmlValue)
xpathSApply(rootNode,"//name",xmlValue)
xpathSApply(rootNode,"//price",xmlValue)

###############################################################
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

names(jsonData$owner)
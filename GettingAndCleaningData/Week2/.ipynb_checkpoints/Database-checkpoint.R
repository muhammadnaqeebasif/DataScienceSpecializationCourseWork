UcscDv <- dbConnect(MySQL(),user="genome",
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(UcscDv,"SHOW DATABASES;")
dbDisconnect(UcscDv)

hg19 <- dbConnect(MySQL(),user="genome",
                  host="genome-mysql.cse.ucsc.edu",
                  db="hg19")
allTables <-dbListTables(hg19)
length(allTables)

dbListFields(hg19,"affyU133Plus2")

dbGetQuery(hg19,"SELECT COUNT(*) FROM affyU133Plus2;")

affyData <- dbReadTable(hg19,"affyU133Plus2")

head(affyData)

query <- dbSendQuery(hg19,"SELECT * FROM affyU133Plus2 WHERE
                     misMatches BETWEEN 1 AND 3")
affyMist <-fetch(query)
quantile(affyMist$misMatches)

dbClearResult(query)
library(data.table)
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))

tables()

DT[2,]

DT[DT$y=='a']

DT[c(2,3)]

DT[DT$y=='a']

DT[,c(2,3)]

DT

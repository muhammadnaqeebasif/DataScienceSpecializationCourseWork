add2 <- function(x,y){
  x+y
}

above <-function(x,n){
  use <- x >n
  x[use]
}

above10 <- function(x){
  above(x,10)
}

columnmean <- function(y,removeNA=TRUE){
  nc <- ncol(y)
  means <-numeric(nc)
  for (i in 1:nc){
    means[i]<- mean(y[,i],na.rm = removeNA)
  }
  means
}
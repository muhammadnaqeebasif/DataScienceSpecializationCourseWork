complete <-function(directory,id=1:332){
    filePath <- function(id){
        id_ext<-paste("00",id,sep="")
        name<-substr(id_ext,nchar(id_ext)-3+1,nchar(id_ext))
        paste(paste(directory,"/",sep=""),name,".csv",sep = "")
    }
    id_vector <- vector()
    nobs_vector <- vector()
    for(i in id){
        df <- read.csv(filePath(i))
        id_vector <- c(id_vector,i)
        nobs_vector <- c(nobs_vector,sum(complete.cases(df)))
    }
    data.frame(id=id_vector,nobs=nobs_vector)
}
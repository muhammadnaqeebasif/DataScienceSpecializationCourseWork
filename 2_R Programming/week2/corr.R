source("complete.R")
corr <-function(directory,threshold=0){
    lst = list.files(directory)
    cor_vector<- vector()
    for(id in seq_along(lst)){
        completeness <-complete(directory = directory,id=id)
        if(completeness[['nobs']]<=threshold){
        }
        else{
            df <- read.csv(paste(directory,lst[id],sep = "/"))
            cr <-cor(x=df[['sulfate']],y=df[['nitrate']],use = "complete.obs")
            cor_vector <- c(cor_vector,cr)
        }
    }
    cor_vector
}
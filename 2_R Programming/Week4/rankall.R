rankall <- function(outcome, num = "best") {
    data <- read.csv("outcome-of-care-measures.csv")
    outcomes_dict <- list("heart attack"= 11,"heart failure"=17,"pneumonia" = 23)
    if (!(outcome %in% names(outcomes_dict))){
        print("Invalid Outcome")
    }
    else{
        index =-1
        d <- data[,c(2,7,outcomes_dict[[outcome]])]
        d[,3] <- as.numeric(as.character(d[,3]))
        d[,1] <- as.character(d[,1])
        splt_state <- split(d,d[,2])
        state.name <-vector()
        hospital.name <-vector()
        if(num == "best"){
            index =1
        }
        else if (num=="worst"){
            index =-1
        }
        else{
            index=num
        }
        for(name in names(splt_state)){
            state.name<-c(state.name,name)
            data_state <-splt_state[[name]]
            if(num=="worst"){
                index <-dim(data_state)[1]
            }
            hosp.names.order <-data_state[order(data_state[,3],data_state[,1],decreasing = FALSE),1]
            if(length(hosp.names.order)<index){
                hospital.name <-c(hospital.name,NA)
            }
            else{
                hospital.name <- c(hospital.name,hosp.names.order[index])
            }
        }
        data.frame(hospital=hospital.name,state=state.name)
        
    }
}
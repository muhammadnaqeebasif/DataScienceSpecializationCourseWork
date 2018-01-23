rankhospital <-function(state,outcome,num="best"){
    data <- read.csv("outcome-of-care-measures.csv")
    outcomes_dict <- list("heart attack"= 11,"heart failure"=17,"pneumonia" = 23)
    error <- paste("Error in best('",state,"', '",outcome,"'): invalid state ",sep = "")  
    if(!(state %in% data$State)){
        error
    }
    else if (!(outcome %in% names(outcomes_dict))){
        error
    }
    else{
        index =-1
        d <- data[,c(2,7,outcomes_dict[[outcome]])]
        subset_state <- subset(d,d[,2]==state)
        if(num == "best"){
            index =1
        }
        else if (num=="worst"){
            index = dim(subset_state)[1]
        }
        else if (num>dim(subset_state)[1]){
            return(NA)
        }
        else{
            index=num
        }
        subset_state[,3] <- as.numeric(as.character(subset_state[,3]))
        subset_state[,1] <- as.character(subset_state[,1])
        t <-subset_state[order(subset_state[,3],subset_state[,1],decreasing = FALSE),1]
        t[index]
    }
}
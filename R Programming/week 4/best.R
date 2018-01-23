best <-function(state,outcome){
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
        d <- data[,c(2,7,outcomes_dict[[outcome]])]
        subset_state <- subset(d,d[,2]==state)
        subset_state[,3] <- as.numeric(as.character(subset_state[,3]))
        subset_state[,1] <- as.character(subset_state[,1])
        subset_state[order(subset_state[,3],subset_state[,1],decreasing = FALSE),1][1]
    }
}
for(i in 1:length(names(trainData))){
  myformula <- as.formula(paste("classe~",names(trainData)[i]))
  print(myformula)
  model <- train(myformula,data=trainData,method="rpart",na.action = na.pass)
  model
  
}

#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  mtcars$mpgsp <- ifelse(mtcars$mpg-20>0,mtcars$mpg-20,0)
  model1 <- lm(hp~mpg,data = mtcars)
  model2 <- lm(hp~mpgsp+mpg,data = mtcars)
  
  model1pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model1,data.frame(mpg=mpgInput))
  })
  
  model2pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model2,data.frame(mpg=mpgInput,
                              mpgsp=ifelse(mpgInput-20>0,
                                           mpgInput-20,0)))
  })
  
  output$plot1 <- renderPlot({
    mpgInput <- input$sliderMPG
    
    g <- ggplot(data=mtcars,aes(x=mpg,y=hp)) +geom_point() +
      xlab("Mile Per Gallon") + xlim(10,35) + ylab("Horse Power")+
      ylim(50,350)
    g <- g+geom_point(aes(x=x,y=pred,colour="model1",size=1.4),
                    data=data.frame(x=mpgInput,pred=model1pred()))
    g <- g+geom_point(aes(x=x,y=pred,colour="model2",size=1.4),
                    data=data.frame(x=mpgInput,pred=model2pred()))
    if(input$showModel1){
      g<- g + geom_line(aes(
        x=x,y=pred,colour="model1"),size=1.4,
        data=data.frame(x=mtcars$mpg,
                        pred=predict(model1,mtcars)))
    }
    
    if(input$showModel2){
      pred <- predict(model2,newdata=data.frame(
        mpg=10:35,mpgsp=ifelse(10:35 -20 >0,10:35-20,0)
      ))
      g <- g+ geom_line(aes(x=x,y=pred,colour="model2"),size=1.4,
                        data = data.frame(x=10:35,pred=pred))
    }
      g <- g + scale_color_manual(name="model",values = c(
        model1="red",model2="blue")
      )
      g +guides(size=FALSE)
      
    })
  output$pred1 <- renderText({
    model1pred()
  })
  output$pred2 <- renderText({
    model2pred()
  })
})

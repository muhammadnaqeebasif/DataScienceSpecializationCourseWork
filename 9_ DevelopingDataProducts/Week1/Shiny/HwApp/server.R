#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   output$plot1 <- renderPlot({
     if(input$data=="mtcars"){
       data("mtcars")
       data_plt <- mtcars
     }
     else{
       data("iris")
       data_plt <- iris
     }
     plot(data_plt[,1],data_plt[,2])
   })
  
})

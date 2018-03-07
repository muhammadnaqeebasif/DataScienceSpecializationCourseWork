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
    set.seed(2006 - 05 - 25)
    number_of_points <- input$numeric
    minX <- input$sliderX[1]
    maxX <- input$sliderX[2]
    minY <- input$sliderY[1]
    maxY <- input$sliderY[2]
    dataX <- runif(number_of_points,min=minX,max = maxX)
    dataY <- runif(number_of_points,min=minY,max = maxY)
    xlab <- ifelse(input$show_xlab,"X Axis","")
    ylab <- ifelse(input$show_ylab,"Y Axis","")
    main <- ifelse(input$show_title,"Title","")
    plot(dataX,dataY,main = main,xlab = xlab,ylab = ylab,
         xlim = c(-100,100),ylim = c(-100,100))
  })
})
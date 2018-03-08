#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyServer(function(input, output) {
  
  library(dplyr)
  library(ggplot2)

  my_data <- mtcars %>% mutate(cyl=factor(cyl),gear=factor(gear),carb=factor(carb),
                               vs=factor(vs,labels = c("V-Shape","Straight Line")),
                               am=factor(am,labels = c("Automatic","Manual"))
                               )
  
  factor_names <- sapply(my_data, is.factor)
  factor_names <- names(factor_names[factor_names==T])
  
  output$headingSumm <- renderUI({
    if(input$checkSumm){
      h3("Summary")
    }
    else{
      h3("Structure")
    }
  })
  
  output$summary <- renderPrint({
    if(input$checkSumm){
      summary(my_data)
    }
    else{
      str(my_data)
    }
  })
  
  
  output$xComponent <- renderUI({
    selectInput(inputId = "x","X Component",names(mtcars))    
  })
  
  output$yComponent <- renderUI({
    selectInput(inputId = "y","Y Component",c("None",names(mtcars)))    
  })
  
  output$colourComponent <- renderUI({
    selectInput("colorBy","Colour By",c("None",factor_names))
  })
  
  x <- reactive({
    input$x
  })
  
  y <- reactive({
    input$y
  })
  
  colour_comp <- reactive({
    input$colorBy
  })
  
  
  output$plot <- renderPlot({
    g <- ggplot(my_data)+aes_string(x=x())
    
    if (y()=="None"){
      if(x() %in% factor_names){
        g <- g + geom_bar()
      }
      else{
        g<- g +geom_histogram(bins = 15)
      }
    }
    
    else{
      g <- g +aes_string(y=y()) + geom_point(size=3)
      if(input$model){
        g <- g + geom_smooth(method = "lm",se=F)
      }
    }
    
    if(colour_comp()!="None"){
      g <- g +aes_string(fill=colour_comp(),colour=colour_comp())
      if(input$facet){
        g <- g + facet_grid(as.formula(paste(".~",colour_comp())))
      }
    }
    g <- g +labs(title="Mtcars Dataset")+theme(plot.title = element_text(hjust = 0.5))
    g
  })
  
})

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

  ## mutating mtcars data to convert categorical features to factor
  my_data <- mtcars %>% mutate(cyl=factor(cyl),gear=factor(gear),carb=factor(carb),
                               vs=factor(vs,labels = c("V-Shape","Straight Line")),
                               am=factor(am,labels = c("Automatic","Manual"))
                               )
  
  ## finding out the names of the categorical features
  factor_names <- sapply(my_data, is.factor)
  factor_names <- names(factor_names[factor_names==T])
  
  # Summary/Structure heading. Its value depends on the Summary/Structure checkbox.
  output$headingSumm <- renderUI({
    if(input$checkSumm){
      h3("Summary")
    }
    else{
      h3("Structure")
    }
  })
  
  # Summary/Structure output. Its value depends upon the Summary/Structure checkbox.
  output$summary <- renderPrint({
    if(input$checkSumm){
      summary(my_data)
    }
    else{
      str(my_data)
    }
  })
  
  # X component select box which contains the list of names of features of mtcars dataset.
  output$xComponent <- renderUI({
    selectInput(inputId = "x","X Component",names(mtcars))    
  })
  
  # Y Component select box which contains the list of names of features of mtcars dataset 
  # and "None" string.
  output$yComponent <- renderUI({
    selectInput(inputId = "y","Y Component",c("None",names(mtcars)))    
  })
  
  # Colour By select box which contains the list of names of categorical features of 
  # mtcars dataset and "None" string.
  output$colourComponent <- renderUI({
    selectInput("colorBy","Colour By",c("None",factor_names))
  })
  
  # X Component 
  x <- reactive({
    input$x
  })
  
  #Y Component
  y <- reactive({
    input$y
  })
  
  # Colour Component
  colour_comp <- reactive({
    input$colorBy
  })
  
  # Output Plot
  output$plot <- renderPlot({
    
    # A ggplot object
    g <- ggplot(my_data)+aes_string(x=x())
    
    # if Y Component is None then histogram or Barplot is plotted depending on 
    # the type of X Component(Continuous or categorical)
    if (y()=="None"){
      if(x() %in% factor_names){
        g <- g + geom_bar()
      }
      else{
        g<- g +geom_histogram(bins = 15)
      }
    }
    
    # If Y Component is not None then scatterplot is plotted and depending upon 
    # the value of Linear Model check box linear model is plooted
    else{
      g <- g +aes_string(y=y()) + geom_point(size=3)
      if(input$model){
        g <- g + geom_smooth(method = "lm",se=F)
      }
    }
    
    # If Colour By is not None then plot is colored by the feature and 
    # depending upon the value of Facet Grid checkbox the facet grid is plotted.
    if(colour_comp()!="None"){
      g <- g +aes_string(fill=colour_comp(),colour=colour_comp())
      if(input$facet){
        g <- g + facet_grid(as.formula(paste(".~",colour_comp())))
      }
    }
    # Title is added to the plot and is centred 
    g <- g +labs(title="Mtcars Dataset")+theme(plot.title = element_text(hjust = 0.5))
    
    g
  })
  
})

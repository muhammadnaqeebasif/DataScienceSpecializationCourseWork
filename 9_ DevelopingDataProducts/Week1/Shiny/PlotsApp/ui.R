#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Plot Random Numbers"),
  sidebarLayout(
    sidebarPanel(
      numericInput("numeric","How many Numbers should be plotted?",
                   value = 1000,min=1,max = 1000,step = 1),
      sliderInput("sliderX","Pick minimum and maximum X values",
                  -100,100,value = c(-100,100)),
      
      sliderInput("sliderY","Pick minimum and maximum Y values",
                  -100,100,value = c(-100,100)),
      checkboxInput("show_xlab","Show/Hide X Axis Label",value = TRUE),
      checkboxInput("show_ylab","Show/Hide Y Axis Label",value = TRUE),
      checkboxInput("show_title","Show/Hide Title",value = TRUE)
    ),
    mainPanel(
      h3("Graph of Random Points"),
      plotOutput("plot1")
    )
  )
))

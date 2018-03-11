#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Exploratory Analysis of mtcars dataset"),
  
  # Side Bar Layout
  sidebarLayout(
    
    #Side Bar Panel
    sidebarPanel(
      # Summary/Structure CheckBox
      checkboxInput("checkSumm","Summary/Structure",value = T),
      # X Component select box
      uiOutput("xComponent"),
      # Y Component select box
      uiOutput("yComponent"),
      # Colour By select box
      uiOutput("colourComponent"),
      # Facet Grid Checkbox
      checkboxInput("facet","Facet Grid"),
      # Linear model check box
      checkboxInput("model","Linear Model")
    ),
    # Main Panel
    mainPanel(
      # Summary/Structure heading
      uiOutput("headingSumm"),
      #Summary/Strucuture output
      verbatimTextOutput('summary'),
      # Plot heading
      h3("Plot"),
      # Plot Output
      plotOutput("plot")
    )
  )
))

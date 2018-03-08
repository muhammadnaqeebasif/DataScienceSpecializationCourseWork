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
  sidebarLayout(
    sidebarPanel(
      checkboxInput("checkSumm","Summary/Structure",value = T),
      uiOutput("xComponent"),
      uiOutput("yComponent"),
      uiOutput("colourComponent"),
      checkboxInput("facet","Facet Grid"),
      checkboxInput("model","Linear Model")
    ),
    mainPanel(
      uiOutput("headingSumm"),
      verbatimTextOutput('summary'),
      h3("Plot"),
      plotOutput("plot")
    )
  )
))

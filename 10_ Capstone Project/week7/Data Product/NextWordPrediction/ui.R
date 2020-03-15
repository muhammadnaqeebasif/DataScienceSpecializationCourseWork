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
  titlePanel("Data Science Capstone Project"),
  fluidRow(
    column(10, wellPanel(
      titlePanel("Predictive Text Modelling"),
      p("Below is a text input and next word is predicted using either n-gram models only 
        (made a deep learning model too but to deploy on shinyapps it requires money."),
      textInput("text", "Enter Text here:"),
      submitButton("Submit")
    )),
    column(10,verbatimTextOutput("text")
    )
  )
)
)


library(shiny)

shinyUI(fluidPage(
  titlePanel("Data Science FTW!"),
  sidebarLayout(
    sidebarPanel(
      h3("Slidebar Text")
    ),
    mainPanel(
      h3("Main Panel Text")
    )
  )
))
library(shiny)

shinyUI(fluidPage(
    titlePanel("HTML tags"),
    sidebarLayout(
      sidebarPanel(
        h1("H1 text"),
        h2("H2 text"),
        h3("H3 text"),
        em("Emphasized Text")
      ),
      mainPanel(
        h3("Main Panel Text"),
        code("Some Cod!")
        )
    )
))
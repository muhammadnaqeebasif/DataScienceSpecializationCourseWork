# Introduction
It this project the shiny application is built. This folder contains the following files:
* ```README.md``` contains the brief instruction on how to use the application.
* ```server.R``` contains the code for shiny server.
* ```ui.R``` contains the code for user interface of the application.

## Brief Instructions
The aim of this application is to perform some exploratory analysis on mtcars dataset. The application is divided into two parts:
1. Summary Part
2. Plot Part

### Summary Part
The summary part of the application displays either summary or structure of mtcars data depending upon the value
of the checkbox with label 'Summary/Structure'.If the 'Summary/Structure' checkbox is checked then summary of the data is displayed otherwise
the structure of the data is printed.

### Plot Part 
The plot part of the application displays the plot depending upon the choise chosen by the user. Following plots can be plotted
in the application:

1. ```Histogram``` if 'Y Component' is set to 'None' then the histogram is plotted if the feature chosen in 'X Component'  select box is 
continuous.

2. ```BarPlot``` if 'Y Component' is set to 'None' then the histogram is plotted if the feature chosen in 'X Component'  select box is 
categorical.

3. ```Scatter plot``` if 'Y Component' is set to any value other than 'None' then a scatter plot is plotted between 
'X Component' and 'Y Component'.

4. ```Colour By``` if a feature is chosen in 'Colour By' select box then the plot is coloured by the feature chosen.

5. ```Facet Grid``` if the 'Facet Grid' checkbox is checked then facet grid is created in the plot according to the 
categorical feature chosen in 'Colour By' selectBox.

6. ```Linear Model``` if the 'Linear Model' checkbox is checked then the linear model is plotted on the scatter plot. 

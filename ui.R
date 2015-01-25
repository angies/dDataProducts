
# Developing application
library(shiny)

#Define UI for vapor pressure of mercury as a function of temperature application
shinyUI(fluidPage(
   
   titlePanel ("Predicting Pressure"),
   sidebarLayout(
   sidebarPanel(
      helpText("This application can fit a prediction model by 
                a smoothing spline to the supplied data. It predicts 
                vapor pressure values of mercury from given temperature 
                values. The bs function of the spline package and 
                a range of degrees of freedom from 3 to 10 values have 
                been used.                 
                Estimate Adjusted R Squared, which is a metric for 
                evaluating the goodness of fit of the model.
                The supplied data are from pressure dataset 
                package. You can choose scatter and line style plot."), 
      br(),
      radioButtons("plotType", "Plot type:",c("Scatter"="p","Line"="l")),
      sliderInput("dfSlider",label=h5("Degrees of Freedom"),min=3,max=10,value=3),
      wellPanel(
         helpText( p(a("Basic Manual", href="http://rpubs.com/angies/56017",target="_blank")),
                   p(a("Source Code", href="https://github.com/angies/dDataProducts/tree/master",target="_blank")),
                   p(a("Presentation", href="http://angies.github.io/ddp_project/index.html#/",target="_blank"))
                 )
      )
      
   ),
   mainPanel(
      tabsetPanel(type ="tabs",
         tabPanel("Plot",plotOutput("plot", height = "400px")),
         tabPanel("Summary",verbatimTextOutput("summary")),
         tabPanel("Table",tableOutput("table")),
         tabPanel("Predicted",tableOutput("pTable"))
      ),
      textOutput("arsquared")
   )
   )
))

# Developing application
library(shiny)

# Base R dataset (includes pressure data)
library(datasets)
data(pressure)

# R Statistical functions (lm() was used)
library(stats)

# Regression Spline Functions and Classes (bs() was used)
library(splines)

# Define server logic
shinyServer(function(input,output) {
   
   # Estimate Adjusted R Squared: 
   # Metric for evaluating the goodness of fit of your model
   output$arsquared <- renderText({ 
       ar2 <- summary(prediction())$adj.r.squared
       paste0(' Adjusted R Squared: ', round(ar2,6), '  (near 1 is better !)')
   })
   
   # Predict pressure values from supplied data by using bs() function
   prediction<-reactive({
        lm(pressure$pressure ~ bs(pressure$temperature, degree=input$dfSlider))
   })
   
   # Get predicted pressure values
   pdata <-reactive({
      fm1 <- prediction()
      rows <- nrow(pressure)
      temp_spline <- seq(pressure[1,1],pressure[rows,1],length.out=rows)
      data.frame(x=temp_spline,y=predict(fm1,data.frame(x=temp_spline)))
   })
   
   # Render plot
   output$plot <- renderPlot(height = 400,{
      par(mar = c(5.1, 4.1, 0, 1))
      plot(pressure$temperature,
           pressure$pressure,
           xlab="Temperature (ºC)",
           ylab="Pressure (mm)",
           type=input$plotType,
           col="darkblue")
      points(pdata(),type="l",col="green")   
   })
   
   # Display summary for supplied data
   output$summary <- renderPrint({
      summary(pressure)
   })
   
   # Show supplied data in rows and columns
   output$table <- renderTable({
      data.frame(pressure)      
   })
   
   # Show predicted values in table, 
   # x=temperature, y=pressure
   output$pTable <-renderTable({
       data.frame(pdata())
   })  

})

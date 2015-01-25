## Predicting Pressure Application

#### Coursera Project. Developing Data Products Course
## 

This application can fit a prediction model by a smoothing spline to the supplied data. It predicts vapor pressure values of mercury from given temperature values. 

The bs function of the spline package and a range of degrees of freedom from 3 to 10 values have been used.  

Estimate Adjusted R Squared, which is a metric for evaluating the goodness of fit of the model.

The supplied data are from pressure dataset package. **See** <https://stat.ethz.ch/R-manual/R-patched/library/datasets/html/pressure.html>

This application was developed by using the following libraries:

```{r}
# Developing application
library(shiny)

# Base R dataset (includes pressure data)
library(datasets)
data(pressure)

# R Statistical functions (lm() was used)
library(stats)

# Regression Spline Functions and Classes (bs() was used)
library(splines)
```

## Predicing Pressure View.

You can run Predicting Pressure App in <https://ae2015.shinyapps.io/predict_pressure/>. This application can fit a prediction model by a smoothing spline to the supplied data. 

You can see in the plot tab a graph for data on the relation between temperature in degrees Celsius and vapor pressure of mercury in millimeters (of mercury). The blue points represent the original data and green curve line the predicted from spline regression model.

The plot tab is reactive when the value of slider control is modified and the plot type is changed.

![alt text](img1.png)

You can modify the degrees of freedom for the prediction. The slider control is in range from 3 to 10 values. When you change the degrees of freedom, the app estimates new predicted pressure values.

## Statistical summary of pressure data

The Summary tab shows some stats from the original pressure data.

```{r, echo=FALSE}
data(pressure)
summary(pressure)
```

## Table Tab and Predicted Tab

The Table tab contains the values from the original pressure data. The Predicted tab displays the estimated vapor pressure values by fitting a spline model. It is reactive when change the value of slider control.

The following values corresponds to 10 observaciones on the top. They can be displayed in Table tab.

```{r, echo=FALSE}
   head(pressure,10)
```

The next values corresponds to 10 predicted pressure values, which can be displayed in the Predicted tab. They were estimated for 3 degrees of freedom.

```{r, echo=FALSE}
prediction<-function(degrees){
    lm(pressure$pressure ~ bs(pressure$temperature, degree=degrees))
}
pData<-function(degrees){
   fm1 <- prediction(degrees)
   rows <- nrow(pressure)
   temp_spline <- seq(pressure[1,1],pressure[rows,1],length.out=rows)
   data.frame(x=temp_spline,y=predict(fm1,data.frame(x=temp_spline)))
}
p<-pData(3)
head(p,10)
```

The final 10 predicted pressure values are estimated for 8 degrees of freedom.

```{r, echo=FALSE}
p<-pData(8)
head(p,10)
```

## The Adjusted R Squared

The Adjusted R Squared, which is a metric for evaluating the goodness of fit of the model was estimated.

```{r, echo=FALSE}
   model <- prediction(3)
   r1 <- summary(model)$adj.r.squared
   model <- prediction(8)
   r2 <- summary(model)$adj.r.squared
   
```

For a predicted pressure values for 3 and 8 degrees of freedom their Adjusted R Squared are `r r1` and `r r2`   respectively. Thus, in this comparison case the model for 8 degrees of freedom fit better for the data.


## References

Weast, R. C., ed. (1973) Handbook of Chemistry and Physics. CRC Press.

McNeil, D. R. (1977) Interactive Data Analysis. New York: Wiley.

Shiny is an RStudio project. 2014 RStudio, Inc. <http://shiny.rstudio.com/>


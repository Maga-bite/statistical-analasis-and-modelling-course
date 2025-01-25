#LINEAR REGRESSION

#to describe the relationship between two QUANTITATIVE VARIABLES

#The values of the parameters of the model are computed using the
#LEAST SQUARES method
#=>
#the best straight line going through the data is the one for which the 
#sum of the squares of the error terms 
#(i.e. the difference between observed and expected values) is the smallest.

#null hypothesis is that the two variables x and y are completely independent, 
#so the model should provide a horizontal line and the slope coefficient is β1 = 0


#As an example, we can use the “thuesen.txt”
#heart contraction and blood glucose levels in 24 diabetic patients.

thuesen=read.table("thuesen.txt",header=T)

#lm() function to compute a linear model 
mod=lm(short.velocity~blood.glucose,data=thuesen)

#we can use several special functions called EXTRACTORS.

#the output of any model is stored in a complex “model” object,
#from which information can be extracted instead of being automatically shown 

summary(mod)
#the last info is the F-test (variance test), which is a simple linear regression coincides
#with a t-, also called F STATISTIC

fitted(mod) # expected values of the y variable

resid(mod) # error term distribution

#Functions like fitted() and resid() return vectors of the same length as 
#the original data, with NA values corresponding to the missing observations.

plot(thuesen) # scatterplot of the points using x and y coordinates

abline(mod) # adds a regression line on the plot

#To plot the error terms, we may use the segments() function.
segments(thuesen$blood.glucose,fitted(mod),thuesen$blood.glucose,
         thuesen$short.velocity)

#segments(x0, y0, x1 = x0, y1 = y0,
#        col = par("fg"), lty = par("lty"), lwd = par("lwd"),
#         …)

#we still have MISSING DATA

options(na.action=na.exclude) # excludes missing data
#The options function modifies R’s global options. 

#The na.action parameter specifies how R should handle missing data (NA) 
#in statistical models, such as the linear model created with lm().

#The na.exclude option indicates that missing values should be excluded from 
#the analysis but retained in the output.

#The model mod will be recalculated, excluding the missing data.
#The plots (plot() and abline()) won’t be directly affected, 
#but the segments() command for drawing error lines will not cause issues, 
#as fitted(mod) and the original data will remain consistent in length.


#Then, let’s redo the model and the plot:
  
mod=lm(short.velocity~blood.glucose,data=thuesen)

plot(thuesen)

abline(mod)

segments(thuesen$blood.glucose,fitted(mod),thuesen$blood.glucose,
         thuesen$short.velocity)

#options() ensures correct alignment between the original data and the results 
#(e.g., fitted values and residuals), even when missing data are present.

#After setting this option, the code recalculates the model and plots:

#in comparison
par(mfrow=c(1,2))

fitted(mod)
resid(mod)
plot(thuesen) 
abline(mod)
segments(thuesen$blood.glucose,fitted(mod),thuesen$blood.glucose,
         thuesen$short.velocity)

options(na.action=na.exclude)
mod=lm(short.velocity~blood.glucose,data=thuesen)
plot(thuesen)
abline(mod)
segments(thuesen$blood.glucose,fitted(mod),thuesen$blood.glucose,
         thuesen$short.velocity)

#PERSONALLY I DON'T SEE ANY CHANGE IN THE GRAPHICAL PLOTTING

#You don’t see any difference in the graphical plotting because the changes made
#by setting options(na.action = na.exclude) affect how missing data (NA) are 
#handled in the underlying calculations and output alignment, not directly in
#the visual representation of the plot.

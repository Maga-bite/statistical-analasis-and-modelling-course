#LINEAR REGRESSION

#to describe the relationship between two QUANTITATIVE VARIABLES

#The values of the parameters of the model are computed using the
#LEAST SQUARES method
#=>
#the best straight line goingthrough the data is the one for which the 
#sum of the squares of the error terms 
#(i.e. the difference between observed and expected values) is the smallest.

#null hypothesis is that the two variables x and y are completely independent, 
#so the model should provide a horizontal line and the slope coefficient is β1 = 0


#As an example, we can use the “thuesen.txt”
#heart contraction and blood glucose levels in 24 diabeticpatients.

thuesen=read.table("thuesen.txt",header=T)

#lm() function to compute a linear model 
mod=lm(short.velocity~blood.glucose,data=thuesen)

#we can use a number of special functions called EXTRACTORS.

#the output of any model is stored in a complex “model” object,
#from which information can be extracted instead of it being automatically shown 

summary(mod)
#the last info is the F-test (variance test), which in a simple linear regression coincides
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


###                        since the assumption of the linear model is
#that the error terms are normally distributed, we may want to test it
#explicitly

#Q-Q plot

#to compare the empirical quantiles of our sample
#and compare them with their expected behaviour in a normal distribution
#with the same mean and variance

qqnorm(resid(mod))

# for a p-value, we could use the Shapiro-Wilk test for normality,
#which is based on the assumption of linearity of the Q-Q plot

shapiro.test(resid(mod))
# W = 0.92413, p-value = 0.08173




#MULTIPLE LINEAR REGRESSION

#when we have more than one linear component or explicative independent variable X.

#dataset “trees”, which contains girth, height and volume information 
#on 31 sour cherry plants.We may consider “volume” as the response or 
#dependent variable y, to be expressed in relation to the other explicative,
#independent variables

data(trees)
str(trees)
#str: Compactly Display the Structure of an Arbitrary R Object
summary(trees)
plot(trees)

mod=lm(Volume~Girth+Height,data=trees)
summary(mod)

#'+' between the explicative variables

#the F-test returns a cumulative evaluation of the effects of
#the model, not simply a repetition of the t-test


#EXERCISE
#  The dataset “rmr.txt” contains information on metabolic rate (y) and
#weight (x) for 44 individuals. Produce a scatterplot of these two
#variables, compute the corresponding linear model and add the line
#to the scatterplot.

metabo_rate=read.table("rmr.txt",header=T)

data(metabo_rate)

str(metabo_rate)
#str: Compactly Display the Structure of an Arbitrary R Object
summary(metabo_rate)

BW <- metabo_rate$body.weight
MR <- metabo_rate$metabolic.rate

# Scatterplot
plot(BW, MR, 
     xlab = "Body Weight (BW)", 
     ylab = "Metabolic Rate (MR)", 
     main = "Scatterplot of Body Weight vs Metabolic Rate", 
     pch = 19, col = "blue")

# Modello di regressione lineare
model <- lm(MR ~ BW, data = metabo_rate)

# Sommario del modello
summary(model)

# Aggiungi la linea di regressione
abline(model, col = "red", lwd = 2)


#CORRELATION COEFFICIENT

#Its value goes from -1 to +1 where
#the two extreme values represent perfect anticorrelation and perfect
#correlation respectively, while 0 suggests no correlation at all.


#PEARSON CORRELATION COEFFICIENT

#Pearson correlation coefficient (r) assumes normality of the two variables
#that we are comparing

cor(thuesen$blood.glucose,thuesen$short.velocity,use="complete.obs")
 #this is fast foward

#or

cor(thuesen,use="complete.obs") 

# results in a matrix and then from here
#To obtain a p-value, we can test it against the null hypothesis of r = 0:

cor.test(thuesen$blood.glucose,thuesen$short.velocity)
                                                          #p-value = 0.0479

#the correlation test uses a variable that is t-distributed, 
#so the p-value is the same as the regression analysis! 

#Also, we did not have to specify what to do with the NA values.

#SPEARMAN CORRELATION COEFFICIENT (ρ)

#This is the non-parametric version of the previous test, as it does not
#assume the normality of our variables.

#rank-based test

cor.test(thuesen$blood.glucose,thuesen$short.velocity,
         method="spearman")
                                                              #p-value = 0.1392
 #Impossibile calcolare p-value esatti in presenza di ties

#Note that Spearman correlation is not significant, while Pearson is

#EXERCISE***
#  Going back to the “trees” dataset, compute a correlation matrix
#according to Pearson correlation test. Then, compute Spearman
#correlation between Height and Girth.

#PEARSON
cor(trees) 

cor.test(trees$Girth,trees$Height)


#SPEARMAN
cor.test(trees$Girth,trees$Height,
         method="spearman")








###ANOVA: ANALYSIS OF VARIANCE

#analysis of variance as a regression test in which we
#are comparing a continuous variable and a factorial variable

#data observed for the (normally distributed) quantitative
#variable are divided in groups defined by the characteristics of the
#qualitative variable. 

#############################

#The assumption: the TOTAL variance of a population can be explained 
#by the sum of variances AMONG groups and BETWEEN groups.

#e null hypothesis of the ANOVA is that group subdivision is irrelevant,
#or that there is no “group effect

#all groups have the same characteristics in terms of mean value and variance

#If the null hypothesis is true, then it is expected that the total variance may be
#equally explained by the variance between groups and the variance
#within groups

#ratio of variance between groups AND variance within groups, called F statistics, will be equal to 1

#variability in ONE of the groups is sufficient to refuse the null hypothesis.

#############################


#An example using the “red.cell.folate.txt” 

#level of folate in red blood cells of 22 patients
#that have been subjected to 3 types of ventilation during anesthesia. We
#want to know if the type of ventilation has an effect on folate levels.

red.cell.folate=read.table("red.cell.folate.txt",header=TRUE)

str(red.cell.folate)

#VENTIALTION IS A VECTOR WITH JUST OBJECT NEEDS CONVERTION TO FACTORS

red.cell.folate$ventilation=as.factor(red.cell.folate$ventilation)
# $ you can access and manipulate the individual elements of these objects easily
#as.factor is used to convert a vector object to a factor. 

mod=lm(folate~ventilation,data=red.cell.folate)

mod # shows only the coefficients of the mode

#the “intercept” corresponds to the mean folate measurement
#in the FIRST GROUP (alphabetically), while the other two values are the
#differences between the means of the second and third group and the
#mean of the first group. 

#These are relevant because the mean values
#are also points of reference for computing the variance between groups.

anova(mod) # extracts the full ANOVA

####################################

#The table presents:
# - variance component BETWEEN groups (identified by the factorial
#                                       variable “ventilation”)
#- variance component WITHIN groups (identified with the
#                                    “residuals”)
#- degrees of freedom: groups - 1 (factorial); obs - groups -1
#residuals)

#- sum of square differences between: group mean and the total
#mean (ventilation); observation and mean of their group (residuals)

#- mean squares: variances (Sum sq / df)

#- F test for variance comparison and p-value

-----------------------------------------
#Analysis of Variance Table

#Response: folate
#Df Sum Sq Mean Sq F value  Pr(>F)  
#ventilation  2  15516  7757.9  3.7113 0.04359 *
#  Residuals   19  39716  2090.3                  
---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1



####################################


#What is the group responsible for the “group effect”? We can find out in two ways:

summary(mod)


#The output provides the mean of the first group, then the difference of
#means between the second or third group and the first, respectively; in
#addition, a t-test verifies if these differences are significant.


pairwise.t.test(red.cell.folate$folate,red.cell.folate$ventilation,p.adj="bonferroni")

#In this case, we are performing a pairwise t-test comparing all possible
#pairs of means

#performing the same test multiple times on the same data, as it increases the
#probability of getting a significant result by chance. 

#We can opt for a correction of the p-value computed by the test using the Bonferroni
#method: we multiply each p-value for the number of tests performed!

#graphical representation of the “results”, we may want to produce 
#a boxplot with one box for each group:
  
#boxplot(folate~ventilation,xlab="ventilation",ylab="folate",col=heat.colors(3),las=1)
#Errore in eval(predvars, data, env) : oggetto 'folate' non trovato
#I don'treally know what happened byut i tried to debug it by changing the name and it worked so ok

str(red.cell.folate)
summary(red.cell.folate)
names(red.cell.folate)

names(red.cell.folate)[names(red.cell.folate) == "folate"] <- "folate"

# Esegui il boxplot
boxplot(folate ~ ventilation, data = red.cell.folate,
        xlab = "ventilation", ylab = "folate",
        col = heat.colors(3), las = 1)





###KRUSKAL-WALLIS TEST

#a non-parametric version of the one-way ANOVA exists that
#does not expect the normality of the data, 

#ranks to compute the probability that group subdivision justifies a 
#large portion oftotal variance.

kruskal.test(red.cell.folate$folate,red.cell.folate$ventilation)


###TWO-WAY ANOVA

#extension of the one-way ANOVA

#we can also suppose that the same quantitative data may be classified 
#according to multiple factorialvariables. 

#In this case, the ANOVA becomes a generalized version of the paired t-test.

#dataset “heart.rate.txt”, containing data
#on 9 patients who had a heart attack and measuring their heart rate at 4
#time intervals after administration of a drug. So, we have 36
#observations of the same quantitative variable (heart rate) that can be
#grouped either by patient or by time point.


heart.rate=read.table("heart.rate.txt",header=T)
summary(heart.rate)
str(heart.rate)

heart.rate[,2]=as.factor(heart.rate[,2])

heart.rate[,3]=as.factor(heart.rate[,3])

#“+” symbol to combine the effect of two classifications and estimate 
#their importance

mod=lm(hr~subj+time,data=heart.rate)

anova(mod)

#We can represent the data with an interaction plot (“spaghettigram”)

interaction.plot(ordered(heart.rate$time),heart.rate$subj,heart.rate$hr)

####FRIEDMAN TEST

#This is the non-parametric variant of the two-way ANOVA. It is far less
#sensitive than its parametric counterpart if normality exists in the data.

friedman.test(hr~time|subj,data=heart.rate) # look at the formula!

# Explanation of the formula in friedman.test():

# - hr: The dependent variable (response variable), representing heart rate values.

# - time: The independent variable (grouping variable), representing different conditions or time points.

# - | subj: Indicates that the observations are grouped by subjects (blocking factor).
#           This accounts for repeated measures for each subject.

# - data = heart.rate: Specifies the dataset containing the variables used in the test.


#EXERCISE***
#  The dataset “lung.txt” contains data on pulmonary volume
#measured in three different ways on six patients. Perform a
#two-way ANOVA and represent the data with an interaction plot.

lungy=read.table("lung.txt",header=T)
summary(lungy)
str(lungy)

#Convertiamo le variabili categoriali come method (modo di misurazione) e patient (pazienti) in fattori.
# Trasformazione delle variabili categoriali in fattori

lungy[, 2] = as.factor(lungy[, 2])  # Ad esempio, se la colonna 2 rappresenta il metodo
lungy[, 3] = as.factor(lungy[, 3])  # Ad esempio, se la colonna 3 rappresenta i pazienti

names(lungy)
#check the names of the variables

# Costruzione del modello ANOVA a due vie
mod_lung = lm(volume ~ method + subject, data = lungy)

# Output dell'ANOVA
anova(mod_lung)

# Creazione di un interaction plot (spaghettigram)
interaction.plot(ordered(lungy$method), lungy$subject, lungy$volume)

# Analisi non parametrica con il test di Friedman
friedman.test(volume ~ method | subject, data = lungy)









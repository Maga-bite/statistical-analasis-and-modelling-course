#MULTIVARIATE ANALYSIS

#dedicated to datasets that include a high number of variables. 

#all variables are treated equally and at the same
#time, so that there is no “preferred” variable at the start.

#(unlike regression models where variables are separated in dependent and independent) 

#######################################

# does not work through stochastic methods and statistical
#significance, but their aim is to provide a general outlook on the variability

#STOCHASTIC or random process 
#can be defined as a collection of random variables 
#that is indexed by some mathematical set, meaning that each random variable 
#of the stochastic process is uniquely associated with an element in the set.

#are able to separate the “signal” contained in the data from the background
#noise and are considered “open” models, where nothing is formally tested.

#The objectives of a multivariate analysis are:

#1) data dimensionality reduction for exploratory analysis 
#(Principal Component Analysis; Multi-Dimensional Scaling)
 
#2) group detection and data classification 
#(hierarchical clustering; K-means clustering; linear discriminant analysis).

#######################################




#                     PRINCIPAL COMPONENT ANALYSIS (PCA)

#ransformation to convert a set of experimental
#variables into a new set of variables, called “principal components”.


#The transformation effectively works so that:

#1) the new variables are ordered by the proportion of explained variance

#2) the new variables are NOT correlated.

#How is the transformation performed?

#Supposing a dataset with two quantitative variables, we can present them as a scatterplot. 


#FIRST PRINCIPAL COMPONENT

#find the centroid of our data and, out of all possible straight lines passing 
#through this point, we find the one that minimizes the sum of square distances
#of the points (or empirical observations) from the line (least square method).

#SECOND PRINCIPAL COMPONENT

#The next straight line will also pass through
#the centroid of the data and will be PERPENDICULAR to the first
#principal component; 

#So where is the advantage of computing them?
  
#  1) Variance in the experimental variables is randomly distributed;
#principal components are ORDERED according to the proportion
#of explained variance (PC1 will explain most of the variance in our
#data; PC2 will explain most of the remaining variance; and so on)

#  2) Principal components MINIMIZE correlation within the
#experimental data.

#THE majority of the variance present in our dataset
#will be contained in a few, high-order PCs (first, second, third), while the
#background noise will be represented in the low-ranking PCs

#THIS IS A DIMENSIONALITY REDUCTION!


####################### many functions dedicated to performing data reduction

install.packages("ade4")

library(ade4)

#PCA is a scale-dependent analysis,
#results are influenced by the SIZE of the variables

#dudi.pca() 

#function takes in arguments to perform a preliminary
#balancing of the data on which to perform the PCA

#balancing is performed to render all
#variables numerically homogeneous and comparable:
#  1) centering: average = 0
#  2) scaling: variance = 1
  
#ALWAYS NECESSARY TO PERFORM DATA BALANCING

#example, let’s perform a PCA with the dataset “usair.csv" which
#contains environmental variables for 41 American cities

data=read.csv("usair.csv")

summary(data)
str(data)
names(data)

#different variables have
#different units of measure, scale and variance, so data balancing must
#take place

pca1=dudi.pca(data[,-1],center=T,scale=T)

#The -1 indicates excluding the first column. The PCA will then only 
#use the remaining columns (likely numeric variables).

#When center = T (or TRUE), the columns of the data are centered by subtracting 
#the mean of each column. This ensures that PCA analyzes variations relative
#to the mean, rather than absolute values.

#When scale = T (or TRUE), the variables are standardized by dividing 
#each column by its standard deviation after centering.
#This is useful when variables are measured on different scales 
#(e.g., kilograms vs centimeters). 
#Without scaling, variables with larger scales may dominate the PCA results.

########################################################################

#dudi.pca(df, row.w = rep(1, nrow(df))/nrow(df), 
#col.w = rep(1, ncol(df)), center = TRUE, scale = TRUE, 
#scannf = TRUE, nf = 2)

# Parameters:

# df: 
#   A data frame with n rows (individuals) and p columns (numeric variables).

# row.w:
#   Optional row weights (default is uniform row weights).

# col.w:
#   Optional column weights (default is unit column weights).

# center:
#   A logical or numeric value specifying the centring option:
#     - TRUE: Centre by the mean.
#     - FALSE: No centring.
#     - Numeric vector: Must have a length equal to the number of columns in df, 
#       specifies the decentring values.

# scale:
#   A logical value indicating whether the column vectors should be normalized 
#   for the row.w weighting.

# scannf:
#   A logical value indicating whether the screeplot should be displayed.

# nf:
#   If scannf is FALSE, an integer specifying the number of axes to keep.

########################################################################

#INTERACTIVE FUNCTION that showcases a barplot
#of EIGENVALUES (a measure of variance) related to the principal components



# You can reproduce this result non-interactively with:
# dudi.pca(df = data[, -1], center = T, scale = T, scannf = FALSE, nf = NA)

# Errore in if (nf <= 0) nf <- 2 : 
#   valore mancante dove è richiesto TRUE/FALSE
# In aggiunta: Messaggio di avvertimento:
# In as.dudi(df, col.w, row.w, scannf = scannf, nf = nf, call = match.call(),  :
#   NA introdotti per coercizione

# L'errore è legato al parametro nf (numero di assi da mantenere) nella funzione dudi.pca.
# La presenza di un NA nel parametro nf sta causando problemi, poiché nf non è stato specificato
# correttamente e la funzione non può decidere automaticamente quante componenti mantenere.



#want to know the proportion of variance explained by the
#chosen PCs; we can use the formula:

perc.eig=100 * pca1$eig/sum(pca1$eig)

cumsum(perc.eig)
#Cumulative Sums, Products, and Extremes

#pca contains a vector called “eig”, which is composed of all
#the eigenvalues

#Dividing the eigenvalues for their total sum, what we
#obtain is the proportion of variance explained by each PC.

#cumsum() function, which will tell
#us that the first 3 PCs explain most of the total variability

#"pca1" object by calling it, the
#most important and interesting are:

pca1$tab # balanced data table

pca1$eig # eigenvalues

# Eigenvalues in PCA represent the amount of variance explained by each principal component.
# Larger eigenvalues indicate more important components.
# They help determine how many components to retain based on the variance they explain.

# The first component has the largest eigenvalue and explains the most variance, followed by the others.
# Eigenvalues also help decide how many components to retain, typically choosing those explaining 80-90% of the variance.

pca1$c1 # loadings of the principal components

#LOADINGS represent the CORRELATION between the original
#variables and the new principal components: they go from -1 to +1 

pca1$li # scores of the principal components.

#SCORES are the actual values of the principal components, that is
#the coordinates of our observations (=points) after spatial transformation.
#The scores do not have a meaning per se, but are useful to produce
#graphical representations of the data

plot(pca1$li[,1],pca1$li[,2],xlab="PC1",ylab="PC2",type="n")

# type=”n” argument: it produces an EMPTY scatterplot, with just the x and y axes.

#use secondary functions to detail the information to put
#in the space of the plot. For example, we may want to put the NAMES
#OF THE CITIES as “points” in the plot with the “text()” function:
 
text(pca1$li[,1],pca1$li[,2],labels=abbreviate(row.names(data)),cex=0.7)

#more elaborate labels for the two axes,
#containing information about the amount of variance explained by each PC:
  
  
lab1=paste("PC1 (",round(perc.eig[1],2),"% of total variance)",sep="")
lab2=paste("PC2 (",round(perc.eig[2],2),"% of total variance)",sep="")

plot(pca1$li[,1],pca1$li[,2], xlab=lab1, ylab=lab2, sep="",type="n")

text(pca1$li[,1],pca1$li[,2],labels=abbreviate(row.names(data)),cex=0.7)

#SO MUCH CONFUSION WITH A LOT OF WARNINGS:

# The parameter `sep` was incorrectly passed to the `plot()` function, which does not recognize it.
# The `sep` parameter is specific to functions like `paste()` for string concatenation, 
# but it is invalid for `plot()`. This caused warnings about the unrecognized parameter.
#
# Solution: Remove `sep=""` from the `plot()` function call.
# Correct version:
plot(pca1$li[,1], pca1$li[,2], xlab=lab1, ylab=lab2, type="n")
text(pca1$li[,1],pca1$li[,2],labels=abbreviate(row.names(data)),cex=0.7)


#There is a second function that we can use to produce a scatterplot,
#which is part of the ade4 library and is used to put labels in a scatterplot:

s.label(pca1$li,xax=1,yax=2)

#This function is much easier to use, but it is also less flexible, but
#cannot intervene on any graphical parameter.

#The first argument
#the section of the pca1 object containing the scores, 

#while the other arguments
#will take the number of the PCs to be represented in the plot.


#We may also want to add a mini-barplot that highlights the magnitude of
#the kept principal components through their eigenvalues:
  
add.scatter.eig(pca1$eig,nf=3,xax=1,yax=2,posi="bottomleft")


#What about the loadings?

#THAT  represent the CORRELATION between the original
#variables and the new principal components: they go from -1 to +1 

#SO If their number is limited, we can plot them using a “correlation circle”
#with the function s.corcircle() that can be found in the package ade4.

#Particular type of scatterplot that represents each loading as an
#arrow with the name of the original variable as a label at the pointy end
#of the arrow:

s.corcircle(pca1$c1,xax=1,yax=2)

#In this plot, length and slope of each arrow highlight the association
#between each original variable and the principal components; looking at
#the PCA and loadings plot side by side, we can associate particular
#environmental phenomena to the distribution of observations in the
#two-dimensional plane

#################################################################

#EXERCISE***
#  The variable SO2 was excluded by the previous computation: since
#this is a relevant indicator of air pollution, it may be interesting to
# analyze its relationship with the variables synthesized by the PCA.
#Perform a simple linear regression analysis of SO2 with the first
#two principal components and comment on the results

names(data)

first_comp <- pca1$li[,1]
second_comp <- pca1$li[,2]

mod=lm(data[, 1]~first_comp + second_comp, data=data)

# View the summary of the regression model
summary(mod)

# Extract residuals and fitted values
residuals <- resid(mod)
fitted_values <- fitted(mod)

# Output residuals and fitted values for further inspection
print("Residuals:")
print(residuals)

print("Fitted Values:")
print(fitted_values)




########################## QUESTO è TUTTO IN PIù PER CURIOSITà



#To plot the simple regression for SO2 against one of the principal components

# Extract SO2 and the first principal component (PC1)
SO2 <- data[, 1]  # Assuming SO2 is the first column in the dataset
PC1 <- pca1$li[, 1]  # Scores for the first principal component

# Fit a simple linear regression model
simple_mod <- lm(SO2 ~ PC1)

# Create the scatterplot
plot(PC1, SO2, 
     main = "Simple Regression: SO2 vs PC1", 
     xlab = "PC1 Scores", 
     ylab = "SO2 Concentration", 
     pch = 16, 
     col = "blue")

# Add the regression line
abline(simple_mod, col = "red", lwd = 2)



###Model Equation and R² to the Plot

# Add regression line and equation to the plot
plot(PC1, SO2, 
     main = "Simple Regression: SO2 vs PC1", 
     xlab = "PC1 Scores", 
     ylab = "SO2 Concentration", 
     pch = 16, 
     col = "blue")

# Add the regression line
abline(simple_mod, col = "red", lwd = 2)

# Extract coefficients
coeffs <- coef(simple_mod)
eq <- paste0("y = ", round(coeffs[2], 2), "x + ", round(coeffs[1], 2))

# Calculate R-squared
r_squared <- summary(simple_mod)$r.squared
r_squared_text <- paste0("R² = ", round(r_squared, 2))

# Add text to the plot
legend("topleft", legend = c(eq, r_squared_text), bty = "n", col = c("red", "black"))

##########################################












#DISTANCE MATRICES

#analysing a multivariate dataset of quantitative variables, it is often
#useful to compute measures of distance between observations (the ROWS of the dataset) 
#before applying other multivariate methods.

#we are computing a POSITIVE value in a multi-dimensional
#plane indicating how distant any two observations are based on the
#available variables. 

#If the distance is equal to zero, we are dealing with
#two IDENTICAL variables with the same characteristics.

#Once computed the distance among all pairs of observations the
#collection of all distance measures will assume the form of a matrix

#This matrix has specific characteristics:

#1) it is a SQUARE matrix with an equal number of rows and columns,
and the number of rows and columns is equal to the number of
data observations;

#2) the diagonal is made up of zeroes, because we are comparing
each observation with itself;

#3) the matrix is SYMMETRICAL with respect to the diagonal

#In R, we can recover a default example for a triangular distance matrix:
  
data(eurodist)

#and convert it from its triangular from to a square matrix:
  
eurodist.full=as.dist(eurodist,diag=T,upper=T)

#as an example the dataset “cult.csv”, which contains data
#relative to sociocultural variables for 10 American cities.

cult=read.csv("cult.csv")

#dataset has to be BALANCED OUT!
  
cult.std = scale(cult)
cult.dist.q=dist(cult.std,diag=T,upper=T)

#or

cult.dist.t=dist(cult.std)







#MULTIDIMENSIONAL SCALING

#Multidimensional Scaling (MDS) is possibly the most used. 

#it is a hypothesis-free method and exploratory analysis that
#represents the data points in a two-dimensional space, trying to best fit
#the multidimensional coordinates in a plane. 

#two families of MDS.

#############METRIC MDS transforms the distance matrix in a set of bidimensional
#coordinates so that the original distance relationships between
#observations are maintained at scale.

###as an example the default dataset “swiss”, which contains
#information on fertility and socioeconomic measures for 47 cities in
#Switzerland for the year 1888.

data(swiss)

#We can balance out the dataset and compute the distance matrix:
swiss.dist=dist(scale(swiss))

#Then we can compute the metric MDS with the appropriate function:
swiss.mds=cmdscale(swiss.dist)

#The default output is a matrix containing coordinates for our
#observations in a two-dimensional space

#As with the PCA, we can proceed to a graphical rendition of the data:

plot(swiss.mds,type="n")
text(swiss.mds,labels=rownames(swiss))

###The interpretation of the result is very similar to the PCA; 

#it is important to keep in mind that the dimensions computed in the MDS
#have EQUAL WEIGHT in the plot so they provide the same contribution
#in explaining the variability of the final data distribution.

#Also, there are no loadings, so it is impossible to “backtrack” which 
#starting variables have contributed the most to each MDS dimension.

###########NON-METRIC MDS starts from a metric computation of the MDS and
#then tries to reduce a parameter called STRESS. 

#The stress parameter
#is a measure of how much the resulting configuration of the data points
#DIFFERS from the original matrix and is essentially a measure of the
#average difference in distance among the new points in space and
#among the original points in space.

#The most popular non-metric distance method is the Kruskal method,
#which is implemented by the “isoMDS” function in the library MASS:

library(MASS)

swiss.kmds=isoMDS(swiss.dist)

#The computation of the MDS measures is an iterative procedure that
#stops when convergence is reached (that is, until it is impossible to
#                                   change the stress parameter anymore).

plot(swiss.kmds$points,type="n")
text(swiss.kmds$points,labels=labels(swiss.dist))

#The output of a non-metric MDS contains two values: a table of
#measures (swiss.kmds$points) and a stress value (swiss.kmds$stress).




####EXERCISE***
#Apply the metric and non-metric MDS to the matrix “eurodist”. Plot
#them by using the names of cities as labels.



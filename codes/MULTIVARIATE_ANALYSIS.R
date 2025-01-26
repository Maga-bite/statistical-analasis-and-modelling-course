#MULTIVARIATE ANALYSIS

#dedicated to datasets that include a high number of variables. 

#all variables are treated equally and at the same
#time, so that there is no “preferred” variable at the start.

#(unlike regression models where variables are separated in dependent and independent) 

#######################################

#do not work through stochastic methods and statistical
#significance, but their aim is to provide a general outlook at the variability

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

#1) the new variables are ordered by proportion of explained variance

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
#analyse its relationship with the variables synthesized by the PCA.
#Perform a simple linear regression analysis of SO2 with the first
#two principal components and comment on the results

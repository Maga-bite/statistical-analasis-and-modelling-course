#Finally, perform a hierarchical clustering of the “iris” dataset applying the
#“complete” method. Compare the obtained three clusters to the original
#species classification and provide a graphical result by recoloring one of the
#scatterplots produced in step 1 with the new classification. Comment on the
#results.

names(iris)

SP <- "Sepal.Length" 
SW <- "Sepal.Width"  
PL <- "Petal.Length" 
PW <- "Petal.Width"  
SP <- "Species"

iris_table <- iris

#Removal of the column "Species" since it is qualitative and not numerical  
#Clustering is performed with only numerical objects

iris_numeric <- iris_table[, -ncol(iris_table)] #since the column "Species" is the last one

#Reduction to the 4 variables: 
#"Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"

#After scaling the dataset that gives 
#Equal Weighting: Features in different units or scales can dominate distance calculations, leading to biased results. 
#Improved Accuracy: Scaling ensures each feature contributes equally, helping to identify the true data structure. 
#Consistency: Distance metrics like Euclidean distance are sensitive to scale; scaling ensures consistent and meaningful distances.

#it is time for the computation of the distance matrix to define the distance between the new group and
#the rest of the data points.

iris_dist=dist(scale(iris_numeric))

#as this default method is implemented with:
iris_hc=hclust(iris_dist)

#the distance between pairs of clusters is defined as the
#maximum value of all possible distances between elements of the two clusters.

#we know that the 150 samples have been assigned to
#three different species:
print(unique(iris_table$"Species"))

table(iris_table$"Species")

#The species assigned are: "setosa", "versicolor", "virginica"

iris_labels = c(rep("setosa", 50), rep("versicolor", 50), rep("virginica", 50))

plot(iris_hc, labels=iris_labels, main = "Dendrogram for Iris Dataset", xlab = "Species", ylab = "Height", cex=0.5)


#This function produces a vector that defines the belonging to one of the 3 groups.
iris_hc2=cutree(iris_hc,k=3)

#Now, we can test the performance of the clustering method by comparing 
#the original classification with the clustering:

table (iris_labels,iris_hc2)

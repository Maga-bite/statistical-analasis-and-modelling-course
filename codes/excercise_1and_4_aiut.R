###ESERCIZIO 1

# Install and load necessary package
install.packages("dichromat")
library(dichromat)

# Define the original color palette
original_colors <- c("red", "blue", "green")

# Simulate color palettes for different types of colorblindness
protan <- dichromat(original_colors, type = "protan")
deutan <- dichromat(original_colors, type = "deutan")
tritan <- dichromat(original_colors, type = "tritan")

# Loading the iris dataset
iris_table <- iris
species_names <- unique(iris_table$"Species")

# Print species info
print(species_names)
table(iris_table$"Species")

# Map species to original colors and colorblind-simulated colors
species_colours_original <- c("setosa" = "red", 
                              "versicolor" = "blue", 
                              "virginica" = "green")

species_colours_deutan <- c("setosa" = deutan[1], 
                            "versicolor" = deutan[2], 
                            "virginica" = deutan[3])

# Shapes for the species (consistent across plots)
species_shapes <- c("setosa" = 17, "versicolor" = 15, "virginica" = 19)


# Creating scatterplots

# 1

plot(iris$Petal.Length, iris$Petal.Width, 
     col = species_colours_deutan[iris$Species], 
     pch = species_shapes[iris$Species], 
     xlab = "Petal Length(cm)", ylab = "Petal Width(cm)", asp = 2,
     main = "Petal Length vs Width")
legend("topleft", legend = names(species_colours_deutan), 
       col = species_colours_deutan, 
       pch = species_shapes, cex = 1)

#2
plot(iris$Sepal.Length, iris$Sepal.Width, 
     col = species_colours_deutan[iris$Species], 
     pch = species_shapes[iris$Species], 
     xlab = "Sepal Length(cm)", ylab = "Sepal Width(cm)", asp = 2, 
     main = "Sepal Length vs Width")  
legend("topleft", legend = names(species_colours_deutan), 
       col = species_colours_deutan, 
       pch = species_shapes, cex = 1) 

#3

# Setting up the plotting area to produce a multi-panel plot with 1 row and 2 columns.
par(mfrow = c(1, 2), oma = c(0, 0, 3, 0), mar = c(5, 4, 4, 2) + 0.1) # Adjusting outer and inner margins


plot(iris$Petal.Length, iris$Petal.Width, 
     col = species_colours_deutan[iris$Species], 
     pch = species_shapes[iris$Species], 
     xlab = "Petal Length(cm)", ylab = "Petal Width(cm)", asp = 2,
     main = "Petal Length vs Width")
legend("topleft", legend = names(species_colours_deutan), 
       col = species_colours_deutan, 
       pch = species_shapes, cex = 1)

plot(iris$Sepal.Length, iris$Sepal.Width, 
     col = species_colours_deutan[iris$Species], 
     pch = species_shapes[iris$Species], 
     xlab = "Sepal Length(cm)", ylab = "Sepal Width(cm)", asp = 2, 
     main = "Sepal Length vs Width")  
legend("topleft", legend = names(species_colours_deutan), 
       col = species_colours_deutan, 
       pch = species_shapes, cex = 1) 

# Adding a common title for both plots.
mtext("Petal and Sepal Scatterplots", side = 3, outer = TRUE, 
      line = -1, cex = 1.5) # Adds a title to the entire plotting area.

# Resetting plotting parameters to avoid that future subsequent plots might 
#nherit the multi-panel layout.
par(mfrow = c(1, 1))








################################################################################

###ESERCIZIO 4

#Compare the obtained three clusters to the original
#species classification and provide a graphical result by recoloring one of the
#scatterplots produced in step 1 with the new classification. Comment on the
#results.

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
iris_hc = hclust(iris_dist)

#the distance between pairs of clusters is defined as the
#maximum value of all possible distances between elements of the two clusters.

---------------------------------------
  
#we know that the 150 samples have been assigned to
#three different species:
print(unique(iris_table$"Species"))
species_names <- unique(iris_table$"Species")
table(iris_table$"Species")

#The species assigned are: "setosa", "versicolor", "virginica"

iris_labels = c(rep("setosa", 50), rep("versicolor", 50), rep("virginica", 50))

plot(iris_hc, labels=iris_labels, main = "Dendrogram for Iris Dataset", xlab = "Species", ylab = "Height", cex=0.5)
  
#FOR A BETTER DENDOGRAM
  
# Install and load the dendextend package
install.packages("dendextend")
library(dendextend)

dend <- as.dendrogram(iris_hc)

# Assign labels to the dendrogram
labels_colors(dend) <- protan[iris$Species]

# Color the branches based on the clusters
dend <- color_branches(dend, k = 3, col = deutan)

# Remove the labels
labels(dend) <- NULL

# Plot the customized dendrogram without labels
par(mar = c(5, 4, 4, 6) + 0.1)  # Increase the right margin
plot(dend, main = "Dendrogram for Iris Dataset", horiz = FALSE, las=1)
legend("topright", legend = species_names, fill = protan, title = "Clusters", xpd = TRUE, cex = 1)

----------------------------------------
  
#This function produces a vector that defines the belonging to one of the 3 groups.
iris_clusters = cutree(iris_hc, k=3)

iris$iris_clusters <- iris_clusters

#Now, we can test the performance of the clustering method by comparing 
#the original classification with the clustering:

contingency_table <- table (iris$iris_clusters, iris$Species)

print(contingency_table)

#prepearing the clustering colours in a way that enables colorblind people to use it

cluster_colors <- dichromat(c("red", "blue", "green"), type = "deutan")

plot(iris$Petal.Length, iris$Petal.Width, 
     col = cluster_colors[iris_clusters], 
     pch = species_shapes[iris$Species], 
     xlab = "Petal Length(cm)", ylab = "Petal Width(cm)", asp = 2,
     main = "Clusters vs Petal Length and Width")

legend("topleft", legend = unique(iris_clusters), 
       col = cluster_colors, 
       pch = 19, cex = 1, title = "Clusters")

legend("bottomright", legend = names(species_shapes), 
       col = "black", 
       pch = species_shapes, cex = 1, title = "Species")

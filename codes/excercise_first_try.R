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











################################################################################################################################################################
###ESERCIZIO 4

#Finally, perform a hierarchical clustering of the “iris” dataset by applying the
#“complete” method. Compare the obtained three clusters to the original
#species classification and provide a graphical result by recoloring one of the
#scatterplots produced in step 1 with the new classification. Comment on the
#results.

-------------------------------

#COLORBLINDNESS FRIENDLY

#https://onlinelibrary.wiley.com/doi/full/10.1002/env.2877#env2877-bib-0011

#install dichromat
install.packages("dichromat")
library(dichromat)

# define the color palette
original_colors <- c("red", "green", "blue")

# simulation for the different types of colorblindness
protan <- dichromat(original_colors, type = "protan")
deutan <- dichromat(original_colors, type = "deutan")
tritan <- dichromat(original_colors, type = "tritan")

# graphs to confront the palettes
par(mfrow = c(2, 2))
barplot(1:3, col = original_colors, main = "Original Colors")
barplot(1:3, col = protan, main = "Protanopia")
barplot(1:3, col = deutan, main = "Deuteranopia")
barplot(1:3, col = tritan, main = "Tritanopia")


-----------------
  
names(iris)

SP <- "Sepal.Length" 
SW <- "Sepal.Width"  
PL <- "Petal.Length" 
PW <- "Petal.Width"  
SP <- "Species"


--------------------------------------------------------------------

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
species_names <- unique(iris_table$"Species")
table(iris_table$"Species")

#The species assigned are: "setosa", "versicolor", "virginica"

iris_labels = c(rep("setosa", 50), rep("versicolor", 50), rep("virginica", 50))

plot(iris_hc, labels=iris_labels, main = "Dendrogram for Iris Dataset", xlab = "Species", ylab = "Height", cex=0.5)

----------------------------------------
  
#FOR A BETTER DENDOGRAM

# Install and load the dendextend package
install.packages("dendextend")
library(dendextend)

dend <- as.dendrogram(iris_hc)

# Assign labels to the dendrogram
labels_colors(dend) <- protan[iris$Species]

# Color the branches based on the clusters
dend <- color_branches(dend, k = 3, col = protan)

# Remove the labels
labels(dend) <- NULL

# Plot the customized dendrogram without labels
par(mar = c(5, 4, 4, 6) + 0.1)  # Increase the right margin
plot(dend, main = "Dendrogram for Iris Dataset", horiz = FALSE, las=1)
legend("topright", inset = c(-0.25, 0), legend = species_names, fill = protan, title = "Clusters", xpd = TRUE, cex = 0.6)

----------------------------------------
  
#This function produces a vector that defines the belonging to one of the 3 groups.
iris_hc2=cutree(iris_hc,k=3)

#Now, we can test the performance of the clustering method by comparing 
#the original classification with the clustering:

table (iris_labels,iris_hc2)


rect.hclust(data_hc, k = 3, border = protan)

# Tagliare il dendrogramma in 3 cluster
data_hc2 <- cutree(data_hc, k = 3)


#want to “split” it in three groups by using the following functions:

rect_hclust (trees.hc,k=2,border=2:3)

#secondary graphical function that adds rectangles of
#different colors (as defined by the “border=” argument) 



#######################################################SISTEMATO DA COPILOT

# Installare e caricare i pacchetti necessari
install.packages(c("dichromat", "dendextend"))
library(dichromat)
library(dendextend)

# Definire la funzione per il clustering gerarchico e la visualizzazione
create_colorblind_friendly_dendrogram <- function(data, species_col) {
  # Rimuovere la colonna delle specie per il clustering
  data_numeric <- data[, -which(names(data) == species_col)]
  
  # Calcolare la matrice delle distanze e il clustering gerarchico
  data_dist <- dist(scale(data_numeric))
  data_hc <- hclust(data_dist, method = "complete")
  
  # Convertire il clustering in un dendrogramma
  dend <- as.dendrogram(data_hc)
  
  # Definire la palette di colori colorblind-friendly
  original_colors <- c("red", "green", "blue")
  protan <- dichromat(original_colors, type = "protan")
  
  # Assegnare i colori ai rami del dendrogramma
  labels_colors(dend) <- protan[data[[species_col]]]
  dend <- color_branches(dend, k = 3, col = protan)
  
  # Rimuovere le etichette
  labels(dend) <- NULL
  
  # Creare il grafico del dendrogramma
  par(mar = c(5, 4, 4, 6) + 0.1, las = 1)
  plot(dend, main = "Dendrogram for Iris Dataset", horiz = FALSE)
  legend("topright", inset = c(-0.25, 0), legend = unique(data[[species_col]]), fill = protan, title = "Clusters", xpd = TRUE, cex = 0.6)
  
  # Aggiungere rettangoli intorno ai cluster
  rect.hclust(data_hc, k = 3, border = protan)
  
  # Tagliare il dendrogramma in 3 cluster
  data_hc2 <- cutree(data_hc, k = 3)
  
  # Confrontare i cluster ottenuti con la classificazione originale
  comparison <- table(data[[species_col]], data_hc2)
  print(comparison)
}

# Esempio di utilizzo della funzione
create_colorblind_friendly_dendrogram(iris, "Species")


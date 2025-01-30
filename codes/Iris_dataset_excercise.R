# Install and load necessary package
install.packages("dichromat")
library(dichromat)

# Define the original color palette
original_colors <- c("red", "blue", "green")

# Simulate color palettes for different types of colorblindness
protan <- dichromat(original_colors, type = "protan")
deutan <- dichromat(original_colors, type = "deutan")
tritan <- dichromat(original_colors, type = "tritan")

Petal.Width=(iris$Petal.Width) 
Sepal.Width=(iris$Sepal.Width) 
Petal.Length=(iris$Petal.Length) 
Sepal.Length=(iris$Petal.Length)

################################################################################

#EXCERCISE 1

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

# Setting up the plotting area to produce a multi-panel plot with 1 row and 2 columns.
# Adjusting outer and inner margins
par(mfrow = c(1, 2), oma = c(0, 0, 3, 0), mar = c(5, 4, 4, 2) + 0.1) 

plot(iris$Petal.Length, iris$Petal.Width, 
     col = species_colours_deutan[iris$Species], 
     pch = species_shapes[iris$Species], 
     xlab = "Petal Length(cm)", ylab = "Petal Width(cm)", 
     asp = 2, las=1,
     main = "Petal Length vs Width")
legend("topleft", legend = names(species_colours_deutan), 
       col = species_colours_deutan, 
       pch = species_shapes, cex = 1)

plot(iris$Sepal.Length, iris$Sepal.Width, 
     col = species_colours_deutan[iris$Species], 
     pch = species_shapes[iris$Species], 
     xlab = "Sepal Length(cm)", ylab = "Sepal Width(cm)", 
     asp = 2, las=1,
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

dev.off()


#EXCERCISE 2

# Linear regression for petal length vs. petal width
petal_lm <- lm(Petal.Width ~ Petal.Length, data = iris_table)

# Linear regression for sepal length vs. sepal width
sepal_lm <- lm(Sepal.Width ~ Sepal.Length, data = iris_table)

par(mfrow = c(1, 2), oma = c(0, 0, 3, 0), mar = c(5, 4, 4, 2) + 0.1)

# Plotting Petal Variables
plot(iris$Petal.Length, iris$Petal.Width,
     xlab = "Petal Length", ylab = "Petal Width",
     main = "Petal Length vs Width", 
     pch = 19, las=1, col = "gray69")
abline(petal_lm, col = "red3", lwd = 2)

# Plotting Sepal Variables

plot(iris$Sepal.Length, iris$Sepal.Width,
     xlab = "Sepal Length", ylab = "Sepal Width",
     main = "Sepal Length vs Width", 
     pch = 19, las=1, col = "gray69")
abline(sepal_lm, col = "red3", lwd = 2)

mtext("Linear regression", side = 3, outer = TRUE, 
      line = -1, cex = 1.5) # Adds a title to the entire plotting area

dev.off()


#EXCERCISE 3

################################################################################
#I just modified the asp (aspect ratio) and the colorurs but at the end
#I don't think we are required to do the q-q plot from the excercise 3

par(mfrow = c(1, 2), oma = c(0, 0, 3, 0), mar = c(5, 4, 4, 2) + 0.1)

qqplot.Petalwidth.pdf = qqnorm(Petal.Width, 
                               main = "Q-Q plot of Petal Width", 
                               col = "gray42", 
                               asp=4, las=1,
                               pch = 18)

qqline(Petal.Width, col = "blue", lwd = 1)

qqplot.Sepalwidth.pdf = qqnorm(Sepal.Width, 
                               main = "Q-Q plot of Sepal Width", 
                               col = "gray42", 
                               asp=4, las=1,
                               pch = 18)

qqline(Sepal.Width, col = "red", lwd = 2)

mtext("Q-Q plot for sepal and petal width", side = 3, outer = TRUE, 
      line = -1, cex = 1.5) # Adds a title to the entire plotting area
################################################################################

#shapiro test

petal_width_shapiro = shapiro.test(Petal.Width)
petal_width_shapiro

# Shapiro-Wilk normality test
# data:  Petal.Width
# W = 0.90183, p-value = 1.68e-08

sepal_width_shapiro = shapiro.test(Sepal.Width)
sepal_width_shapiro

# Shapiro-Wilk normality test
# data:  Sepal.Width
# W = 0.98492, p-value = 0.1012


#Histogram for the petal width

par(mfrow = c(1, 2), oma = c(0, 0, 3, 0), mar = c(5, 4, 4, 2) + 0.1)

histo.Petal.Width.pdf = hist(Petal.Width, 
                             main = "Histogram of Petal Width", 
                             freq = F, 
                             col = deutan[3],
                             asp = 2, las=1,
                             xlab = "Petal Width")
Pd = density(Petal.Width)
lines(Pd, col = deutan[2])


#Histogram for the sepal width

histo.Sepal.Width.pdf = hist(Sepal.Width, 
                             main = "Histogram of Sepal Width", 
                             freq = F, 
                             col = deutan[1], 
                             asp = 2, las=1,
                             xlab = "Sepal Width")
Sd = density(Sepal.Width)
lines(Sd, col = deutan[2])

mtext("Histograms plot for sepal and petal width", side = 3, outer = TRUE, 
      line = -1, cex = 2) # Adds a title to the entire plotting area




#EXCERCISE 4

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

#This function produces a vector that defines the belonging to one of the 3 groups.
iris_clusters = cutree(iris_hc, k=3)

iris$iris_clusters <- iris_clusters

#Now, we can test the performance of the clustering method by comparing 
#the original classification with the clustering:

contingency_table <- table (iris$iris_clusters, iris$Species)

print(contingency_table)

#setosa versicolor virginica
#1     49          0         0
#2      1         21         2
#3      0         29        48

#prepearing the clustering colours in a way that enables colorblind people to use it

cluster_colors <- dichromat(c("red", "blue", "green"), type = "deutan")

plot(iris$Petal.Length, iris$Petal.Width, 
     col = cluster_colors[iris_clusters], 
     pch = species_shapes[iris$Species], 
     xlab = "Petal Length(cm)", ylab = "Petal Width(cm)", 
     asp = 2, las=1,
     main = "Clusters vs Petal Length and Width")

legend("topleft", legend = unique(iris_clusters), 
       col = cluster_colors, 
       pch = 19, cex = 1, title = "Clusters")

legend("bottomright", legend = names(species_shapes), 
       col = "black", 
       pch = species_shapes, cex = 1, title = "Species")

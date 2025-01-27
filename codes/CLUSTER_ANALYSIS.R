#CLUSTER ANALYSIS

# “clustering” we are usually referring to a vast family of
#methods to “detect groups” inside a datase

#What is the starting point for recognizing similarity in the data? 
#A distance matrix, just like MDS!

#HIERARCHICAL CLUSTERING

#produce a tree-like representation called DENDROGRAM, 
#illustrating the relationship between the analytical units

#based on the computation of a distance matrix, 
#which can be computed in several ways.

#use the “trees” dataset, a default dataset in R, as an example.

#We can compute the distance matrix after scaling the dataset:

trees.dist=dist(scale(trees))

#clustering methods usually tend to beAGGLOMERATIVE methods

#as each new group is built, a new distance matrix is 
#computed to define the distance between the new group and
#the rest of the data points, and is used to connect the groups with the
#lowest distance

# We will use three: 

#the complete linkage method, 
#the average method, and 
#the Ward method.


#                                   “complete linkage” method 
#is the default method implemented 

trees.hc=hclust(trees.dist)

#In this method, the distance between a pair of clusters is defined as the
#maximum value of all possible distances between elements of the two
#clusters.

plot(trees.hc)

#suppose that we know that our trees have been assigned to
#two different species, A and B:

trees.labels = c(rep("A", 15), rep("B", 16))

plot(trees.hc, labels=trees.labels, cex=0.7)

#want to “split” it in two groups by using the following functions:
  
rect.hclust (trees.hc,k=2,border=2:3)

#secondary graphical function that adds rectangles of
#different colors (as defined by the “border=” argument) 

trees.hc2=cutree(trees.hc,k=2)

#The second function produces a vector that defines the belonging to one
#of the two groups.

#Now, we can test the performance of the clustering method by
#comparing the original classification with the clustering:
  
table (trees.labels,trees.hc2)



#                                   “average” method

#Here, distance between two clusters A and B is the average between all elements 
#in A and all elements in B. 

#Clustering will proceed by putting together groups with minimal distance.

trees.ha=hclust(trees.dist,method="average")

plot(trees.ha,labels=trees.labels,cex=0.7)

rect.hclust(trees.ha,k=2,border = 2:3)

trees.ha2=cutree(trees.ha,k=2)

table(trees.labels,trees.ha2)

#                                   "Ward method”

#variance-based method and posits that any two clusters can be put together 
#when they minimize the increase in the total variance of the dataset.

trees.hw=hclust(trees.dist,method="ward.D")

plot(trees.hw,labels=trees.labels,cex=0.7)

rect.hclust(trees.hw,k=2,border = 2:3)

trees.hw2=cutree(trees.hw,k=2)

table(trees.labels,trees.hw2)

#Now, remember that there is no “correct” method and we cannot say that
#one is better than the other.

#Different methods use different types of reasoning to perform clustering, 
#and some methods just work better with some types of data. 

#A good suggestion is to do as we did, trying different
#methods and comparing their results: the data that appear as clusters in
#all tests are most probably reflecting the presence of real structure.


#EXERCISE***
#The “pesi.csv” file contains the weight of 23 cows of the charolais
#and zebu varieties (vif =live weight, carcasse = dead weight, viande1 = muscle, 
#viandetot = total muscle mass, gras = fat, os =bone, cla = variety). 

#Test the different clustering methods with the
#numeric variables in the dataset. Compare the number of clusters
#that you choose with the real classification of species.


cow <- read.csv("pesi.csv")  
# Versione chiara e semplice

cow_table <- read.table("pesi.csv", sep = ",", header = TRUE)  
# Versione più verbosa

#Rimuovi la colonna cla (che contiene la classificazione delle specie) 
#perché il clustering deve essere fatto solo sulle variabili numeriche.

cow_numeric <- cow_table[, -ncol(cow_table)]  # Supponendo che 'cla' sia l'ultima colonna

cow_scaled <- scale(cow_numeric)

cow_dist <- dist(cow_scaled)

#Metodo Complete Linkage
cow_hc_complete <- hclust(cow_dist, method = "complete")

plot(cow_hc_complete, labels = cow$cla, cex = 0.7)

rect.hclust(cow_hc_complete, k = 2, border = 2:3)

cow_hc_complete_groups <- cutree(cow_hc_complete, k = 2)

table(cow$cla, cow_hc_complete_groups)

#Metodo Average
cow_hc_average <- hclust(cow_dist, method = "average")

plot(cow_hc_average, labels = cow$cla, cex = 0.7)

rect.hclust(cow_hc_average, k = 2, border = 2:3)

cow_hc_average_groups <- cutree(cow_hc_average, k = 2)

table(cow$cla, cow_hc_average_groups)

#Metodo Ward:
cow_hc_ward <- hclust(cow_dist, method = "ward.D")

plot(cow_hc_ward, labels = cow$cla, cex = 0.7)

rect.hclust(cow_hc_ward, k = 2, border = 2:3)

cow_hc_ward_groups <- cutree(cow_hc_ward, k = 2)

table(cow$cla, cow_hc_ward_groups)

# Imposta il layout con 1 riga e 3 colonne
par(mfrow = c(1, 3))  

# Metodo Complete Linkage
plot(cow_hc_complete, labels = cow$cla, cex = 0.7, main = "Complete Linkage")
rect.hclust(cow_hc_complete, k = 2, border = 2:3)

# Metodo Average Linkage
plot(cow_hc_average, labels = cow$cla, cex = 0.7, main = "Average Linkage")
rect.hclust(cow_hc_average, k = 2, border = 2:3)

# Metodo Ward
plot(cow_hc_ward, labels = cow$cla, cex = 0.7, main = "Ward Method")
rect.hclust(cow_hc_ward, k = 2, border = 2:3)

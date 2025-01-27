### Vectors, Matrices and Dataframes

c(1,2,3,4) # function that concatenates different object "X" or numbers, and produces any kind of vectors
c(1:4)

seq(4,10) # generats numerical sequences only, it is similar to the use of ":" but allows more flexibility
seq(4,10,2) # the 2 indicates the increment in the numerical sequence

rep(1,10) #this function replicates an object the desired amount of times
# it is possible to provide two vectors but they have to be of the same lenght 
rep(c(2,5,7),2:4)
#in this case the concatenated object gets repeated 2,3 and then 4 times (2 2 5 5 5 7 7 7 7)

#EXERCISE 1***
#Find a way to generate a sequence of numbers from 1 to 9 IN
#REVERSE, separately for the c(), “:” and seq() functions.

c(9,8,7,6,5,4,3,2,1)
c(9:1)
seq(9,1,-1)

#EXERCISE 2***
#Find a way to use the seq() function to generate the sequence of
#numbers from 1 to 9, IN REVERSE and with a spacing of 2.

seq(1,9,2)

#also there is the command rev that does that
rev(1:9)


#paste() #glues togheter vectors
labels=paste(rep("A",10),1:10,sep="_")
labels
#"A_1"  "A_2"  "A_3"  "A_4"  "A_5"  "A_6"  "A_7"  "A_8"  "A_9"  "A_10"


#***EXERCISE 3***
#Build a vector that contains the even numbers from 1 to 15, followed by
#the odd numbers from 1 to 15. The whole sequence is repeated twice.
#Check the vector class.

even_numbers <- seq(2, 15, by = 2)
odd_numbers <- seq(1, 15, by = 2)
sequence <- c(even_numbers, odd_numbers)
final_vector <- rep(sequence, times = 2)
# check the vector class
class(final_vector)

***EXERCISE 4***
#Glue element by element: the uppercase letters of the alphabet in their
#correct order; the lowercase letters of the alphabet in their REVERSE
#order; the odd numbers from 52 to 1. Use the colon “:” as a separator.
#Check the vector class.

uppercase_letters <- LETTERS
lowercase_letters <- rev(letters)
odd_numbers <- seq(51, 1, by = -2)
glued_vector <- paste(uppercase_letters, lowercase_letters, odd_numbers, sep = ":")
class(glued_vector)


#RANDOM SAMPLING and SELECTION WITH VECTORS

#EXERCISE 5***
#Simulate the result of 100 throws of an UNFAIR coin in which getting
#tails is twice as likely as getting heads. Try three simulations and
#compute summaries each time, considering the states of the coin as
#factors. Do you get the expected proportion of tails when compared to
#heads?

set.seed(123)
simulate_coin_throws <- function(n) {
  prob <- c(1/3, 2/3)
  sample(c("T", "C"), size = n, replace = TRUE, prob = prob)
}
simulations <- replicate(3, simulate_coin_throws(100), simplify = FALSE)
summaries <- lapply(simulations, function(sim) {
  summary(factor(sim, levels = c("T", "C")))
})
table(summaries)

***EXERCISE 6***
#Build a vector containing all decimal numbers between 1 and 2 with an
#increment of 0.001. Then, extract 100 random elements from it and put
#them in a second vector. Compute all the deciles of the vector you have
#just produced. Finally, extract from this vector only the values greater
#than 1.4 and compute the quartiles of the resulting vector.

#FILTERING FUNCTION

#[] selects an object out of a vector and it is referred to the position mainly

b= r>16 # generates a Boolean vector of TRUE/FALSE statements
r1=r[b] # extracts only those elements of r that fulfill the TRUE statement

#these two commands may be reassuemed in one simple step
r1=r[r>5]

#EXERCISE 6***
#Build a vector containing all decimal numbers between 1 and 2 with an
#increment of 0.001. Then, extract 100 random elements from it and put
#them in a second vector. Compute all the deciles of the vector you have
#just produced. Finally, extract from this vector only the values greater
#than 1.4 and compute the quartiles of the resulting vector.

r <- seq(1,2, by=0.001)

set.seed(163)  # Setting seed for reproducibility
random_100_r <- sample(r, 100)

# Compute all the deciles
deciles <- quantile(random_100_r, probs = seq(0, 1, by = 0.1))
print(deciles)

#Extract values greater than 1.4
filtered_r <- random_100_r[random_100_r > 1.4]
print(filtered_r)

#Compute the quartiles of the resulting vector
quartiles <- quantile(filtered_r, probs = seq(0, 1, by = 0.25))
print(quartiles)


#MATRICES
matrix() #converts a homogeneous vector in a matrix, given that the number of rows are specified
# used to glue together vectors of the same length, either as ROWS or as COLUMNS of a matrix
rbind() #ROW
cbind() #COLLUMNS

a=1:7
b=8:14
M1=rbind(a,b)
M1=cbind(a,b)


#function to transpose the original matrix, i.e.inverting rows with columns:
M2=t(M1)
M2

dim(M1) # returns the number of rows and columns in a matrix
class(M1) # provides the class of the M object (which should be ‘matrix’)

#EXERCISE 7***
#Build a matrix containing:
#a) the odd numbers from 1 to 10
#b) the even numbers in reverse order from 10 to 1
#c) five repetitions of the numbers zero
#The matrix should have 5 rows and be filled BY COLUMNS.
#Finally, set the row names as lowercase letters, and the column names
#as uppercase letters.

r <- seq(1,10, by=2)
v <- seq(10,0, by=-2)
n <- rep(0,5)

M = matrix(c(r,v,n), nrow=5, byrow=F)
M
rownames(M)=letters[1:5]
colnames(M)=LETTERS[1:4]
M


#EXERCISE 7***
#Build a data frame containing:
#a) the even numbers from 1 to 100
#b) a logical vector containing 30 TRUE and 20 FALSE values
#c) 10 repetitions of the last five uppercase letters of the alphabet
#Explore the data frame with the appropriate functions.
 r <- seq(2,100,by=2)
 logical_vector <- c(rep(TRUE,30),rep(FALSE,20))
 letters_vector <- rep(LETTERS[22:26],10)
 DF <- data.frame (Even_numbers=r, Logical_Vector=logical_vector, Letters_Vector= letters_vector)
 
 class(DF) # object class (‘dataframe’)
 dim(DF) # number of observations and variables
 names(DF) # variable names (i.e., column names)
 head(DF) # shows the first 6 rows of the dataframe
 tail(DF) # shows the last 6 rows of the data frame
 str(DF) # provides information on the structure of the data frame
 summary(DF) # returns summary statistics for each variable in the data frame (note the difference in numeric and categorical variables)
 


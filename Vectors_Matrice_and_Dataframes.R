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

z = sample(c("T","C"),100,replce=TRUE,prob=(1/3, 2/3)
results <- table(z)
prob.table(results)
print(prob.table(results))
  
  
probabilities <- c(1/3, 2/3)  # Probabilità per Heads e Tails
states <- c("Heads", "Tails") # Stati della moneta
simulate_coin <- function() {
  sample(states, size = 100, replace = TRUE, prob = probabilities)
}
z<- simulate_coin
b<- simulate_coin
g<- simulate_coin

results <- table(z)
prob.table(results)
print(prob.table(results))

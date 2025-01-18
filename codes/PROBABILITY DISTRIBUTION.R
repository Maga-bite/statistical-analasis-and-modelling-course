#DISTRIBUTIONS IN R

dnorm() # point probability (or density probability) distribution
pnorm() # cumulative probability
qnorm() # theoretical quantiles
rnorm() # random number extraction

#PROBABILITY DISTRIBUTION:

dbinom() 
dnorm()

#example, let's toss a FAIR coin (p=0.5) a number of times equal to 10
# and we ask what the probability of obtaining heads (our “success” outcome) is 
#exactly 7 times.
dbinom(7,size=10,prob=0.5) 

#example for the normal distribution, we may ask what is the
#probability associated with a height of 165cm given a population of
#average height 175cm and a standard deviation of 10cm:
dnorm(165,mean=175,sd=10)

#RECONSTRUCTION OF THE WHOLE PROBABILITY DISTRIBUTION IN A PLOT

#general behavior of a binomial distribution of size equal to 50 and 
#probability of success equal to 0.33

x=c(0:50)
y=dbinom(x,size=50,prob=0.33)
plot(x, y, type="h") #H is the type of plot we want
#‘type="l"’ to approximate a linear continuity.

#CUMULATIVE PROBABILITY: pbinom() and pnorm()

#example, the probability of finding individuals with a cholesterol 
#value HIGHER THAN 160, if the population average is 132 and 
#the standard deviation is 13.

x=seq(80, 184, 0.5)
y = dnorm(x,mean=132,sd=13)
plot(x, y, type="l")

# For better graphical output, we can either add a horizontal
#segment representing the x axis:

segments(80,0,184,0)
abline(h=0, col="red")

#vertical segment connecting the x value to its
#associated probability on the distribution

probx=dnorm(160,mean=132,sd=13)
segments(160, 0, 160, probx, col="pink")

probz=dnorm(100,mean=132,sd=13)
segments(100, 0, 100, probz, col="red")

#what is the cumulative
#probability associated with the value 160 in this graph?

pnorm(160,mean=132,sd=13)
#Since we know that the total probability (that is, the area under
#the curve) is equal to 1, we can subtract the cumulative
#probability and obtain the answer  
p=1-pnorm(160,mean=132,sd=13)
p #0.01562612 and it is small, which means we are in the normal distribution


#LET'S LOOK AT THE BINOMIAL DISTRIBUTION AGAIN

# For example, let’s consider 20 patients subjected to two antibiotic
#treatments (A and B) that may induce headache as a side effect. For 16
#patients, however, the treatment A has produced no adverse outcomes.
#Is this enough to say that A is a better antibiotic in terms of side effects?

#it is required that we also build a reasonable hypothesis
#to define our expectations (the NULL HYPOTHESIS, or H0)
  
#Specifically,
#we may expect that if both treatments A and B have identical outcomes,
#the probability of inducing a headache will be the same, so p=0.5.

x=c(1:20)
y=dbinom(x,size=20,prob=0.5)
plot(x,y,type="h")

#let's put a segment corresponding to the value x= 16:
p= dbinom(16,size=20,prob=0.5)
segments(16, 0, 16, p, col="red")

#compute the cumulative probability, which is the sum of all
#point probabilities for values smaller than or equal to 16
pbinom(16,size=20,prob=0.5)

#obtaining values equal to or larger than 16
1-pbinom(16,size=20,prob=0.5)

#This is the probability of obtaining a value LARGER THAN 16.
#But we need the point probability of getting 16 as well

1-pbinom(15,size=20,prob=0.5)
1 - pbinom(16,size=20,prob=0.5) + dbinom(16,size=20,prob=0.5)

#The result allows us to REFUTE our null hypothesis that the two
#treatments have similar adverse effects

#NOTE ON THEORETICAL QUANTILES: qnorm()

#How can we compute the confidence interval of a normal distribution,
#using the example of a distribution with an average of 132 and a standard
#deviation 13?

#if the distribution is symmetrical around the
#median/average, then the confidence interval is also symmetrical

#interval will be delimited by two values of our variable, a LOWER limit
#and an UPPER limit, that will correspond to the values having 2.5% and
#97.5% cumulative probability, i.e. the 2.5%-quantile and the
#97.5%-quantile 

#compute the quantiles with the qnorm() function:

lowlim=qnorm(0.025,mean=132,sd=13)
upplim=qnorm(0.975,mean=132,sd=13) 
# The first argument is the cumulative probability of the quantile

#EXERCISE 1***
#Plot the graph of a normal distribution with an average of 132 and
# a standard deviation of 13.
#Add two red segments that define the limits of the confidence
#interval.
#Add a blue segment that meets the curve at the probability density
#associated with the value 160 of our variable.
#Finally, find a way to fill the confidence interval with the color
#orange

x=c(64:200)
y = dnorm(x,mean=132,sd=13)
plot(x, y, type="l")

lowlim=qnorm(0.025,mean=132,sd=13)
upplim=qnorm(0.975,mean=132,sd=13)

#segments(x0, y0, x1 = x0, y1 = y0,
#         col = par("fg"), lty = par("lty"), lwd = par("lwd"),

segments(lowlim, 0, y1 =  0.004495775, lowlim, col="red", lwd = 2)
segments(upplim, 0, y1 = 0.004495775, upplim, col="red", lwd = 2)

z = dnorm(160,mean=132,sd=13)
segments(160, 0, y1 = 0.003017235, 160, col="blue", lwd = 2)

x_fill <- seq(lowlim, upplim, length.out = 1000) # Generate x values within the CI
#length.out = 1000: Specifies that the sequence should contain 1000 evenly spaced points. 
#A higher number makes the shading smoother.

y_fill <- dnorm(x_fill, mean = 132, sd = 13)    # Corresponding y values

polygon(c(x_fill, rev(x_fill)), c(rep(0, length(x_fill)), rev(y_fill)),
        col = "orange", border = NA) # Fill the area between the curve and x-axis

#polygon: Combines the x and y values to create a filled polygon. 
#The c(x_fill, rev(x_fill)) ensures that the polygon is closed properly 
#by adding the x-values in reverse order. 
#Similarly, c(rep(0, length(x_fill)), rev(y_fill)) closes the bottom of the 
#polygon at y = 0.

# Add an orange line for the curve within the confidence interval in a way that
# ensures that it doesn't show any black part of the line
lines(x_fill, y_fill, col = "orange", lwd = 2) # lwd makes the line thicker


#RANDOM NUMBERS FROM A DISTRIBUTION: rnorm() and rbinom()

#sample() extracts values from a real vector
#rnorm() and rbinom() extract values from a theoretical distribution

#Here are some examples of random sampling:
rnorm(10) # 10 random values from a standard normal distribution

rnorm(10, mean=7, sd=5)
rbinom(10, size=20, prob=0.5)

#*EXERCISE COLLECTION***
#1. Given a standard normal distribution, what is the probability of
#obtaining a value:
#  - equal to 2?
#  - greater than 3?

p_2 <- dnorm(2)

p_greater_3 <- 1 - pnorm(3)

# The first exercise refers to a standard normal distribution, 
# meaning a normal distribution with:
# - Mean (μ) = 0
# - Standard deviation (σ) = 1
# The standard normal distribution is a normalized version of 
# the generic normal distribution, where every value (x) 
# represents how many standard deviations that value is 
# above or below the mean.

# 1. Probability of obtaining exactly 2
# This question has a subtle issue. In a continuous normal distribution, 
# the probability of a random variable taking on a single, exact value 
# is always zero. This is because probabilities in continuous distributions 
# are tied to intervals, not single points.
#
# When we calculate:
# dnorm(2)
# This does not give the probability but instead returns the probability density 
# (the height of the curve) at x = 2. The numeric value represents how "likely" 
# this value is compared to others but is not an actual probability.


#2. In a binomial distribution, what is the probability of obtaining:
#  - 10 successes out of 10 with probability p=0.8?
#  - at most 3 successes out of 20 with probability p=0.1?
#  - more than 3 successes out of 6 with probability p=0.5?

# 2.1 Probability of 10 successes out of 10 with p = 0.8
p_10_successes <- dbinom(10, size = 10, prob = 0.8)

# 2.2 Probability of at most 3 successes out of 20 with p = 0.1
p_at_most_3 <- pbinom(3, size = 20, prob = 0.1)

# 2.3 Probability of more than 3 successes out of 6 with p = 0.5
p_more_than_3 <- 1 - pbinom(3, size = 6, prob = 0.5)

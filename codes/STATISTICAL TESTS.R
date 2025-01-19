#STATISTICAL TESTS

#ONE QUANTITATIVE VARIABLE: STUDENT’S T-TEST

t.test()
#automatically computes both p-value and confidence interval,
#providing its limits - the 2.5% and 97.5% quantiles - already referred to
#the original variable

#example, let’s consider the daily caloric intake of 11 people,
#expressed in kJ:
intake=c(5260,5470,5640,6180,6390,6515,6805,7515,7515,8230,8770)

mean(intake)
sd(intake)

#compute the t-test by hand using the formula:
t.intake=(6753.636-7725)/(1142.123/sqrt(11))
#sqrt: Computes the square root of the specified float value

#we can more simply use the t-test() function:
t.test (x=intake, y = NULL, mu=6753.636)

#t.test(x, y = NULL,
#       alternative = c("two.sided", "less", "greater"),
#       mu = 0, paired = FALSE, var.equal = FALSE,
#      conf.level = 0.95, …)

#The output returns the kind of test used, the dataset used, and:
#- the value of t
#- the degrees of freedom (df)
#- the p-value
#- the alternative hypothesis
#- the confidence interval
#- the average of our variable

#Based on this information, do we accept or refuse the null hypothesis?


# ONE QUANTITATIVE VARIABLE: WILCOXON TEST

#step by step
D=intake - 7725
signs=ifelse(D>0,1,-1)
ranks=rank(abs(D))
rs=ranks*signs
V=sum(rs[rs>0])

#appropriate function
wilcox.test(intake, mu=7725)

#wilcox.test(x, y = NULL,
#            alternative = c("two.sided", "less", "greater"),
#            mu = 0, paired = FALSE, exact = NULL, correct = TRUE,
#            conf.int = FALSE, conf.level = 0.95, …)

#The output is, of course, less informative and returns:
#- the value of V
#- the corresponding p-value
#- the alternative hypothesis
#- a warning message if there are identical values in our sample


#This means that your sample intake contains "ties" (equal or repeated values). 
#When this happens:

#Messaggio di avvertimento:
#In wilcox.test.default(intake, mu = 7725) :
#  non è possibile calcolare p-value esatto in presenza di ties

#The exact calculation of the p-value is not possible.
#Instead, an approximation (such as the continuity correction method) 
#is used to estimate the p-value. This does not invalidate the result, but 
#it is simply a warning that the test is using an approximate approach.

#TWO-SAMPLE T-TEST (WELCH’S T-TEST)

#practical example. The text file “energy.txt” 
#We want to understand if these two distributions have the same average.

getwd()
#to see where is the directory going

energy=read.table("energy.txt",header=T)

.
energy$stature=as.factor(energy$stature)
# $ you can access and manipulate the individual elements of these objects easily

#as.factor is used to convert a vector object to a factor. 

#Categorical conversion is essential for many R statistical models, 
#including ANOVA and regression, as well as for data summarization tasks 
#like calculating frequencies.

str(energy)
#to display the internal structure of any R object in a compact way.
summary(energy)


t.test(energy$expend~energy$stature)
#the “formula” interface (~) when defining the
#test: it means that the variable “expend” is expressed as a function of the
#variable “status”, and it is a typical construction used in R when defining
#statistical models.


#TWO-SAMPLE WILCOXON TEST

#This is the nonparametric counterpart of Welch's t-test. Once again, it is
#a rank-based test that produces a number, W in this case.

wilcox.test(energy$expend~energy$stature)

#A rank-based test is a type of non-parametric statistical test that works 
#by replacing the actual values of the data with their ranks 
#(i.e., their relative positions when sorted in ascending or descending order). 
#These tests are used when assumptions about the distribution of the data 
#(e.g., normality) may not hold or when the data contains outliers that could 
#distort the results of parametric tests.

#EXERCISE***
#Internationally tolerated naturalist Charles Darwin has developed
#15 corn plants obtained by self-fertilization and another 15 obtained
#by cross-pollination (dataset “darwin.txt”). Is there a statistical
#significance in the difference of heights?

#Use the appropriate parametric and non-parametric tests to verify this.

getwd()
darwin_data = read.table("darwin.txt", header = T)
#NON DIMENTICARE LE ""........

str(darwin_data)
summary(darwin_data)

darwin_data$Group=as.factor(darwin_data$Group)

wilcox.test(darwin_data$Height~darwin_data$Group)

#grouping variable must be on the right hand of the formula, otherwise R is 
#stupid and dosen't understant it

#The p-value is 0.0026, which is much smaller than the common significance 
#level (e.g., α = 0.05).
#This means the difference in heights between the groups is statistically 
#significant, and you can reject the null hypothesis that the two groups 
#have the same median height.

#PAIRED T-TEST

#As an example, we can use the dataset “intake.txt” which measures the
#daily energy intake of women before and after having their period. 

#the null hypothesis posits that there is no
#difference in energy intake before and after a period.

intake=read.table("intake.txt",header=T)

#represent them in a scatterplot by using them as coordinates of a sample
#point in a two-dimensional plot:
  
plot(intake$pre,intake$post)
t.test(intake$pre,intake$post,paired=T)

#EXERCISE***
#let comment on the result of the paired test.
#Then perform the test by omitting the “paired=T” option
#What differences can bserve and why?
#Finally perform the non-parametric version of the paired t-test.

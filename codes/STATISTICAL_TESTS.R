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
#What differences can observe and why?
#Finally perform the non-parametric version of the paired t-test.

#don't know how to answer this





#TESTS ON FACTORIAL VARIABLES: BINOMIAL TEST

# variable that follows a binomial theoreticalprobability distribution

#following example: 39 out of 215 randomly chosen
#patients have asthma. We want to know if the probability of a random
#patient of having asthma is 15%.

binom.test(39,215,0.15)

#EXERCISE***
#Let us go back to an example similar to what we have used to
#explain the cumulative distribution: 20 patients are administered
#two different treatments, A and B, and they are asked which one
#they prefer. 16 of them prefer treatment A. Is this enough to say that
#A is the better treatment, or is the result given by chance? We had
#concluded that the p-value associated with the null hypothesis was
#0.59%.
#Now, solve the same problem using the binom.test() function and
#comment on the similarities or differences in results

binom.test(16,20,0.0059)

#The results of the binom.test() confirms the earlier findings, with a p-value 
#of 0.0059 indicating that the preference for treatment A is unlikely to be 
#due to chance. This test provides more detailed output, such as confidence 
#intervals, making it a preferred method when exact calculations are needed.

#TESTS ON FACTORIAL VARIABLES: PROPORTION TEST

#extension of the binomial test approximated test (i.e., p-value and confidence
#interval are approximated) with more flexibility.

prop.test(39,215,0.15)

#similar to that of the previously applied test; p-values
#and confidence interval are also very similar, suggesting that the
#approximation to normality, in this case, is appropriate enough

#uses chi-square statistics with one degree of freedom

#p-value and confidence interval
# is computed on a specific reference distribution of the chi-squared
#distribution, and this is then “translated” back into our starting variable

# The advantage of the proportions test is that it can compare two series of 
#experiments (even better, their respective probability distributions).

#the null hypothesis is of equal probability of success, that is:

#H0: p1 = p2
#H1: p1 ≠ p2

#EXAMPLE, we can consider two series of experiments of 12 and 13
#replicates, respectively. The successes are 9 in the first experiment and
#4 in the second experiment.

#Is the probability of success for the two experiments similar?
#we can try to answer this question using a proportions test.

success=c(9,4)
total=c(12,13)

prop.test(success,total)


#Normality approximation does not work with such small samples!
#However, a solution does exist: the Fisher test (we will see it later on).

#EXERCISE***
#A scarlet fever epidemic struck the United States in 1874. On the
#East coast, 210 out of 740 patients did not survive; on the West
#coast, 120 out of 660 patients died. Is the probability the same?

dead=c(210,120)
total=c(740,660)

prop.test(dead,total)


#COMPARING TWO QUALITATIVE VARIABLES: CHI-SQUARE TEST AND FISHER TEST

#applied to qualitative variables

#the null hypothesis of complete INDEPENDENCE of the two variables under 
#scrutiny, which we can imagine as a table or matrix's rows and columns.

#Under the null hypothesis, we expect that the observed frequencies are
#identical to the expected frequencies

#data must be organized in a 2 by 2 matrix, 
#using for example the “success/failure” information for the rows


data=matrix(c(9,4,3,9),nrow=2)

chisq.test(data)

chisq.test(data)$exp
#Chi-squared test and extracts the expected counts (frequencies) 
#from the test result.

#he $exp component specifically contains the expected frequencies 
#for each cell in the contingency table (or for each 
#observation in a goodness-of-fit test) under the null hypothesis.


#chisq.test(data)$exp gives you the expected counts used 
#to calculate the Chi-squared test statistic.
#You can use this to compare observed counts (data) 
#to expected counts ($exp) and understand how much they deviate.



#Fisher’s test of the problematic dataset

fisher.test(data)
# Fisher’s test expresses the null
#hypothesis and confidence interval in terms of ODDS RATIO, a statistics
#corresponding to the ratio between the proportion of successes and
#failures in the two experiments


#EXERCISE 1***
#Build the following contingency table in R:
#Fair eyes Dark eyes
#Fair hair 38 11
#Dark hair 14 51
#and test it using both Fisher’s test and the chi-square test.

con_tab = matrix(c(38, 11, 14, 51), nrow=2, byrow = TRUE, 
                 dimnames = list(Hair = c("Fair", "Dark"), Eyes = c("Fair", "Dark")))

#matrix(data = NA, nrow = 1, ncol = 1, byrow = FALSE,
#       dimnames = NULL)

#logical. If FALSE (the default) the matrix is filled by columns, 
#otherwise the matrix is filled by rows.

chisq.test(con_tab)

fisher.test(con_tab)

#EXERCISE2***
#Build the following contingency table in R and apply the
#appropriate test:
#0 1-150 151-300 >300
#Married 241 652 1537 598
#Prev.Married 36 46 38 21
#Single 218 327 106 67

con_tab2 = matrix(c(241, 652, 1537, 598, 36, 46, 38, 21,  218, 327, 106, 67), 
                  nrow=3, byrow = TRUE, 
                 dimnames = list(Status = c("Married", "Prev.Married", "Single"),
                                 Income = c("0", "1-150", "151-300", ">300")))

chisq.test(con_tab2)

fisher.test(con_tab2)
# Fisher's test cannot be applied here as it is computationally 
#expensive for large tables.

#chi_square_test$expected output is printed to verify that all 
#expected frequencies are greater than 5 
#(a requirement for the chi-square test to be valid).

chisq.test(con_tab2)$exp
#these are the expected values

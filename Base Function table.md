### **1. All functions used (in order of use, section by section)**  

---

#### **01. Vectors, Matrices, and Dataframes**

| **Function**        | **Example**                                      | **Explanation**                                                                                                     |
|---------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| `c(x, ...)`         | `c(1, 2, 3, 4)`                                  | Creates a vector by concatenating the elements passed as arguments.                                                |
| `seq(from, to, by)` | `seq(4, 10, 2)`                                  | Generates a numeric sequence with specified increments.                                                            |
| `rep(x, times)`     | `rep(1, 10)`                                     | Repeats an object (or sequence) a specified number of times.                                                       |
| `paste(x, y, sep)`  | `paste("A", 1:10, sep="_")`                      | Concatenates elements of vectors into a string, separated by a specified symbol.                                   |
| `rev(x)`            | `rev(c(1, 2, 3, 4))`                             | Reverses the order of elements in a vector.                                                                        |
| `class(x)`          | `class(final_vector)`                            | Returns the class of an object (e.g., "numeric", "data.frame").                                                    |
| `matrix(data, nrow, byrow)` | `matrix(c(1, 2, 3, 4), nrow=2, byrow=TRUE)` | Creates a matrix from a vector; `byrow=TRUE` fills by rows, otherwise by columns.                                  |
| `rbind(x, ...)`     | `rbind(c(1, 2), c(3, 4))`                        | Combines vectors (or matrices) as rows of a matrix.                                                                |
| `cbind(x, ...)`     | `cbind(c(1, 2), c(3, 4))`                        | Combines vectors (or matrices) as columns of a matrix.                                                             |
| `dim(x)`            | `dim(matrix(c(1, 2, 3, 4), nrow=2))`             | Returns the dimensions of a matrix (number of rows and columns).                                                   |
| `rownames(x)`       | `rownames(matrix(c(1, 2, 3, 4), nrow=2)) <- c("A", "B")` | Sets or returns the row names of a matrix or dataframe.                                                            |
| `colnames(x)`       | `colnames(matrix(c(1, 2, 3, 4), nrow=2)) <- c("X", "Y")` | Sets or returns the column names of a matrix or dataframe.                                                         |
| `data.frame(...)`   | `data.frame(A=c(1, 2), B=c(3, 4))`               | Creates a dataframe by combining columns (vectors) of the same length.                                             |
| `head(x, n)`        | `head(data.frame(A=c(1, 2, 3, 4, 5, 6)), 3)`     | Shows the first `n` rows of a dataframe or matrix (default: 6 rows).                                               |
| `names(x)`          | `names(data.frame(A=c(1, 2), B=c(3, 4)))`        | Returns or sets the column names of a dataframe.                                                                   |

---

#### **02. Probability Distributions**

| **Function**        | **Example**                                      | **Explanation**                                                                                                     |
|---------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| `dbinom(x, size, prob)` | `dbinom(7, size=10, prob=0.5)`                   | Returns the probability of obtaining `x` successes in a binomial distribution.                                     |
| `dnorm(x, mean, sd)`    | `dnorm(165, mean=175, sd=10)`                    | Calculates the probability density for a normal distribution with specified mean and standard deviation.           |
| `pnorm(q, mean, sd)`    | `pnorm(160, mean=132, sd=13)`                    | Calculates the cumulative probability up to a value `q` in a normal distribution.                                  |
| `rnorm(n, mean, sd)`    | `rnorm(10, mean=7, sd=5)`                        | Generates `n` random numbers from a normal distribution.                                                           |
| `qnorm(p, mean, sd)`    | `qnorm(0.025, mean=132, sd=13)`                  | Returns the quantile corresponding to a cumulative probability `p`.                                                |
| `plot(x, y, type)`      | `plot(1:10, rnorm(10), type="b")`                | Draws a plot (line, histogram, scatterplot, etc.) based on the specified type.                                     |
| `abline(h, v, ...)`     | `abline(h=0, col="red")`                         | Adds horizontal (`h`) or vertical (`v`) lines to the plot.                                                         |
| `segments(x0, y0, x1, y1)` | `segments(1, 1, 2, 2)`                           | Draws segments between two pairs of coordinates, useful for highlighting areas of interest.                        |
| `polygon(x, y, ...)`    | `polygon(c(1, 2, 3), c(3, 2, 1), col="blue")`    | Draws and fills a polygonal shape, useful for highlighting areas of interest in a plot.                            |

---

#### **03. Statistical Tests**

| **Function**        | **Example**                                      | **Explanation**                                                                                                     |
|---------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| `t.test(x, y = NULL, ...)` | `t.test(c(1, 2, 3), mu=2)`                      | Performs Student's t-test to compare the means of one or two groups.                                               |
| `wilcox.test(x, y = NULL, ...)` | `wilcox.test(c(1, 2, 3), mu=2)`                | Performs the Wilcoxon test, a non-parametric version of the t-test.                                                |
| `binom.test(x, n, p)`  | `binom.test(39, 215, 0.15)`                          | Tests hypotheses about proportions in a binomial distribution.                                                     |
| `prop.test(x, n, p)`   | `prop.test(39, 215, 0.15)`                           | Compares proportions between two or more groups or experiments.                                                    |
| `chisq.test(data)`     | `chisq.test(matrix(c(38, 11, 14, 51), nrow=2))`      | Performs a chi-squared test to check for independence between qualitative variables.                               |
| `fisher.test(data)`    | `fisher.test(matrix(c(38, 11, 14, 51), nrow=2))`     | Performs Fisher's exact test for small sample sizes.                                                               |

---

#### **04. Plots and Graphical Functions**

| **Function**        | **Example**                                      | **Explanation**                                                                                                     |
|---------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| `hist(x, ...)`      | `hist(rnorm(100))`                               | Creates a histogram to represent the distribution of a quantitative variable.                                      |
| `boxplot(x, ...)`   | `boxplot(rnorm(100))`                            | Displays the quartiles and variability of a quantitative variable in a boxplot.                                    |
| `mosaicplot(x, ...)` | `mosaicplot(matrix(c(38, 11, 14, 51), nrow=2))`    | Represents two qualitative variables as a mosaic of areas proportional to the frequencies.                         |
| `par(mfrow=c(x,y))` | `par(mfrow=c(2, 2))`                             | Divides the graphical area into a grid of x rows and y columns to display multiple plots.                          |

---

### **05. Linear Regression**

| **Function**        | **Example**                                      | **Explanation**                                                                                                     |
|---------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| `lm(formula, data)` | `lm(y ~ x, data=data.frame(x=1:10, y=rnorm(10)))`| Creates a linear regression model between a dependent variable and one or more independent variables.              |
| `summary(model)`    | `summary(lm(y ~ x, data=data.frame(x=1:10, y=rnorm(10))))` | Returns a summary of the regression model (coefficient, R², significance, etc.).                                   |
| `fitted(model)`     | `fitted(lm(y ~ x, data=data.frame(x=1:10, y=rnorm(10))))` | Returns the predicted values from the regression model.                                                           |
| `resid(model)`      | `resid(lm(y ~ x, data=data.frame(x=1:10, y=rnorm(10))))` | Returns the residuals from the regression model, useful for diagnostic analysis.                                  |
| `qqnorm(x)`         | `qqnorm(resid(lm(y ~ x, data=data.frame(x=1:10, y=rnorm(10)))))` | Draws a Q-Q plot to check if the residuals follow a normal distribution.                                          |
| `shapiro.test(x)`   | `shapiro.test(resid(lm(y ~ x, data=data.frame(x=1:10, y=rnorm(10)))))` | Performs the Shapiro-Wilk test to check the normality of a variable.                                               |

---

### **06. Multivariate Analysis**

| **Function**           | **Example**                                      | **Explanation**                                                                                                   |
|------------------------|--------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| `dudi.pca(df, ...)`    | `dudi.pca(data.frame(x=1:10, y=rnorm(10)), scannf=FALSE, nf=2)` | Performs a Principal Component Analysis (PCA) to reduce the dimensionality of the data.                          |
| `s.corcircle(pca_obj)` | `s.corcircle(pca_obj)`                           | Creates a correlation circle to represent the loadings of the principal components.                              |
| `cmdscale(d, ...)`     | `cmdscale(dist(matrix(rnorm(20), nrow=5)), k=2)` | Performs metric Multidimensional Scaling (MDS) to represent distances in a two-dimensional space.                |
| `dist(x, ...)`         | `dist(matrix(rnorm(20), nrow=5))`                | Calculates the distance matrix between observations.                                                            |

---

### **2. Symbols used with explanation**

| **Symbol** | **Example**                                      | **Meaning**                                                                                                                  |
|------------|--------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| `$`        | `data$column`                                    | Used to access a specific column or element of a dataframe or list.                                                         |
| `~`        | `y ~ x`                                          | Used to specify a formula in statistical models.                                                                            |
| `:`        | `1:10`                                           | Generates a sequence of numbers.                                                                                            |
| `<-`       | `x <- 5`                                         | Assigns a value to an object in R.                                                                                          |
| `==`       | `x == 5`                                         | Logical equality operator.                                                                                                  |
| `|`        | `x > 5 | x < 3`                                  | Logical "OR" operator.                                                                                                      |
| `&`        | `x > 5 & x < 10`                                 | Logical "AND" operator.                                                                                                     |
| `%in%`     | `x %in% c(1, 2, 3)`                              | Checks if an element belongs to a vector.                                                                                   |
| `[]`       | `x[1]` or `df[1, 2]`                             | Accesses specific elements of a vector or dataframe.                                                                        |
```

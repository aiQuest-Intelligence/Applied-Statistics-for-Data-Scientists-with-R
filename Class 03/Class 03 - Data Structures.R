
# =================================================== #
# Data Structures
# Author(s): Md. Ahsanul Islam
# Date: Class 03 at 3 Jan 2025
# =================================================== #



# Vector ------------------------------------------------------------------

x1 <- c(10, 15, 20, 21, 24, 13, 20, 19)
is.vector(x1)
is.data.frame(x1)

## Random number generator

set.seed(1)
x2 <- sample(1:100, 10)
x2
summary(x2)


sample(1:10, 8, replace = TRUE)
set.seed(42)
table(sample(1:10, 8, replace = TRUE))

sample(x = c("Apple","Banana","Mangoo","Lichi"), size = 2, prob = c(0.25,0.25,0.25,0.25),
       replace = FALSE) 

income = c(10000, 25000, 40000, 28000)
household = c(10, 5, 2, 4)
sample(income, size = 2, prob = household)

household / sum(household)



set.seed(0)
x3 <- runif(10)*10
x3


## Sequence generator

x4 <- seq(from = 1, to = 11, by = 2)
x4

x5 <- seq(from = 1, to = 11, length.out = 6)
x5

seq_len(10)

# talk later
seq(from = 1, to = 11, length.out = 6)
seq(from = 1, to = 11, along.with = x3)

x6 <- 10:1
x6


## selection

x1 > 19
x1[3]
length(x1)
x1[c(FALSE, FALSE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE)]
x1[c(3,4,5,7)]
x1[x1 > 19]
x1[x1 > 14 & x1 < 20]
which(x1 > 14 & x1 < 20)
x1[which(x1 > 14 & x1 < 20)]
 
## replace
# doesn't replace original one
replace(x1, x1 > 19, 0)
x1 <- replace(x1, which(x1 > 19), 0)

# replaces original one
x1[x1 == 0] <- 15
x1

# x1 <- c(10, 15, 20, 21, 24, 13, 20, 19)
# mean(x1, na.rm = TRUE)

 
# Matrix ------------------------------------------------------------------

mat1 <- matrix(c(1, 2, 3, 4), ncol = 2, nrow = 2, byrow = TRUE)
mat1
is.matrix(mat1)

is.matrix(matrix(c(0,10,2), ncol = 3))
is.matrix(c(0,10,2))


mat1[,]
mat1[1,]
mat1[,2]
mat1[1,2]
mat1[1,2] <- 0
mat1 

mat2 <- matrix(c(0, 5, 6, 7), 2, byrow = TRUE)
mat2

mat3 <- matrix(c(9, 8, 1, 3, 5, 7), 3, byrow = TRUE)
mat3

as.vector(mat3[,2])
 
## Element wise multiplication (Hadamard multiplication)

mat1 * mat2

## matrix multiplication

mat1 %*% mat2 
dim(mat1)
dim(mat2)
dim(mat1 %*% mat2)

mat1 %*% mat3  # will raise an error
dim(mat1)
dim(mat3)
dim(mat1 %*% mat3)

mat3 %*% mat1  # it will work
dim(mat3)
dim(mat1)
dim(mat3 %*% mat1)


## Kronecker Product

mat1 %x% mat2
mat1 %x% mat3
 
 
# Array -------------------------------------------------------------------

arr1 <- array(c(1:12), c(2,3,2))
arr1


# Data Frame --------------------------------------------------------------

df1 <- data.frame(id = c(1,2,3, 4), 
                  age = c(24, 23, 19, 10), 
                  gender = c("F","M","F", "F"),  stringsAsFactors = TRUE)
df1
is.data.frame(df1)
summary(df1)

is.character(c("F","M","F", "F"))
is.factor(as.factor(c("F","M","F", "F")))
is.numeric(as.factor(c("F","M","F", "F")))

## subsetting
 
df1$id
df1$age
df1$gender
 
## row and column names

rownames(df1)
colnames(df1)
 
## add new column

df1$height <- c(5, 6, 5.5)
df1

# List --------------------------------------------------------------------

ls1 <- list(c(1,2,3), c(24,23,19), c("F","M","F"))
ls2 <- list(id = c(1,2,3), age = c(24, 23, 19), gender = c("F","M","F"))
ls3 <- list(id = c(1,2,3), age = c(24, 23, 19), gender = c("F","M","F"), array1 = arr1)
ls3




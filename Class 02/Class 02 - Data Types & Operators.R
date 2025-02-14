
# =================================================== #
# Data Types and Operators
# Author(s): Md. Ahsanul Islam
# Date: Class 02 | 28 Dec 2024
# =================================================== #



# Common data types -------------------------------------------------------

typeof(6)
typeof(6L)
typeof(TRUE)
typeof(T)
typeof("cat")
typeof(3i+5)

mode(6)
mode(6L)
mode(TRUE)
mode(T)
mode("cat")
mode(3i+5)


# Combining elements ------------------------------------------------------

c(6, 7, 10)
typeof(c(6, 7, 10))
typeof(c(6L, 7L, 10L))


# Assignment operator -----------------------------------------------------

x1 <- c(6, 7, 10)
c(6, 7, 10) -> x1
x1 = c(6, 7, 10)


# Relational operators ----------------------------------------------------

x2 <- c("Apple", "Dhk", "Dhaka", "dhaka")
x2

"dhk" %in% x2

x3 <- c(23, NA, 45, NA, 30)
x3
x3 <- c(x3[1:3],0,x3[4:length(x3)])
x3

is.na(x3)
sum(is.na(3))
which(is.na(x3))

any(c(F,F,F))  # at least ekta True ase kina
all(c(T,T,T))  # sobgula true kina

any(is.na(x3))


# Common functions --------------------------------------------------------

x4 <- c(23, 23, 45, 56, 30)

mean(x4)
min(x4)
summary(x4)

summary(mtcars)

num1 <- c(23.1344, 34.5554450)

round(num1, digits = 1)
floor(num1) 
ceiling(num1)

help(any)

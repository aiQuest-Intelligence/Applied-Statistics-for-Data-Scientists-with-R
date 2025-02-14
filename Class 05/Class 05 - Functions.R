
# =================================================== #
# Functions
# Author(s): Md. Ahsanul Islam
# Date: Class 05 at 7 Jan 2024
# =================================================== #


# Function ----------------------------------------------------------------

sum_two_vals <- function(x, y) {
  print(paste("value of x =", x))
  print(paste("value of y =", y))
  return(x + y)
}

sum_two_vals(x = 3, y = 10)
sum_two_vals(400, 10)


greet <- function(name) {
  cat("Hello, ", name, "!\n", sep = "")
}

greet(name = "Ahsan")

check_even_odd <- function(number) {
  if (number %% 2 == 0) {
    return("Even")
  } else {
    return("Odd")
  }
}

check_even_odd(4)
check_even_odd(7)



## multiple argument and return ####

math_operation <- function(x, y, op) {
  switch(op,
         "add" = x + y,
         "subtract" = x - y,
         "multiply" = x * y,
         "divide" = if (y != 0){ x / y } else { "Division by zero!" },
         "Invalid operation"
  )
}

math_operation(10, 5, "add")    
math_operation(10, 5, "divide") 
math_operation(10, 0, "divide") 



## default value ####

calculate_sqrt <- function(val, digit = 2) {
  rooted <- sqrt(val)
  out <- round(rooted, digit)
  return(out)
}

round(sqrt(1001), 2)
calculate_sqrt(1001, 1)
calculate_sqrt(1001)

calculate_sqrt <- function(val, digit) {
  rooted <- sqrt(val)
  out <- round(x = rooted, digits = digit)
  return(out)
}

calculate_sqrt(1001)   
# Here, default value for digit is passed since no value is assigned in digit 


## Scoping assignment ####

begin <- function() {
  begin_time <<- Sys.time();
  message("Program started: ", begin_time)
}

end <- function(){
  end_time <<- Sys.time()
  runtime <<- as.numeric(format(end_time, "%s")) - as.numeric(format(begin_time, "%s"))
  message("Program end: ", end_time)
  message("Runtime stored in \"runtime\"")
}

begin(); Sys.sleep(3); end()  # system will pause for 3 seconds



## invisible ####

trial_func_ret <- function(x) {
  res <- mean(x)
  return(res)
}

trial_func_inv <- function(x) {
  invisible(res)
}

vals <- c(4,5,2,6,9)

trial_func_ret(x = vals)

trial_func_inv(x = vals)

a <- trial_func_inv(x = vals)
a

## Multiple Output ####

mtcars
iris

modify_data <- function(data1, data2){
  a <- data1[1:10,]
  b <- data2[2:5,]
  return(list(first = a, second = b))
}

res <- modify_data(data1 = mtcars, data2=iris)
res$first


model <- lm(Sepal.Width ~ Sepal.Length, data=iris)
summary(model)
model$residuals

plot(iris$Sepal.Width, model$residuals)


## temporary function ####
 
mat1 <- matrix(c(1, 2, 3, 4), ncol = 2, nrow = 2, byrow = TRUE)

apply(mat1, 1, sum)^2

apply(mat1, 1, function(x) sum(x)^2)
apply(mat1, 2, function(x) sum(x)^2)

## ellipsis ####

wrapper_mean <- function(data, ...) {
  if(is.numeric(data)){
    mean(data, ...)
  }else{
    warning("Data is not numeric")
  }
}

wrapper_mean(c(2,4,5,NA,3))
wrapper_mean(c(2,4,5,NA,'3'))
wrapper_mean(c(2,4,5,NA,'3'), na.rm = TRUE)
wrapper_mean(c(2,4,5,NA,3, 10, 99), na.rm = TRUE, trim = 0.4)


## function as argument ####

apply_function <- function(vec, fun) {
  return(fun(vec))
}

# Example usage
apply_function(c(1, 2, 3, 4), fun = mean)
apply_function(c(1, 2, 3, 4), fun = max)
apply_function(c(1, 2, 3, 4), fun = is.numeric)


## Roxygen comments ####

#' @title calculate_sqrt
#' @description Calculates square root of the numbers.
#' @param val numeric vector or length 1 or more
#' @param digit numeric value
#' @return numeric vector that is squared root of the passed vector
#' @examples
#'   calculate_sqrt(c(6,10,453), 4)
#'   calculate_sqrt(c(2,3,4), 2)
#'   
calculate_sqrt <- function(val, digit = 3) {
  return(round(sqrt(val), digit))
}


# Packages ----------------------------------------------------------------

install.packages("dplyr")
library(dplyr)


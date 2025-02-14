
# =================================================== #
# Conditional statements, Loops and Functions
# Author(s): Md. Ahsanul Islam
# Date: Class 04 at 4 Jan 2025
# =================================================== #


print("Hello")
1+5

{
  print("Hello")
  1+5
}

print("Hello"); 1+5


# Conditional -------------------------------------------------------------


x <- 3

if (x > 0) {
  print("x is positive")
} else {
  print("x is not positive")
}



x <- -1


if (x > 0) {
  print("x is positive")
} else if (x < 0) {
  print("x is negative")
} else {
  print("x is zero")
}



x <- 0

if (x > 0) {
  if (x %% 2 == 0) {
    print("x is positive and even")
  } else {
    print("x is positive and odd")
  }
} else {
  print("x is not positive")
}


## Vectorized version ####

x <- c(1, 3, 0, 5, 99)
ifelse(x > 90, "Yes", "No")
ifelse(x > 90, "Yes", ifelse(x == 0, "zero", "No"))

## switch ####

operation <- "root"
val <- 9

switch(operation,
       "square" = val^2,
       "root" = sqrt(val),
       NA
       )


# Loop --------------------------------------------------------------------


## for loop ####


numbers <- c(2, 4, 6, 8)
for (i in numbers) {
  print(paste("Square of", i, "is", i^2))
}


## while loop ####

count <- 5
while (count > -10) {
  print(count)
  count <- count - 1
}

## repeat #####

repeat {
  print("This is an infinite loop. Press ESC to stop.")
  Sys.sleep(1)  # Pause for 1 second
}



# Stop when counter exceeds 5
counter <- 1
repeat {
  print(counter)
  counter <- counter + 1
  if (counter > 5) {  
    break
  }
}



# Stop when the sum exceeds 20
cumulative_sum <- 0
i <- 1
repeat {
  cumulative_sum <- cumulative_sum + i
  print(cumulative_sum)
  i <- i + 1
  if (cumulative_sum > 20) {  
    break
  }
}

# alternative way
cumsum(1:10)


# user input
readline()

x <- as.integer(readline("Enter your number: "))

repeat {
  input <- as.integer(readline(prompt = "Enter a number between 1 and 10: "))
  if (!is.na(input) & input >= 1 & input <= 10) {
    print(paste("You entered:", input))
    break
  } else {
    print("Invalid input, try again.")
  }
}



## 'Apply' functions ####

mat <- matrix(1:9, nrow = 3, byrow = TRUE)
mat
sum()
apply(mat, 1, sum)  # Sum of each row
apply(mat, 2, sum)  # Sum of each column

rowSums(mat)
colSums(mat)

rowMeans(mat)
colMeans(mat)

## tapply ####

# tapply performs operations on subsets of the object of interest
df1 <- data.frame(age=c(22,20,NA,24,19,23),
                 gender=c("M","F","F","M","M","F"),
                 location=c("Rural","Urban","Urban","Rural","Rural","Rural"),
                 stringsAsFactors=TRUE)
df1

tapply(X=df1$age, INDEX=df1$gender, FUN=mean, na.rm = TRUE)
tapply(X=df1$age, INDEX=list(df1$gender, df1$location), FUN=mean, na.rm = TRUE)


## lapply and sapply ####

ls3 <- list(id = c(1,2,3), age = c(24, 23, 19), df = df1)
ls3
lapply(ls3, is.data.frame)
sapply(ls3, is.data.frame)





# =================================================== #
# Sampling and Sampling Distributions
# Author(s): Md. Ahsanul Islam
# Date: Class 15 on 4 Feb 2025
# Description: Discuss various sampling techniques and 
# sampling distributions
# Data: Not applicable.
# =================================================== #


# Bootstrap ---------------------------------------------------------------

data <- c(79, 82, 41, 79, 82, 79, 61, 59, 52, 76, 36, 90, 92, 78, 39)
summary(data)
hist(data)

set.seed(42)
sam <- sample(data, size = 7)
summary(sam)
hist(sam)

mean(sam)
mean(sample(sam, size = length(sam), replace = TRUE))

replicate(10, mean(sample(sam, size = length(sam), replace = TRUE)))

# Bootstrap resampling
bootstrap_means <- replicate(10000, mean(sample(mtcars$cyl, size = length(mtcars$cyl), 
                                                replace = TRUE)))

summary(bootstrap_means)

df <- data.frame(bootstrap_means)
head(df)


# Visualize the bootstrap distribution
library(ggplot2)
ggplot(df, aes(x = bootstrap_means)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "black") +
  labs(title = "Bootstrap Distribution of the Mean", x = "Mean", y = "Frequency")




# Jackknife ---------------------------------------------------------------

data <- c(79, 82, 41, 79, 82, 79, 61, 59, 52, 76, 36, 90, 92, 78, 39)

# Jackknife resampling
jackknife_means <- sapply(1:length(data), function(i) mean(data[-i]))

# list1 <- list()
# for(i in 1:length(data)){
#   print(i)
#   list1[[i]] <- data[-i]
#   i <- i+1
# }
# list1

# Estimate bias and variance
bias_estimate <- (length(data) - 1) * (mean(jackknife_means) - mean(data))
variance_estimate <- var(jackknife_means) * (length(data) - 1)



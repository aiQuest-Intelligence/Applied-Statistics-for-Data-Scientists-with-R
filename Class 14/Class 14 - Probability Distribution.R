

# Load required library
library(ggplot2)
library(dplyr)

# Poisson -----------------------------------------------------------------

pois_df <- read.csv("Data/Poisson_data.csv")
colnames(pois_df)

colnames(pois_df)[3] <- "Calls"
pois_df

pois_df %>% 
  count(Calls) %>% 
  mutate(prob = n/sum(n))


ggplot(pois_df, aes(x = Calls)) +
  geom_histogram(aes(y = after_stat(density)), fill = "skyblue", color = "white", binwidth = 1) +
  geom_density(fill = "skyblue3", alpha = 0.4) +
  labs(title = "Actual Distribution",
       x = "Number of Calls Received",
       y = "Density") +
  theme_minimal()


# fitting a poisson distribution that reflects this data
lambda <- mean(pois_df$Calls)
lambda


dpois(x = 3, lambda = lambda)  # probability of getting 3 calls
dpois(x = 5, lambda = lambda)  # probability of getting 5 calls
dpois(x = 1, lambda = lambda)  # probability of getting 1 calls

1 - sum(dpois(x = 0:6, lambda = lambda))
sum(dpois(x = c(7,8,9,10), lambda = lambda))


df <- data.frame(
  X = 0:10,
  prob = round(dpois(x = 0:10, lambda = lambda), 4)
)

ggplot(df, aes(x = X, y = prob)) +
  geom_col(fill = "skyblue", color = "black", width = 0.7) +
  labs(title = paste0("Poisson Distribution (λ = ",lambda,")"),
       x = "Number of Calls Received",
       y = "Probability") +
  theme_minimal()



# Normal Distribution -----------------------------------------------------


norm_df <- read.csv("Data/Normal_data.csv")

ggplot(norm_df, aes(x = IQ)) +
  geom_histogram(aes(y = after_stat(density)), fill = "skyblue", color = "white", binwidth = 15) +
  geom_density(fill = "skyblue3", alpha = 0.4) +
  labs(title = "Observed Distribution of IQ",
       x = "IQ Score",
       y = "Density") +
  theme_minimal()

summary(norm_df$IQ)

mean(norm_df$IQ)
sd(norm_df$IQ)

hist(runif(100, min = 0, max = 10))
hist(rpois(100, lambda = 3.2))
hist(rnorm(10000, mean = 10, sd = 5))
hist(rnorm(10000, mean = mean(norm_df$IQ), sd = sd(norm_df$IQ)))

data.frame(
  IQ = rnorm(10000, mean = mean(norm_df$IQ), sd = sd(norm_df$IQ))
) %>% 
  ggplot() +
  geom_histogram(aes(x = IQ), fill = "skyblue", color = "white", binwidth = 15) +
  theme_minimal()

(norm_df$IQ - mean(norm_df$IQ)) / sd(norm_df$IQ)
as.vector(scale(norm_df$IQ))

# standardize
round(mean(scale(norm_df$IQ)))
round(sd(scale(norm_df$IQ)))

df <- data.frame(
  IQ = seq(55, 145, by = 1)
)
df$prob <- dnorm(df$IQ, mean = mean(norm_df$IQ), sd = sd(norm_df$IQ))

ggplot(df, aes(x = IQ, y = prob)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black", width = 1) +
  labs(title = "Normal Distribution",
       x = "IQ Score",
       y = "Probability") +
  theme_minimal()


# mean = 93.4; sd = 17.48
qnorm(p = 0.3, mean = 93.4, sd = 17.48)
qnorm(p = 0.5, mean = 93.4, sd = 17.48)

# qnorm(p = 0.025, mean = 0, sd = 1, lower.tail = FALSE) 


shapiro.test(norm_df$IQ)

# H_0: There is no difference in the observed distribution and the theoretical normal distribution. 
# 0.9174 > 0.05 alpha, so null cannot be rejected. 

shapiro.test(pois_df$Calls)



# Binomial Distribution -----------------------------------------------------

set.seed(123)

n <- 100; p <- 0.5
xbinom <- rbinom(n, size = 10, prob = p)

df <- data.frame(xbinom)

ggplot(df, aes(x = xbinom)) +
  geom_histogram(aes(y = after_stat(density)), binwidth = 1, fill = "skyblue",
                 color = "black", boundary = 0) +
  labs(title = "Histogram of Binomial Distribution",
       subtitle = paste0("n = ",n,", p = ", p),
       x = "Number of Successes",
       y = "Frequency") +
  theme_minimal()




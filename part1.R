## usar esta estructura del proyecto:

## * Title (give an appropriate title) and Author Name
## * Overview: In a few (2-3) sentences explain what is going to be reported on.
## * Simulations: Include English explanations of the simulations you ran, with the accompanying R code. Your explanations should make clear what the R code accomplishes.
## * Sample Mean versus Theoretical Mean: Include figures with titles. In the figures, highlight the means you are comparing. Include text that explains the figures and what is shown on them, and provides appropriate numbers.
## * Sample Variance versus Theoretical Variance: Include figures (output from R) with titles. Highlight the variances you are comparing. Include text that explains your understanding of the differences of the variances.
## * Distribution: Via figures and text, explain how one can tell the distribution is approximately normal.

# example

data <- runif(40)
mean(data)
hist(data)

mns = NULL
for (i in 1 : 1000) mns = c(mns, mean(runif(40)))
hist(mns)

# ejemplo aplicado al enunciado

means <- 1:1000
lambda <- 0.2
observations <- 40
for (simulation in 1:1000) { means[simulation] <- mean(rexp(n = observations, rate = lambda)) }
head(means)
hist(means)



# project

set.seed(20150124)
lambda <- 0.2
observations <- 40
simulations <- 1000
data <- matrix(rexp(simulations * observations, rate = lambda), nrow = simulations)

# each row is a simulation
head(data, 1)

# take the mean of each simulation
means <- rowMeans(data)
# alternativa:
# means <- apply(data, 1, mean)

# 1. compare against theoretical

## get statistics for the entire set of simulations
simulations_mean_of_means <- round(mean(means), 2)
simulations_sd <- round(sd(means), 2)
simulations_var <- round(var(means), 2)

theoretical_mean <- round(1/lambda, 2)
theoretical_sd <- round(1/(lambda * sqrt(observations)), 2)
theoretical_var <- round((1/(lambda * sqrt(observations)))^2, 2)

mean_diff <- abs(theoretical_mean - simulations_mean_of_means)
sd_diff <- abs(theoretical_sd - simulations_sd)
var_diff <- abs(theoretical_var - simulations_var)

## require(ggplot2)
## par(mfrow=c(1,2))
## hist(means, freq = FALSE, col = "light blue", main = NULL, xlab = "Mean")
## lines(density(means), col = "blue")
## curve(dnorm(x, theoretical_mean, theoretical_sd), col="red", lty = 3, lwd = 2, add = TRUE)
## qqnorm(means, main="", col = "blue")
## qqline(means, col="red", lty = 3, lwd = 2)

# plot the histogram of the means
hist(means, ylab="density")
lines(density(means))
# theoretical mean
abline(v = 1/lambda)

# compare quantiles
qqnorm(means)
qqline(means)

# confidence intervals
CI <- 1.96
confidence_interval <- simulations_mean_of_means + c(-1, 1) * CI * (simulations_sd/sqrt(observations))
hist(means, ylab="Density")
abline(v = confidence_interval, col="red")

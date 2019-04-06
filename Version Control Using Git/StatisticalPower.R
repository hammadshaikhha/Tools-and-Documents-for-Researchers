# Purpose: Compute power of hypothesis testing
# for difference between two means using both
# assymptotic and exact tests.
# Data Started: Sunday, March 31, 2019

# Sample sizes
n1 = 15
n2 = 20
alpha = 0.05
nsim_power = 100
reject_prob_t = numeric(nsim_power)
reject_prob_exact = numeric(nsim_power)

# Seed
set.seed(21283)

for(j in 1:nsim_power){

  # Generate samples
  X1 = rbeta(n1, 2, 5)
  #X1 = rnorm(n1, 0, 1.5)
  X2 = rbeta(n2, 3, 3)
  #X2 = rnorm(n2, 1, 1.5)


  # Store full data in vector
  y = c(X1,X2)

  # Degrees of freedom
  df = n1 + n2 - 2

  # Pooled variance
  pool_var = ((n1-1)*var(X1) + (n2-1)*var(X2))/(n1 + n2 - 2)

  # Sample mean difference
  sample_diff = mean(X2) - mean(X1)
  #sample_diff

  # t - statistics and critical vaue
  tstat = (sample_diff)/sqrt(pool_var*(1/n1 + 1/n2))
  tcv = abs(qt(alpha/2, df))

  # Rejection region
  reject_prob_t[j] = tstat > tcv

  # Compute p-value
  #pvalue = pt(-tstat, df)*2
  #pvalue

  # Draw mean difference realizations from pemutation distribution
  nsim = 100000
  diff_mean = numeric(nsim)

  # Each itteration is a draw from permutaiton distribution of mean differences
  for(i in 1:nsim){
    # Randomly select two groups from full data list
    x1 = sample(y, n1)
    x2 = setdiff(y, x1)
    diff_mean[i] = mean(x2) - mean(x1)
  }

  # Compute exact appprox pvalue
  reject_prob_exact[j] = mean(diff_mean >= sample_diff) < alpha

# Illustrating the pvalue
#hist(diff_mean, breaks=seq(-0.35, 0.35, 0.05), main="Permutation
#     Distribution of Mean Differences", xlab="Difference between sample means",
#     ylab="Frequency")
#abline(v=sample_diff, col="blue")
}

# Computer power (probability of correctly rejection H0)
power_t = mean(reject_prob_t)
power_t
power_exact = mean(reject_prob_exact)
power_exact

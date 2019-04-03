# Purpose: Compute power of hypothesis testing
# for difference between two means using both
# assymptotic and exact tests.
# Data Started: Sunday, March 31, 2019

# Sample sizes
n1 = 15
n2 = 20
alpha = 0.05

# Seed
set.seed(21283)

# Generate samples
X1 = rbeta(n1, 2, 5)
X2 = rbeta(n2, 3, 3)

# Store full data in vector
y = c(X1,X2)

# Degrees of freedom
df = n1 + n2 - 2

# Pooled variance
pool_var = ((n1-1)*var(X1) + (n2-1)*var(X2))/(n1 + n2 - 2)

# Sample difference
sample_diff = mean(X2)-mean(X1)

# t - statistics and critical vaue
tstat = (sample_diff)/sqrt(pool_var*(1/n1 + 1/n2))
tcv = abs(qt(alpha/2, df))

# Rejection region
reject = tstat > tcv

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
mean(diff_mean >= sample_diff)

# Illustrating the pvalue
hist(diff_mean, breaks=seq(-0.35, 0.35, 0.05), main="Permutation
     Distribution of Mean Differences", xlab="Difference between sample means",
     ylab="Frequency")
abline(v=sample_diff, col="blue")

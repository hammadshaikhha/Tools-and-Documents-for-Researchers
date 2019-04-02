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
reject = tstat > tcv

# Compute p-value
pvalue = pt(-tstat, df)*2

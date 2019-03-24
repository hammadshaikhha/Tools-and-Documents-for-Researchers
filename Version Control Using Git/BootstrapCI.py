'''
Purpose: Compare Classical vs Bootstrap confidence intervals when sample size
is small and population is right skewed.
'''

# Load packages
import numpy as np
import seaborn
from scipy import stats
import matplotlib.pyplot as plt

# Initialize parameters
shape_a = 1.5
shape_b = 5
alpha = 0.05
n_sample = 20
df = n_sample-1

# Right skewed Population distribution
X = np.random.beta(shape_a, shape_b, 5000)

# Distribution of population
#seaborn.distplot(X)
#plt.title("Right Skewed Population Distribution")
#plt.show()

# Draw a sample from Population
data = np.random.beta(shape_a, shape_b, n_sample)

## Standard 95% CI
# CI components
sample_mean = np.mean(data)
sample_std = np.std(data)
margin_error = stats.t.ppf(1-alpha/2, df)*(sample_std/np.sqrt(n_sample))

# Lower and upper bounds
CI_lower = sample_mean - margin_error
CI_upper = sample_mean + margin_error
print("The 95% CI is: [" + str(CI_lower) + "," + str(CI_upper) + "]")

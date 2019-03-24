'''
Purpose: Classical vs Bootstrap confidence intervals when sample size is small
and population is right skewed.
'''

# Load packages
import numpy as np
import seaborn
import matplotlib.pyplot as plt

# Initialize parameters
shape_a = 1.5
shape_b = 5
n_sample = 20

# Right skewed Population distribution
X = np.random.beta(shape_a, shape_b, 5000)

# Histogram of population
seaborn.distplot(X)
plt.title("Right Skewed Population Distribution")
plt.show()



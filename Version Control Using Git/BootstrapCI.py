'''
Purpose: Compare Classical vs Bootstrap confidence intervals when sample size
is small and population is right skewed.
'''

# Load packages
import numpy as np
import seaborn
from scipy import stats
import matplotlib.pyplot as plt
from random import choices

# Initialize parameters
shape_a = 1.5
shape_b = 5
alpha = 0.05
n_sim = 1000
pop_mean = shape_a/(shape_a+shape_b)

# Lists for tracking
t_coverage = []
boot_means_list = []
boot_coverage = []
boot_tstats_list = []
boot_coverage_prob = []
t_coverage_prob = []


# Right skewed Population distribution
#X = np.random.beta(shape_a, shape_b, 5000)
#data = np.random.beta(shape_a, shape_b, n_sample)

# Distribution of population
#seaborn.distplot(X)
#plt.title("Right Skewed Population Distribution")
#plt.show()


# Itterate over sample sizes
for n_sample in range(20, 100, 20):

    # Degrees of freedom
    df = n_sample-1

    # Repeatedly sample from population
    for sim in range(n_sim):

        # Draw a sample from Population
        data = np.random.beta(shape_a, shape_b, n_sample)
        #data = np.random.normal(0,1,n_sample)

        ## Bootstrap 95% CI
        for boot_sim in range(n_sim):

            # Resample with replacement from the sample
            boot_sample = choices(data, k = n_sample)
            boot_mean = np.mean(boot_sample)

            # Standard error of bootstrap sample
            boot_sample_se = np.std(boot_sample)/np.sqrt(n_sample)

            # Bootstrap t-stats
            boot_tstat = (boot_mean - np.mean(data))/boot_sample_se
            boot_tstats_list.append(boot_tstat)

            # Store sample mean in Lists
            boot_means_list.append(boot_mean)

        # Bootstrap CI lower and upper bounds
        boot_se = np.std(boot_means_list)
        #boot_CI_lower = np.quantile(boot_means, alpha/2)
        #boot_CI_upper = np.quantile(boot_means, 1-alpha/2)
        #margin_error_boot = stats.t.ppf(1-alpha/2, df)*boot_se
        margin_error_boot_low = np.quantile(boot_tstats_list, alpha/2)*boot_se
        margin_error_boot_up = np.quantile(boot_tstats_list, 1-alpha/2)*boot_se

        # Reset bootstrap lists
        boot_means_list = []
        boot_tstats_list = []

        ## Standard 95% CI
        # CI components
        sample_mean = np.mean(data)
        sample_std = np.std(data)
        margin_error = stats.t.ppf(1-alpha/2, df)*(sample_std/np.sqrt(n_sample))

        # Lower and upper bounds for student t
        CI_lower = sample_mean - margin_error
        CI_upper = sample_mean + margin_error

        # Lower and upper bounds for boot strap
        boot_CI_lower = sample_mean + margin_error_boot_low
        boot_CI_upper = sample_mean + margin_error_boot_up

        # Check whether CI covers true population mean
        t_coverage.append(pop_mean <= CI_upper and pop_mean >= CI_lower)
        boot_coverage.append(pop_mean <= boot_CI_upper and pop_mean >= boot_CI_lower)

    # Store coverage probability for student t 95% CI
    t_coverage_prob.append(np.mean(t_coverage))
    boot_coverage_prob.append(np.mean(boot_coverage))

# Scatter plot of sample size and covarage probability
boot_scatter = plt.scatter(range(20, 100, 20), boot_coverage_prob)
t_scatter = plt.scatter(range(20, 100, 20), t_coverage_prob)
plt.legend([boot_scatter, t_scatter], ["Bootstrap CI", "Student t CI"])
plt.title("Coverage Probability and Sample Size")
plt.xlabel("Sample Size")
plt.ylabel("Probability of Covering True Mean")
plt.show()

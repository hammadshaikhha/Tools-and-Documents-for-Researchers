%{

Purpose: Analyze relationship between mothers smoking 
and thier infants birth weight using OLS and propensity scores.

%}


% Change directory
cd('/Users/hammadshaikh/Documents/GitHub/Tools-and-Documents-for-Researchers/Version Control Using Git')

% Load birth weight data
BirthWeightData = csvread('BirthWeightSmoking.csv',1,0);

% Data variables
birth_weight = BirthWeightData(:,1);
prop_score = BirthWeightData(:,2);
mother_smoke = BirthWeightData(:,3);

% Descriptive analysis
X = [ones(size(mother_smoke))  mother_smoke];
y = birth_weight;

% OLS regression
beta_hat = inv(X'*X)*X'*y;

% Bar plot illustrating effect of smoking
xlabel = categorical({'non-smoker','smoker'});
barplot_data = [beta_hat(1),beta_hat(1)+beta_hat(2)];
bar(xlabel, barplot_data)
ylabel("Infant Birth Weight (Grams)", 'FontSize',16)
title("Birth Weight and Mother Smoker Status", 'FontSize',16)




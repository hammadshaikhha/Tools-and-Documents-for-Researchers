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
nsize = size(mother_smoke);

% Descriptive analysis
X = [ones(nsize)  mother_smoke];
y = birth_weight;

% OLS regression
beta_hat = inv(X'*X)*X'*y;

% Bar plot illustrating effect of smoking
%xlabel = categorical({'non-smoker','smoker'});
%barplot_data = [beta_hat(1),beta_hat(1)+beta_hat(2)];
%bar(xlabel, barplot_data)
%ylabel("Infant Birth Weight (Grams)", 'FontSize',16)
%title("Birth Weight and Mother Smoker Status", 'FontSize',16)

% Homoscedastic standard errors
% Generate residuals
e = y - X*beta_hat;

% Covariance matrix
sigma_sq = (1/(nsize(1)-2))*sum(e.^2);
VCov = sigma_sq*inv(X'*X);

% Standard errors
b0_se = sqrt(VCov(1,1));
b1_se = sqrt(VCov(2,2));

% Define ATE weight
inv_prob_weight = zeros(nsize);
inv_prob_weight(mother_smoke ==1) = 1./prop_score(mother_smoke ==1);
inv_prob_weight(mother_smoke ==0) = 1./(1-prop_score(mother_smoke ==0));

% Render weight SSE as function of beta
WSSE = @(beta)OLSWeighted(birth_weight, X,inv_prob_weight,beta);

% Find inverse propensity weight regression estimates
inv_prop_ols = fminunc(WSSE, beta_hat);

% Bar plot illustrating effect of smoking
xlabel = categorical({'non-smoker','smoker'});
barplot_data = [beta_hat(1) inv_prop_ols(1);(beta_hat(1)+beta_hat(2)) (inv_prop_ols(1) + inv_prop_ols(2))];
bar(xlabel, barplot_data)
ylabel("Infant Birth Weight (Grams)", 'FontSize',16)
title("Birth Weight and Mother Smoker Status", 'FontSize',16)
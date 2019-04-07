function S = OLSWeighted(birth_weight, X, inv_prob_weight, beta)

    % Weighted sum of square errors
    S = sum(inv_prob_weight.*((birth_weight - X*beta).^2));

end

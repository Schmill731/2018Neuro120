function output = whiten_data(input)
    demeaned = input - mean(input);
    covar = cov(demeaned);
    [PC, S] = eig(covar);
    [sigma, sort_indices] = sort(diag(S), 'descend');
    PC_sorted = PC(:, sort_indices).*(1./sqrt(sigma));
    basis = PC_sorted(:, 1:size(input, 2));
    output = input*basis;
end
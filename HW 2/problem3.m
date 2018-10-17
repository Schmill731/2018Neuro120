%% Part A
clear all
load('problem3code/toWhiten.mat')

% Part i
demeaned = remove_mean(toWhiten);
mean2(demeaned)

% Part ii
covar_matrix = covariance_matrix(demeaned);
cov(demeaned);


function output = remove_mean(matrix)
    output = matrix - mean2(matrix);
end

function output = covariance_matrix(matrix)
    output = (matrix'*matrix)/(size(matrix, 1)-1);
end
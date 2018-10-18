%% Part A
clear all
load('toWhiten.mat')

% Part i
demeaned = remove_mean(toWhiten);
mean(demeaned)

% Part ii
covar_matrix = covariance_matrix(demeaned);
cov(demeaned);

% Part iii
[vectors, values] = eig(covar_matrix);
scatter(demeaned(:, 1), demeaned(:, 2));
hold on
plotv([5*vectors, -5*vectors], 'k')

% Part iv
rand1 = randn(1000, 5000);
rand2 = randn(5000, 1000);

tic;
[U1, S1, V1] = svd(rand1);
svd1 = toc;

tic;
[U2, S2, V2] = svd(rand2);
svd2 = toc;

tic;
covm1 = cov(rand1);
[U3, V3] = eig(covm1);
cov1 = toc;

tic;
covm2 = cov(rand2);
[U4, V4] = eig(covm2);
cov2 = toc;

%% Part B
ouput = whiten_data(toWhiten);
scatter(ouput(:, 1), ouput(:, 2))

%% Part C

% Plot images
clear all
load('mixedImg.mat');
plotImgs(imMix);

% Whiten Images
whitened_images = whiten_data(imMix);
plotImgs(whitened_images);


% Find separate images
weights = learnWeights(whitened_images);
final = whitened_images*weights;
plotImgs(final);

% Training on un-whitened images
weights=learnWeights(imMix);
final=imMix*weights;
plotImgs(final);

%% Part A Functions
function output = remove_mean(matrix)
    output = matrix - mean(matrix);
end

function output = covariance_matrix(matrix)
    output = (matrix'*matrix)/(size(matrix, 1)-1);
end
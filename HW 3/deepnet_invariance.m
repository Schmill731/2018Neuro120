
%% Load AlexNet 
net = alexnet;  % Load neural net. 


%% Plot weights from the first convolution layer

% Get the network weights for the second convolutional layer
w1 = net.Layers(2).Weights;

% Scale and resize the weights for visualization
w1 = mat2gray(w1);
w1 = imresize(w1,5);

% Display a montage of network weights. There are 96 individual sets of
% weights in the first layer.
figure
montage(w1)
title('First convolutional layer weights')

% List all the layers in the network
net.Layers

%% Run the peppers image through AlexNet

im = imresize(imread('peppers.png'),[227 227]);
label = classify(net, im);
imshow(im)
text(10,20,char(label),'Color','white')

%% Plot the neural activities of different filters

% f = activations(net, im, 'conv1');
% 
% for i = 1:96
%     filter = i;
%     subplot(131)
%     imshow(w1(:,:,:,filter))
%     axis square
%     title(sprintf('Filter #%d',filter))
% 
%     subplot(133)
%     imshow(im)
%     axis square
%     title('Original image')
% 
%     subplot(132)
%     imagesc(f(:,:,filter))
%     axis square
%     title('Response')
%     pause
% end

%% Load data from Kriegeskorte, N., Mur, M., Ruff, D. A., Kiani, R., Bodurka, J., Esteky, H., ? Bandettini, P. A. (2008). Matching Categorical Object Representations in Inferior Temporal Cortex of Man and Monkey. Neuron, 60(6), 1126?1141. http://doi.org/10.1016/j.neuron.2008.10.043

load RDM_stimuli


%% Test translation invariance
clear act_corr

im_num = 41; % German shephard image number.
im = images(:,:,:,im_num);

layers = {'data','conv1','pool1','conv5','pool5','fc7','prob'}

% translate image
translations = 0:5:180;
trans_correlations = zeros(length(translations), length(layers));
for i = 1:length(translations)
    im_trans = imtranslate(im, [translations(i) 0]);
    for j = 1:length(layers)
        output = activations(net, im, layers{j}, 'OutputAs', 'columns');
        output_trans = activations(net, im_trans, layers{j}, 'OutputAs', 'columns');
        trans_correlations(i, j) = corr(output, output_trans);
    end
end

figure();
plot(translations, trans_correlations, 'LineWidth', 2)
hold on
legend(layers)
xlabel('Translation Amount')
ylabel('Correlation Between Activations')

%% Test rotation invariance
clear act_corr

im_num = 41; % German shephard
im = images(:,:,:,im_num);

layers = {'data','conv1','pool1','conv5','pool5','fc7','prob'}

% rotate image
rotations = 0:5:180;
rot_correlations = zeros(length(rotations), length(layers));
for i = 1:length(rotations)
    im_rot = imrotate(im, rotations(i), 'nearest', 'crop');
    for j = 1:length(layers)
        output = activations(net, im, layers{j}, 'OutputAs', 'columns');
        output_rot = activations(net, im_rot, layers{j}, 'OutputAs', 'columns');
        rot_correlations(i, j) = corr(output, output_rot);
    end
end

figure();
plot(rotations, rot_correlations, 'LineWidth', 2)
hold on
legend(layers)
xlabel('Rotation Amount')
ylabel('Correlation Between Activations')

%% Test correlation between AlexNet RDMs and neural RDMs
clear c h

layers={'data','conv1','pool1','pool2','relu3','relu4','relu5','pool5','fc6','fc7','fc8'};

for i = 1:length(layers)
    d = 1 - corr(activations(net, images, layers{i}, 'OutputAs', 'columns')); % Compute AlexNet RDM at a specific layer
    subplot(131)
    imagesc(d)
    caxis([0 1])
    axis square

    d_data = RDM1; % Plot experimental RDM
    subplot(132)
    imagesc(d_data)
    caxis([0 1])
    axis square

    subplot(133) % Plot correlation
    plot(d(:),d_data(:),'.')
    xlim([0 1.5])
    ylim([0 1.5])
    axis square
    title(layers{i})

    RDM_corrs(i) = corr(d(:), d_data(:));
    pause
end

figure();
bar(1:length(RDM_corrs), RDM_corrs)
xticklabels(layers);


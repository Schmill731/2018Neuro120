%% Part A
clear all
Nh = [2, 10, 26];
text_height = [0.7, 0.8, 0.9];


for i = 1:3

    % Set up parameters
    N = 40; % Number of training samples
    epsilon = 0.0; % Amount of label noise
    lambda = 0;

    % Make dataset
    target_fn = @(t) sin(t);
    x = linspace(-pi,pi,N);
    y = target_fn(x) + epsilon*randn(size(x));

    Ntest = 100;
    x_test = linspace(-pi,pi,Ntest);
    y_test = target_fn(x_test);

    Ni = 2;

    % Compute network activity

    J = randn(Nh(i),Ni)/Nh(i);

    h = J*[x; ones(1,N)];
    h(h<0)=0;

    h_test = J*[x_test; ones(1,Ntest)];
    h_test(h_test<0)=0;


    % Now train linear regression to map from h to y

    w = y*h'*pinv(h*h' + lambda*eye(size(h, 1)));

    y_pred = w*h_test;

    mean_squared_error = norm(y_test-y_pred).^2;


    
    plot(x_test,y_pred)
    hold on
    set(gca, 'YLim', [-1.5 1.5])

    text(-pi,[.1 text_height(i)]*get(gca,'YLim')',sprintf('MSE for %d Neurons: %g ', Nh(i), mean_squared_error))
    xlabel('Input')
    ylabel('Output')
end

plot(x,y,'ob')
hold on
plot(x_test,y_test)
legend(sprintf('Prediction %d', Nh(1)), sprintf('Prediction %d', Nh(2)), ... 
    sprintf('Prediction %d', Nh(3)), 'Training data','Test data')

%% Part B
clear all
figure(2);
Nh = 1:40;
mse = zeros(40, 1000);
for i = 1:length(Nh)
    for j = 1:1000
        % Set up parameters
        N = 40; % Number of training samples
        epsilon = 0.0; % Amount of label noise
        lambda = 0;

        % Make dataset
        target_fn = @(t) sin(t);
        x = linspace(-pi,pi,N);
        y = target_fn(x) + epsilon*randn(size(x));

        Ntest = 100;
        x_test = linspace(-pi,pi,Ntest);
        y_test = target_fn(x_test);

        Ni = 2;

        % Compute network activity

        J = randn(Nh(i),Ni)/Nh(i);

        h = J*[x; ones(1,N)];
        h(h<0)=0;

        h_test = J*[x_test; ones(1,Ntest)];
        h_test(h_test<0)=0;


        % Now train linear regression to map from h to y

        w = y*h'*pinv(h*h' + lambda*eye(size(h, 1)));

        y_pred = w*h_test;

        mse(i, j) = norm(y_test-y_pred).^2;
    end

end

plot(1:40, mean(mse,2))
xlabel('Number of Neurons in Network');
ylabel('Mean Squared Error');

%% Part C
clear all
figure(3);
Nh = 40:20:500;
mse = zeros(length(Nh), 1000);
for i = 1:length(Nh)
    for j = 1:1000
        % Set up parameters
        N = 40; % Number of training samples
        epsilon = 0.0; % Amount of label noise
        lambda = 0;

        % Make dataset
        target_fn = @(t) sin(t);
        x = linspace(-pi,pi,N);
        y = target_fn(x) + epsilon*randn(size(x));

        Ntest = 100;
        x_test = linspace(-pi,pi,Ntest);
        y_test = target_fn(x_test);

        Ni = 2;

        % Compute network activity

        J = randn(Nh(i),Ni)/Nh(i);

        h = J*[x; ones(1,N)];
        h(h<0)=0;

        h_test = J*[x_test; ones(1,Ntest)];
        h_test(h_test<0)=0;


        % Now train linear regression to map from h to y

        w = y*h'*pinv(h*h' + lambda*eye(size(h, 1)));

        y_pred = w*h_test;

        mse(i, j) = norm(y_test-y_pred).^2;
    end

end

plot(Nh, mean(mse,2))
xlabel('Number of Neurons in Network');
ylabel('Mean Squared Error');

%% Part D
clear all

% Set up parameters
N = 40; % Number of training samples
epsilon = 0.0; % Amount of label noise
Nh = 500;
lambda = 0;

% Make dataset
target_fn = @(t) sin(t);
x = linspace(-pi,pi,N);
y = target_fn(x) + epsilon*randn(size(x));

Ntest = 100;
x_test = linspace(-pi,pi,Ntest);
y_test = target_fn(x_test);

Ni = 2;

% Compute network activity

J = randn(Nh,Ni)/Nh;

h = J*[x; ones(1,N)];
h(h<0)=0;

h_test = J*[x_test; ones(1,Ntest)];
h_test(h_test<0)=0;


% Now train linear regression to map from h to y

w = y*h'*pinv(h*h' + lambda*eye(size(h, 1)));

y_pred = w*h_test;

mean_squared_error = norm(y_test-y_pred).^2;


plot(x,y,'ob')
hold on
plot(x_test,y_test)
plot(x_test,y_pred)
set(gca, 'YLim', [-1.5 1.5])

text(-pi,[.1 0.9]*get(gca,'YLim')',sprintf('MSE for No Noise: %g ', mean_squared_error))
xlabel('Input')
ylabel('Output')

% Set up parameters
N = 40; % Number of training samples
epsilon = 0.2; % Amount of label noise
Nh = 500;
lambda = 0;

% Make dataset
target_fn = @(t) sin(t);
x = linspace(-pi,pi,N);
y = target_fn(x) + epsilon*randn(size(x));

Ntest = 100;
x_test = linspace(-pi,pi,Ntest);
y_test = target_fn(x_test);

Ni = 2;

% Compute network activity

J = randn(Nh,Ni)/Nh;

h = J*[x; ones(1,N)];
h(h<0)=0;

h_test = J*[x_test; ones(1,Ntest)];
h_test(h_test<0)=0;


% Now train linear regression to map from h to y

w = y*h'*pinv(h*h' + lambda*eye(size(h, 1)));

y_pred = w*h_test;

mean_squared_error = norm(y_test-y_pred).^2;


plot(x,y,'or')
hold on
plot(x_test,y_test)
plot(x_test,y_pred)
set(gca, 'YLim', [-1.5 1.5])

text(-pi,[.1 0.8]*get(gca,'YLim')',sprintf('MSE for Label Noise: %g ', mean_squared_error))

% Set up parameters
N = 40; % Number of training samples
epsilon = 0.0; % Amount of label noise
Nh = 500;
lambda = 1/exp(4);

% Make dataset
target_fn = @(t) sin(t);
x = linspace(-pi,pi,N);
y = target_fn(x) + epsilon*randn(size(x));

Ntest = 100;
x_test = linspace(-pi,pi,Ntest);
y_test = target_fn(x_test);

Ni = 2;

% Compute network activity

J = randn(Nh,Ni)/Nh;

h = J*[x; ones(1,N)];
h(h<0)=0;

h_test = J*[x_test; ones(1,Ntest)];
h_test(h_test<0)=0;


% Now train linear regression to map from h to y

w = y*h'*pinv(h*h' + lambda*eye(size(h, 1)));

y_pred = w*h_test;

mean_squared_error = norm(y_test-y_pred).^2;


hold on
plot(x_test,y_pred)
set(gca, 'YLim', [-1.5 1.5])

text(-pi,[.1 0.7]*get(gca,'YLim')',sprintf('MSE for Regularization: %g ', mean_squared_error))

% Set up parameters
N = 40; % Number of training samples
epsilon = 0.2; % Amount of label noise
Nh = 500;
lambda = 1/exp(4);

% Make dataset
target_fn = @(t) sin(t);
x = linspace(-pi,pi,N);
y = target_fn(x) + epsilon*randn(size(x));

Ntest = 100;
x_test = linspace(-pi,pi,Ntest);
y_test = target_fn(x_test);

Ni = 2;

% Compute network activity

J = randn(Nh,Ni)/Nh;

h = J*[x; ones(1,N)];
h(h<0)=0;

h_test = J*[x_test; ones(1,Ntest)];
h_test(h_test<0)=0;


% Now train linear regression to map from h to y

w = y*h'*pinv(h*h' + lambda*eye(size(h, 1)));

y_pred = w*h_test;

mean_squared_error = norm(y_test-y_pred).^2;


hold on
plot(x_test,y_pred)
set(gca, 'YLim', [-1.5 1.5])

text(-pi,[.1 0.6]*get(gca,'YLim')',sprintf('MSE for Regularization and Noise: %g ', mean_squared_error))

legend('Training data, no noise','Test data, no noise', 'Prediction: No Noise', ...
    'Training data, no noise','Test data, no noise','Prediction: Noise', ...
    'Prediction: Regularization, No Noise', 'Regularization, Noise')

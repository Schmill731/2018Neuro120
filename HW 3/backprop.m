clear all;

diag=true;

%% Load MNIST dataset and plot some examples

load mnist_sevens_nines

% Sevens
figure(1)
for i = 1:16
    subplot(4,4,i)
    imshow(reshape(X_train(:,i),28,28))
end

% Nines
figure(2)
for i = 1:16
    subplot(4,4,i)
    imshow(reshape(X_train(:,i+900),28,28))
end


%% Implement gradient descent
P = size(X_train,2); % Number of examples
max_itr = 5000;
alpha = (.1/P);

Ni = size(X_train,1); % Input dimension
Nh1 = 100; % Hidden layer sizes
Nh2 = 80;

% Initialize weight matrices
weight_scale = .01;
W3 = weight_scale*randn(1,Nh2);
W2 = weight_scale*randn(Nh2,Nh1);
W1 = weight_scale*randn(Nh1,Ni);


clear L acc L_test acc_test
for i = 1:max_itr
    
    % Compute forward propagation for train and test data
    
    % Train data
    u1 = W1*X_train;
    h1 = max(u1, 0);
    u2 = W2*h1;
    h2 = max(u2, 0);
    yh = W3*h2;
    
    % Test data
    yh_test = W3*max(W2*max(W1*X_test, 0), 0);
    
    % Compute losses and accuracy on train and test data
    L(i) = (1/2)*norm(y_train-yh,'fro')^2;
    acc(i) = mean(sign(yh)==sign(y_train));
    
    if diag
        disp(['at epoch ',num2str(i),' loss is ',num2str(L(i))])
        if L(i)>10^200
            pause
        end
    end
    
  
    L_test(i) = (1/2)*norm(y_test-yh_test,'fro')^2;
    acc_test(i) = mean(sign(yh_test)==sign(y_test));
    
    % Compute backprop (just on training data)
    e = y_train - yh;

    d3 = e;
    d2 = (W3'*d3).*d_relu(u2);
    d1 = (W2'*d2).*d_relu(u1);

    % Compute gradient
    g3 = d3*h2';
    g2 = d2*h1';
    g1 = d1*X_train';

    % Update weights
    W3 = W3 + alpha*g3;
    W2 = W2 + alpha*g2;
    W1 = W1 + alpha*g1;
end

% Plot the learning trajectory
t = 1:max_itr;

subplot(121)
plot(t,L/P,t,L_test/size(X_test,2),...
    'linewidth',2) 
% Plot train and test loss normalized by the number of examples
legend('Train loss','Test loss')
xlabel('Epochs')
ylabel('MSE')

subplot(122)
plot(t,acc,t,acc_test,'linewidth',2)
legend('Train accuracy','Test accuracy')

function d_res = d_relu(A)
    d_res = A;
    d_res(d_res >= 0) = 1;
    d_res(d_res < 0) = 0;
end
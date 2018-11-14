clear all

N = 50; % Number of neurons in network

dt = .1; % Discretization timestep
tau = .4; % Time constant

T = 100; % Max time
S = ceil(T/dt); % num simulation steps
t = ((1:S)-1)*dt; % time

%% Simulate network

% Set up recurrent weight structure

% W = zeros(N,N); % No recurrent connections

weight_scale = 1;
% W = weight_scale*eye(N); % Autapses

[U,~,~] = svd(randn(N,N)); % Random orthonormal connections
W = weight_scale*U;

noise_scale = 0.2;
W = W + noise_scale/sqrt(N)*randn(N,N);


% Create input
I = zeros(1,S);
I(t>1 & t<2)=1;

% Create weights from stimulus into neural population
V = ones(N,1);

r = zeros(N,S);
for s = 1:S-1
   r(:,s+1) = r(:,s) + (-r(:, s)+W*r(:, s) + V*I(:, s))*dt/tau;
end

% Calculate eigenvalues of recurrent weights

lam = eig(W);

% Calculate when activity died out
[row, col] = find(abs(r)<0.1);
freq = tabulate(col);
t_dead = t(freq(:, 2) == 50);
t_dead = min(t_dead(t_dead>2));

subplot(311)
plot(t,r')
hold on
if size(t_dead, 2) > 0
    plot([t_dead t_dead], [0 1])
end
xlabel('Time (a.u.)')
ylabel('Activity')
if size(t_dead, 2) > 0
    title(sprintf('Time At Which Network Becomes Inactive: %.2fs', t_dead));
else
    title('Network Remains Active');
end
subplot(312)
plot(t,I)
xlabel('Time (a.u.)')
ylabel('Input')
ylim([0,1.5])
subplot(313) % Plot eigenvalues of W in sorted order
plot(sort(abs(lam),'descend'),'.')
ylim([0,1.5])
xlabel('Eigenvalue #')
ylabel('Eigenvalue Magnitude |\lambda|')



clear all

%% Configure input current
fr = zeros(16, 1);
for i = 0:15
    Iapp = @(t) (t>100)*i;

    %% Simulate HH dynamics
    use_euler = true;

    theta0 = [0.0003    0.0529    0.3177    0.5961]; % Initial state
    Tfinal = 200; % Duration of simulation in ms
    dt = .01;
    if use_euler
        [t,theta] = euler_solver(@(t,x) hh_deriv(t,x,Iapp), [0 Tfinal], theta0, dt);
    else
        [t,theta] = ode45(@(t,x) hh_deriv(t,x,Iapp), [0 Tfinal], theta0);
    end

    %% Estimate firing rate
    vthresh = 20; % Consider a spike to have occured when voltage crosses this threshold (mV)
    t_thresh = 100; % Only compute firing rate using spikes occuring after this time (in ms)
    v = theta(:,1);
    tspike = t(v(1:end-1) <= vthresh & v(2:end) > vthresh);
    tspike(tspike < t_thresh) = []; % Throw away spikes occuring before t_thresh ms
    if isempty(tspike) % Handle zero firing rate
       tspike = [0 inf]; 
    end
    for ts = tspike
        vline(ts) 
    end

    fr(i+1) = 1000/median(diff(tspike));
end

plot([0:15], fr)
ylabel('Firing rate (Hz)')
zlabel('Current ($\mu$A)', 'Interpreter','latex') 
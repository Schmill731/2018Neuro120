clear all

load exposure_stimulus_experiment.mat

stimulus_start_times = 0:1/6:(60); % In seconds
%% Part A
% Make raster plot
figure(1);
hold on
for i = 1:(length(stimulus_start_times)-1)
    spikes_in_window = spikes_single_unit((spikes_single_unit > ...
        stimulus_start_times(i)) & (spikes_single_unit < ...
        stimulus_start_times(i + 1)));
    spikes_normalized = (spikes_in_window - stimulus_start_times(i))';
    trial_num = ones(1, length(spikes_normalized))*i;
    plot([spikes_normalized; spikes_normalized], [trial_num; trial_num-1],'k', 'LineWidth',3)    
end
xlim([0,0.167])
ylim([0,360])
yticks(0:30:360)
xlabel('Time (s)');
ylabel('Trial Number');
title('Response of a Single-Unit to the Exposure Stimulus');
%% Part B
% Create gaussian filter
figure(2);
x=[0:0.0001:1/6];
avg_dist = zeros(1,length(x));
for i = 1:(length(stimulus_start_times)-1)
    spikes_in_window = spikes_single_unit((spikes_single_unit > ...
        stimulus_start_times(i)) & (spikes_single_unit < ...
        stimulus_start_times(i + 1)));
    spikes_normalized = (spikes_in_window - stimulus_start_times(i))';
    trial_num = ones(1, length(spikes_normalized))*i;
    norm = zeros(1,length(x));
    for j=1:length(spikes_normalized)
        
        norm = norm + normpdf(x,spikes_normalized(j),0.005);
    end 
    avg_dist = avg_dist+norm;
end
plot(x,avg_dist./360)
xlabel('Time (s)');
ylabel('Firing Rate (Hz)');

%% Part C
% sigma = 50ms, 0.5ms
sigma = [0.05,0.0005]
for k = 1:2
    figure(k+2);
    x=[0:0.0001:1/6];
    avg_dist = zeros(1,length(x));
    for i = 1:(length(stimulus_start_times)-1)
        spikes_in_window = spikes_single_unit((spikes_single_unit > ...
            stimulus_start_times(i)) & (spikes_single_unit < ...
            stimulus_start_times(i + 1)));
        spikes_normalized = (spikes_in_window - stimulus_start_times(i))';
        trial_num = ones(1, length(spikes_normalized))*i;
        norm = zeros(1,length(x));
        for j=1:length(spikes_normalized)
            norm = norm + normpdf(x,spikes_normalized(j),sigma(k));
        end 
        avg_dist = avg_dist+norm;
    end
    plot(x,avg_dist./360)
    xlabel('Time (s)');
    ylabel('Firing Rate (Hz)');
end

%% Part D
figure(5);
hold on;
nbins = length(0:0.005:(1/6))
neural_data = {spikes_control, spikes_exp};
total_counts = {zeros(1, nbins), zeros(1, nbins)};
num_neurons = {N_control, N_exp};
for condition = 1:2
    for i = 1:(length(stimulus_start_times)-1)
        spikes_in_window = neural_data{condition}((neural_data{condition} > ...
            stimulus_start_times(i)) & (neural_data{condition} < ...
            stimulus_start_times(i + 1)));
        spikes_normalized = (spikes_in_window - stimulus_start_times(i))';
        total_counts{condition} = total_counts{condition} + hist(spikes_normalized, nbins);   
    end
    total_counts{condition} = (total_counts{condition}/(360*num_neurons{condition}*.005));
end
bar([total_counts{2}', total_counts{1}'])
legend('Experimental Group', 'Control Group')
xlabel('Time (s)')
ylabel('Number of Spikes')
xticks(1:2:nbins)
xticklabels(0:0.01:(1/6))


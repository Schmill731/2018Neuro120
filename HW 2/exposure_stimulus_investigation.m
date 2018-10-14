clear all

load exposure_stimulus_experiment.mat

stimulus_start_times = 0:1/6:(60); % In seconds

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
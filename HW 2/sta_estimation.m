clear all

% Load DMR stimulus specrogram and spiking responses from one neuron
load dmr_experiment

% Plot spectrogram of stimulus
plot_spectrogram(stim_spectrogram, stim_time, stim_freq)

%% Generate STA
t_past = 125; % in ms
t_future = 125; % in ms
sampling_rate = mean(median(diff(stim_time)));
sta_time = (-t_past/1000):sampling_rate:(t_future/1000);
sta_freq = stim_freq;

freq_of_interest = zeros(38, 982);
for i = 1:982
    matrix = abs(spikes(i)-stim_time);
    index = find(matrix == min(matrix));
    times_of_interest = sta_time + stim_time(index);
    logical = zeros(1, length(stim_time));
    for j = 1:51
        logical = logical + (stim_time == times_of_interest(j));
    end
    freq_of_interest(:, i) = stim_spectrogram(:, logical);
end


% freq_of_interest = stim_spectrogram(:, time_windows(1, :));
% freq_of_interest = [freq_of_interest(1:25), 0, freq_of_interest(26:50)];

% sta = ???

% Plot results
% figure(2)
% plot_spectrogram(sta, sta_time, sta_freq);
% xlabel('Time relative to spike (ms)')
% colorbar
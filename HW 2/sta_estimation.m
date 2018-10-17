clear all

% Load DMR stimulus specrogram and spiking responses from one neuron
load dmr_experiment

% Plot spectrogram of stimulus
figure(1)
plot_spectrogram(stim_spectrogram, stim_time, stim_freq)

%% Generate STA
figure(2)
t_past = 125; % in ms
t_future = 125; % in ms
sampling_rate = mean(median(diff(stim_time)));
sta_time = (-t_past/1000):sampling_rate:(t_future/1000);
sta_freq = stim_freq;

sta_spectro = zeros(38, 51);
for i = 1:982
    spike_index = floor(spikes(i)/0.005);
    for j = 1:38
        sta_spectro(j,:) = sta_spectro(j,:)+stim_spectrogram(j,spike_index-25:spike_index+25);
    end
end

sta_spectro = sta_spectro/982;

plot_spectrogram(sta_spectro, sta_time, sta_freq)
colorbar;

%% Plot stimulus correlation matrix
figure(3);
plot_spectrogram(stim_spectrogram*stim_spectrogram', 38, stim_freq);
colorbar;
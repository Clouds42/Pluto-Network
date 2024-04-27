clearvars; close all;

%% Modulate message using BPSK
msg = 'Hello, world!'; % 60 bytes max
if length(msg) > 60
    error('Error: msg is too long, please make sure msg shorter than 60 bytes.');
end
tx_data = bpsk_tx_func(msg); 

%% Instantiate Pluto receive class
rx = pluto('usb', 'rx');
rx.SamplesPerFrame = numel(tx_data) * 2;
rx_data = rx(); % reveive data

%% Demodulate message
[msg_raw, valid] = bpsk_rx_func(rx_data);
if valid
    disp(msg_raw);
end

%% Release Pluto classes
rx.release;
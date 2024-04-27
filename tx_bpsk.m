clearvars; close all;

%% Modulate message using BPSK
msg = 'Hello, world!'; % 60 bytes max
if length(msg) > 60
    error('Error: msg is too long, please make sure msg shorter than 60 bytes.');
end
tx_data = bpsk_tx_func(msg); 

%% Instantiate Pluto transmit class
tx = pluto('usb', 'tx');
tx(tx_data); % transmit data

%% Release Pluto classes(manually)
% tx.release;
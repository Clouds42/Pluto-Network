clearvars; close all;

%% Modulate message using BPSK
msg = 'Bye!'; % 60 bytes max
if length(msg) > 60
    error('Error: msg is too long, please make sure msg shorter than 60 bytes.');
end
tx_data = bpsk_tx_func(msg);

%% Instantiate Pluto transmit class
tx = pluto('usb', 'tx');
tx.CenterFrequency = 2e9;
% tx(tx_data); % transmit data

%% Instantiate Pluto receive class
rx = pluto('usb', 'rx');
% rx.CenterFrequency = 2.4e9;
rx.SamplesPerFrame = numel(bpsk_tx_func('Hello!')) * 2;

%% Demodulate message
rx_data = rx(); % reveive data
[msg_raw, valid] = bpsk_rx_func(rx_data);
while ~strcmp(msg_raw, 'Hello!')
    rx_data = rx(); % reveive data
    [msg_raw, valid] = bpsk_rx_func(rx_data);
    if valid
        disp(msg_raw);
    else
        disp('Waiting...')
    end
    pause(1)
end
tx(tx_data); % transmit data
disp('Msg Received! ACK transmitted!');

%% Release Pluto classes
tx.release;
rx.release;
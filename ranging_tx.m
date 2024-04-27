clearvars; close all;

%% Modulate message using BPSK
msg = 'SEQ1';
tx_data = bpsk_tx_func(msg);

%% Instantiate Pluto transmit class
tx = pluto('usb', 'tx');
% tx.CenterFrequency = 2.4e9;
tx(tx_data); % transmit data
disp('001 Transmitted!');

%% Instantiate Pluto receive class
rx = pluto('usb', 'rx');
rx.CenterFrequency = 2e9;

%% Demodulate message
rx_data = rx(); % reveive data
[msg_raw, valid] = bpsk_rx_func(rx_data);
while ~strcmp(msg_raw, 'ACK1')
    rx_data = rx(); % reveive data
    [msg_raw, valid] = bpsk_rx_func(rx_data);
    if valid
        disp(msg_raw);
    end
end
disp('001 ACK Received!');

msg = 'FIN';
tx_data = bpsk_tx_func(msg);
tx(tx_data); % transmit data
disp('FIN Transmitted!');

rx_data = rx(); % reveive data
[msg_raw, valid] = bpsk_rx_func(rx_data);
while ~strcmp(msg_raw, 'ACKF')
    rx_data = rx(); % reveive data
    [msg_raw, valid] = bpsk_rx_func(rx_data);
    if valid
        disp(msg_raw);
    end
end
disp('FIN ACK Received!');

%% Release Pluto classes
tx.release;
rx.release;
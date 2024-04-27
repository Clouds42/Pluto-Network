clearvars; close all;

%% Instantiate Pluto transmit class
tx = pluto('usb', 'tx');
tx.CenterFrequency = 2e9;
% tx(tx_data); % transmit data

%% Instantiate Pluto receive class
rx = pluto('usb', 'rx');
% rx.CenterFrequency = 2.4e9;

%% Demodulate message
rx_data = rx(); % reveive data
[msg_raw, valid] = bpsk_rx_func(rx_data);
while ~strcmp(msg_raw, 'SEQ1')
    rx_data = rx(); % reveive data
    [msg_raw, valid] = bpsk_rx_func(rx_data);
    if valid
        disp(msg_raw);
    end
end
disp('001 Received!');

msg = 'ACK1';
tx_data = bpsk_tx_func(msg);
tx(tx_data); % transmit data
disp('001 ACK Transmitted!');

rx_data = rx(); % reveive data
[msg_raw, valid] = bpsk_rx_func(rx_data);
while ~strcmp(msg_raw, 'FIN')
    rx_data = rx(); % reveive data
    [msg_raw, valid] = bpsk_rx_func(rx_data);
    if valid
        disp(msg_raw);
    end
end
disp('FIN Received! ');

msg = 'ACKF';
tx_data = bpsk_tx_func(msg);
tx(tx_data); % transmit data
disp('FIN ACK Transmitted!');

%% Release Pluto classes
tx.release;
rx.release;
clearvars; close all;

%% Modulate message using BPSK
msg_idx = 1;
msg_cap = 50;
msg = ['SEQ', int2str(msg_idx)];
tx_data = bpsk_tx_func(msg);

%% Instantiate Pluto transmit class
tx = pluto('usb', 'tx');
% tx.CenterFrequency = 2.4e9;

%% Instantiate Pluto receive class
rx = pluto('usb', 'rx');
rx.CenterFrequency = 2e9;

%% Demodulate message
rx_data = rx(); % reveive data
[msg_raw, valid] = bpsk_rx_func(rx_data); tic;
while msg_idx <= msg_cap
    msg = ['SEQ', int2str(msg_idx)];
    tx_data = bpsk_tx_func(msg);
    tx(tx_data); % transmit data
    disp([msg, ' Transmitted!']);

    while ~strcmp(msg_raw, ['ACK', int2str(msg_idx)])
        rx_data = rx(); % reveive data
        [msg_raw, valid] = bpsk_rx_func(rx_data);
        % if valid
        %     disp(msg_raw);
        % end
    end
    disp(['ACK', int2str(msg_idx), ' Received!']);
    msg_idx = msg_idx + 1;
end
toc;
%% Release Pluto classes
tx.release;
rx.release;
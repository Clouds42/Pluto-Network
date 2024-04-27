clearvars; close all;

msg_idx = 1;
msg_cap = 50;

%% Instantiate Pluto transmit class
tx = pluto('eth', 'tx');
tx.CenterFrequency = 2e9;

%% Instantiate Pluto receive class
rx = pluto('eth', 'rx');
% rx.CenterFrequency = 2.4e9;

%% Demodulate message
rx_data = rx(); % reveive data
[msg_raw, valid] = bpsk_rx_func(rx_data);
while msg_idx <= msg_cap
    while ~strcmp(msg_raw, ['SEQ', int2str(msg_idx)])
        rx_data = rx(); % reveive data
        [msg_raw, valid] = bpsk_rx_func(rx_data);
        % if valid
        %     disp(msg_raw);
        % end
    end
    disp(['SEQ', int2str(msg_idx), ' Received!']);
    
    msg = ['ACK', int2str(msg_idx)];
    tx_data = bpsk_tx_func(msg);
    tx(tx_data); % transmit data
    disp([msg, ' Transmitted!']);
    msg_idx = msg_idx + 1;
end
pause(1);
%% Release Pluto classes
tx.release;
rx.release;
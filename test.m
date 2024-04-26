clearvars;

%% Modulate message using BPSK
msg = 'Hello, world!'; % 60 bytes max
if length(msg) > 60
    error('Error: msg is too long, please make sure msg shorter than 60 bytes.');
end
tx_data = bpsk_tx_func(msg); 

%% Instantiate Pluto transmit class
tx = pluto('tx'); tic;
tx(tx_data); % transmit data

%% Instantiate Pluto receive class
rx = pluto('rx');
rx.SamplesPerFrame = numel(tx_data) * 2;
rx_data = rx(); % reveive data

%% Demodulate message
[msg_raw, valid] = bpsk_rx_func(rx_data); toc;
if valid
    disp(msg_raw(1, :));
end

%% Release Pluto classes
tx.release;
rx.release;
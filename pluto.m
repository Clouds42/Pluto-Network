function sys_obj = pluto(cable, mode)
    switch cable
        case 'usb'
            uri = 'ip:192.168.2.1';
        case 'eth'
            uri = 'ip:192.168.1.10';
        otherwise
            error(['Error: cant find device at ', cable]);
    end

    switch mode
        case 'tx'
            sys_obj = adi.Pluto.Tx;
            sys_obj.uri = uri;
            sys_obj.EnableCyclicBuffers = 1;
            sys_obj.RFPortSelect = "B";
        case 'rx'
            sys_obj = adi.Pluto.Rx;
            sys_obj.uri = uri;
            sys_obj.RFPortSelect = "B_BALANCED";
        otherwise
            error(['Error: cant find mode ', mode, ', please check your input.'])
    end
end
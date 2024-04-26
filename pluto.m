function sys_obj = pluto(mode)
    switch mode
        case 'tx'
            sys_obj = adi.Pluto.Tx;
            sys_obj.uri = 'ip:192.168.2.1';
            sys_obj.EnableCyclicBuffers = 1;
            sys_obj.RFPortSelect = "B";
        case 'rx'
            sys_obj = adi.Pluto.Rx;
            sys_obj.uri = 'ip:192.168.2.1';
            sys_obj.RFPortSelect = "B_BALANCED";
        otherwise
            error(['Error: cant find mode ', mode, ', please check your input.'])
    end
end
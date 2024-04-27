% Number of nanoseconds that have elapsed since J2000
% J2000 is January 1, 2000, 12:00 Terrestrial Time (TT)

function ts = timestamp()
    current_time = datetime;
    current_time.TimeZone = 'UTCLeapSeconds';
    ts = convertTo(current_time, 'tt2000');
end
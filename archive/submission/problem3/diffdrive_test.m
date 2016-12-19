function dzdt=diffdrive_test(z, waypoints)
    r=0.1; % Radius of wheel
    L=0.5; % Distance between wheels
    [UR, UL] = determine_control(z, L, waypoints);
    dzdt = [
        (r*(UR+UL)/2)*cos(z(3));
        (r*(UR+UL)/2)*sin(z(3));
        (r*(UR-UL)/L)
        ];
end
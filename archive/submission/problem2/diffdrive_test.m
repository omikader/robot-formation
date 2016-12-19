function dzdt=diffdrive_test(z, waypoints, theta_final)
    r=0.1; % Radius of wheel
    L=0.5; % Distance between wheels
    [UR, UL] = determine_control(z, L, waypoints, theta_final);
    dzdt = [
        (r*(UR+UL)/2)*cos(z(3));
        (r*(UR+UL)/2)*sin(z(3));
        (r*(UR-UL)/L)
        ];
end
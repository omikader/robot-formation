function dzdt=diffdrive_pose(z, waypoints, theta_final)
% Function to drive a robot from its position to a final position and
% orient it to a final pose.
r=0.1; % Radius of wheel
L=0.5; % Distance between wheels
[UR, UL] = determine_control_pose(z, L, waypoints, theta_final);
dzdt = [
    (r*(UR+UL)/2)*cos(z(3));
    (r*(UR+UL)/2)*sin(z(3));
    (r*(UR-UL)/L)
    ];
end
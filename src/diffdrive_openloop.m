function dzdt = diffdrive_openloop(t,z)
    r=0.1; % Radius of wheel
    L=0.5; % Distance between wheels

    % Open loop controls:
    %   1) For 2 seconds, power both wheels at 5 rad/sec to translate the
    %   car forwards
    %   2) For 0.5 seconds, power the right wheel at 5 rad/sec and stall
    %   the left wheel to rotate the car left
    %   3) For 8.5 seconds, power both wheels at 5 rad/sec to translate the
    %   car forwards
    %
    % Using a linear combination of heaviside function inputs, we can
    % maneuever the car to any final pose that we desire

    UR = 5*(heaviside(t) - heaviside(t-2)) + ...
         5*(heaviside(t-2) - heaviside(t-2.5)) + ...
         5*(heaviside(t-2.5) - heaviside(t-10));
    UL = 5*(heaviside(t) - heaviside(t-2)) + ...
         0*(heaviside(t-2) - heaviside(t-2.5)) + ...
         5*(heaviside(t-2.5) - heaviside(t-10));

    % differential equations that govern the motion of the robot in state
    % variable representation

    dzdt = [
    (r*(UR+UL)/2)*cos(z(3));
    (r*(UR+UL)/2)*sin(z(3));
    (r*(UR-UL)/L)
    ];
end
function dzdt=diffdrive_Nrobots(z, waypoints, startingPoints, startingAngle)
% This defines the right hand side of the differential equation model for
% the simple car with two wheels. UR,rt is the control for the right wheel
% and UL,lt is the control for the left wheel
N=length(z)/4;
r=0.1; % Radius of wheel
L=0.5; % Distance between wheels
[UR, UL] = determine_control_Nrobots(z, L, waypoints, startingPoints, startingAngle);

dzdt=createDZDT(z, N, UR, UL, r, L);
end





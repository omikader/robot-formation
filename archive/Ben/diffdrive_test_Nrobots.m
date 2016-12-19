function dzdt=diffdrive_test_Nrobots(z, waypoints)
% This defines the right hand side of the differential equation model for
% the simple car with two wheels. UR,rt is the control for the right wheel
% and UL,lt is the control for the left wheel
N=length(z)/4;
r=0.1; % Radius of wheel
L=0.5; % Distance between wheels
[UR, UL] = determine_control_Nrobots(z, L, waypoints);

dzdt=createDZDT(z, N, UR, UL, r, L);
end
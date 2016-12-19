function dzdt=eric_diffdrive_test_tworobots(z, waypoints)
% This defines the right hand side of the differential equation model for
% the simple car with two wheels. UR,rt is the control for the right wheel
% and UL,lt is the control for the left wheel
N=size(Z)/4;
r=0.1; % Radius of wheel
L=0.5; % Distance between wheels
[UR, UL] = determine_control_Nrobots(z, L, waypoints);

dzdt = [];

for i=1:N
    dzdt = [dzdt; 
    (r*(UR(N)+UL(N))/2)*cos(z((N-1)*4+3));
    (r*(UR(N)+UL(N))/2)*sin(z((N-1)*4+3));
    (r*(UR(N)-UL(N))/L);
    0];
end
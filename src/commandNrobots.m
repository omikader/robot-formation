%% Ben Cannon
function [t,z] = commandNrobots(tend, carStates, waypoints)
% This function prepares all the initial conditions needed for the passed in 
% carStates, including their order and target startign points,
% to follow the passed in path (waypoints) and then executes ode45 to find 
% their poses z for 0<=t<=tend.  

clearvars -global %Essential for this to work (will eventually write something more clever using persistent variables)
% Initialize
tspan = [0 tend];

%Number of cars
numRobots = length(carStates(:,1));

% Get the starting points and starting angle for each robot
[ordered_startingPoints, startingAngle,order] = ...
    calculateCarPos(carStates,waypoints,numRobots);

%Create initial conditions
ic = [];
for k = 1:numRobots
ic = [ic, carStates(k,:),order(k)]; 
end
ic = ic';

%Run the ode solver with diff drive
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,z] = ode45(@(t,z) diffdrive_Nrobots(z,waypoints,ordered_startingPoints, startingAngle), tspan, ic, opts);

% Testing
% % Plot immediately
% plot_Z_immediately(t, z)
% 
% % Plot Point by Point
% plot_Z_pointbypoint(t,z)

end


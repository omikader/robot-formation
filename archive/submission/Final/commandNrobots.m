%% Ben Cannon
function [t,z] = commandNrobots(tend, carStates, waypoints)
clearvars -global %Essential for this to work
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


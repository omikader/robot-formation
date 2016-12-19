%% Ben Cannon
function [t,z] = main_test_Nrobots
clearvars -global %Essential for this to work
% Initialize
tend=100;   %Time we run for
tspan = [0 tend];

%Define Path
% waypoints = [1 0; 5 0; 5 5];

% waypoints = [10 10; 9 9; 5 4; 2 3];

waypoints = [2.00    1.00;
    1.25    1.75;
    5.25    8.25;
    7.25    8.75;
    11.75   10.75;
    12.00   10.00];


%Initial Carposes
% carStates = [1 1 pi; 1 4 0; 4 3 0]; % Works
%carStates = [1 1 pi; 4 3 0; 1 4 0]; % Works

carStates = [1 1 pi; 1 4 0; 4 3 0; 7 7 -pi/4];

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

opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,z] = ode45(@(t,z) diffdrive_test_Nrobots(z,waypoints,ordered_startingPoints, startingAngle), tspan, ic, opts);

% Plot immediately
%plot_Z_immediately(t, z)

% plot Point by Point
plot_Z_pointbypoint(t,z)

end


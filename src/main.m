%% Main
% Ben Cannon, Eric Wallace, Omar Abdelkader
% ENEE 322 Extra Credit Project
% This script executes problems 1-5 for the extra credit
clear; close all;

%% Part 1: Develop a simulation of the model equations for some open loop controls.
% define time boundaries
tend = 10;
tspan = [0 tend];

% define initial conditions
ic = [0; 0; 0];

% solve ode with open loop feedback control
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t1,z1] = ode45(@(t1,z1) diffdrive_openloop(t1,z1), tspan, ic, opts);


% Plot immediately
plot_Z_immediately(t1, z1)

% Plot Point by Point
% plot the resulting car behavior
figure
iterations = 1;
pausetime = 0.1;
for i = 1 : size(z1)
    plot(z1(iterations,1),z1(iterations,2),'.','color',[0; 0; 0],'markersize',14,'MarkerFaceColor','b');
    hold on
    xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k');
    ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k');
    title(['Part 1: Robot Pose Versus Time t = ' num2str(t1(iterations))],'FontSize',16,'FontWeight','bold','Color','k');
    axis([min(z1(:,1)) max(z1(:,1)) min(z1(:,2)) max(z1(:,2))])
    iterations  = iterations + 1;
    pause(pausetime)
end

%% Part 2 Acheive a target pose given an initial pose
% define time boundaries
tend = 20;
tspan = [0 tend];

% define initial conditions
ic = [0; 0; pi()/2];

% define target pose (final state)
fs = [5; 5; 0];

% define waypoints/path (in this case our path is only one point)
waypoints = [ic(1) ic(2); fs(1) fs(2)];

% solve ode
clearvars -global
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t2,z2] = ode45(@(t2,z2) diffdrive_pose(z2,waypoints,fs(3)), tspan, ic, opts); % plot(z(:,1),z(:,2));grid

% Plot immediately
plot_Z_immediately(t2, z2)

% Plot point by point

% plot the resulting car behavior

iterations = 1;
pausetime = 0.1;
figure
hold on
xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k');
ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k');
for i = 1 : size(z2)
    plot(z2(iterations,1),z2(iterations,2),'.','color',[0; 0; 0],'markersize',14,'MarkerFaceColor','b');
    title(['Part 2: Robot Pose Versus Time t = ' num2str(t2(iterations))],'FontSize',16,'FontWeight','bold','Color','k');
    axis([min(z2(:,1)) max(z2(:,1)) min(z2(:,2)) max(z2(:,2))])
    iterations  = iterations + 1;
    pause(pausetime)
end


%% Part 3 Intercept and Follow a path
% Here the path is defined by waypoints = [x1 y1; x2 y2;...]

% define time boundaries
tend = 100;
tspan = [0 tend];

% define initial carposes
carStates = [0 0 pi/4];

% define waypoints/path
waypoints = [2.00    1.00;
    1.25    1.75;
    5.25    8.25;
    7.25    8.75;
    11.75   10.75;
    12.00   10.00];

[t3,z3] = commandNrobots(tend, carStates, waypoints);

% Plot immediately
plot_Z_immediately(t3, z3)

% Plot Point by Point
% plot the resulting car behavior
iterations = 1;
pausetime = 0.1;
figure
xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k');
ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k');
hold on
for i = 1 : size(z3)
    plot(z3(iterations,1),z3(iterations,2),'.','color',[0; 0; 0],'markersize',14,'MarkerFaceColor','b');
    title(['Robot Pose Versus Time t = ' num2str(t3(iterations))],'FontSize',16,'FontWeight','bold','Color','k');
    axis([min(z3(:,1)) max(z3(:,1)) min(z3(:,2)) max(z3(:,2))])
    iterations  = iterations + 1;
    pause(pausetime)
end


%% Part 4: Two Robots
% Two robots at random starting positions meet in a line and follow a path

% Example Initialization
% end time
tend = 100;
% Initial Carposes
carStates = [0 1 0; 2 2 -pi/2];
% Define Path
waypoints = [1 0; 3 0; 5 5];


[t4,z4] = commandNrobots(tend, carStates, waypoints);

% Plot immediately
plot_Z_immediately(t4, z4)

% Plot Point by Point
plot_Z_pointbypoint(t4,z4)



%% Part 5: N robots
% N robots at random starting positions meet in a line and follow a path


% Example Initialization
% end time
tend = 100;
%Initial Carposes
carStates = [1 1 pi; 1 4 0; 4 3 0; 4 4 -pi/4];
% Define Path
waypoints = [2.00    1.00;
    1.25    1.75;
    5.25    8.25;
    7.25    8.75;
    11.75   10.75;
    12.00   10.00];

[t5,z5] = commandNrobots(tend, carStates, waypoints);

% Plot immediately
plot_Z_immediately(t5, z5)

% Plot Point by Point
plot_Z_pointbypoint(t5,z5)


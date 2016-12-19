
%% Ben Cannon
function [t,z] = main_test
clearvars -global
tend=100;
tspan = [0 tend];
% ic = [1.95; 3.75; 2.99]; %Fucks our shit up
ic = [0; 0; pi/4];
% ic = [0; 0; 2.99]; %Bit better

% Declare waypoints (MUST BE AT LEAST TWO!...for now)

% waypoints = [3 5];
waypoints = [0 0; 5 0; 5 5]; % Works

% waypoints = [0 1; 0 5]; % Works
% waypoints = [0 3; 5 3; 4 4]; % Doesn't quite make it with FOSU
% waypoints = [0 3; 5 3; 5 7]; %Works
%
% waypoints = [2.00    1.00;        % Works pretty well
%     1.25    1.75;
%     5.25    8.25;
%     7.25    8.75;
%     11.75   10.75;
%     12.00   10.00];

%  waypoints = [7,4];
%  waypoints=[3 6]; % Doesn't quite make it for fosu

waypoints = [ic(1) ic(2); waypoints];
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,z] = ode45(@(t,z) diffdrive_test(z,waypoints), tspan, ic, opts); % plot(z(:,1),z(:,2));grid
figure
plot(z(:,1),z(:,2));grid
xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k');
ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k');
title('Robot Pose Versus Time','FontSize',16,'FontWeight','bold','Color','k');
axis square
end


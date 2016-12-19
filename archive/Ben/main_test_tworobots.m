
%% Ben Cannon
function [t,z] = main_test_tworobots
clearvars -global
tend=100;
tspan = [0 tend];

order1 = 1;
order2 = 2;
 ic = [1; 0; 0; order1;  %Already Line
     0; 0; 0; order2];

%ic = [10; 10; 0; order1;  %Already Line
%    12; 12; 0; order2];



waypoints = [1 0; 5 0; 5 5];

% waypoints = [10 10; 9 9; 5 4; 2 3];

% waypoints = [2.00    1.00;       
%     1.25    1.75;
%     5.25    8.25;
%     7.25    8.75;
%     11.75   10.75;
%     12.00   10.00];


%waypoints = [ic(1) ic(2); waypoints]; % Needs to be re written for N robots

opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,z] = ode45(@(t,z) diffdrive_test_tworobots(z,waypoints), tspan, ic, opts); 
figure
hold on
plot(z(:,1),z(:,2));
plot(z(:,5),z(:,6));
grid;
xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k');
ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k');
title('Robot Pose Versus Time','FontSize',16,'FontWeight','bold','Color','k');
axis square
hold off
end



%% Ben Cannon
function [t,z] = main_test
tend=20;
tspan = [0 tend];
ic = [2; 0; 0];
waypoints = [1 1; 7 1];
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,z] = ode45(@(t,z) diffdrive_test(z,waypoints), tspan, ic, opts); % plot(z(:,1),z(:,2));grid
figure
plot(z(:,1),z(:,2));grid
xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k'); 
ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k'); 
title('Robot Pose Versus Time','FontSize',16,'FontWeight','bold','Color','k');
end


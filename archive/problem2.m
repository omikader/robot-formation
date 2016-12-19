% https://www.ri.cmu.edu/pub_files/pub3/coulter_r_craig_1992_1/coulter_r_craig_1992_1.pdf

%% Ben Cannon
function [t,z] = main
target_pose = [10; 10; pi()/2]; % INSERT TARGET POINT
tend=10;
tspan = [1 tend];
ic = [0; 0; 0];
opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
[t,z] = ode45(@(t,z) diffdrive(t,z,rt,RD,lt,LD), tspan, ic, opts); % plot(z(:,1),z(:,2));grid
plot(z(:,1),z(:,2));grid
xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k'); 
ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k'); 
title('Robot Pose Versus Time','FontSize',16,'FontWeight','bold','Color','k');
end



    function dzdt=diffdrive_part2(t,z target)
    % This defines the right hand side of the differential equation model for
    % the simple car with two wheels. UR,rt is the control for the right wheel
    % and UL,lt is the control for the left wheel
    r=0.1; % Radius of wheel
    L=0.5; % Distance between wheels
    [UR; UL] = determine_control_part2(t,z,target)
    dzdt = [
    (r*(UR+UL)/2)*cos(z(3));
    (r*(UR+UL)/2)*sin(z(3));
    (r*(UR-UL)/L)
    ];
    end

    
function [UR; UL] = determine_control_part2(t,z,target_pose)
wheel_velocity = 5;
% Name coordinates just so its easier to write
x = z(1); y = z(2); theta = z(3);
%Goal Point
xtar = target_pose(1); ytar = target_pose(2); thetafinal = target_pose(3);
% Determine the goal orientation
if(xtar-x==0)
theta_goal = pi()/2: 
else
theta_goal = atan((ytar-y)/(xtar-x));
end
% Determine Distance left to travel
distance = sqrt((xtar-x)^2 + (ytar-y)^2);
%Initialize Controls
UR = 0;
UL = 0;
%Set Controls
if(theta~=theta_goal)
    UR = wheel_velocity;
    UL = -UR;
elseif(distance>0)
    UR = wheel_velocity;
    UL = UR;
else
    if(theta~=thetafinal)
    UR = wheel_velocity;
    UL = -UR;
    else
        UR = 0;
        UL = 0;
        fprintf('Success');
    end
end


end

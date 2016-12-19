%% Ben Cannon
function [UR, UL] = determine_control_tworobots(z, L, waypoints)
N = length(z)/4;
for i = 1:N
    if(i ==1)
        xr = z(1); yr = z(2); theta = z(3); order = z(4);
    else
        xr = [xr;z(1+(N-1)*4)]; yr = [yr; z(2+(N-1)*4)]; theta = [theta;z(3+(N-1)*4)];order = [order;z(4+(N-1)*4)];
    end
    while((theta(i)>2*pi())||(theta(i)<0)) %Ensure theta is in the bounds between [0, 2pi]
        if(theta(i)>2*pi())
            theta(i)=theta(i)-2*pi();
        else
            theta(i) = theta(i)+2*pi();
        end
    end
end
% MAY NEED SOME OF THE ORDERING STUFF AS GLOBALS (leader index, etc.)
global xprev yprev prevind xnext ynext nextind finish orientMode; % IGNORING ORIENT MODE FOR NOW

if isempty(xprev)
    xprev = waypoints(1,1);
    yprev = waypoints(1,2);
    prevind = 1;
    xnext = waypoints(2,1);
    ynext = waypoints(2,2);
    nextind = 2;
    finish = 0;
    %    orientMode = 1; % IGNORING FOR NOW
end

% if (orientMode)
%     % Turning Parameters
%     degree_offset = 45;
%     rad_offset = degree_offset*(pi()/180);
%     wheel_velocity=5;
%     % Determine goal angle
%     goal_angle = findGoalAngle(xr, yr, xnext, ynext);
%     % Determine turning direction
%     direction = findTurnDirection(theta,goal_angle);
%     [orientMode UL UR] = turn2GoalAngle(theta, goal_angle, direction, rad_offset, wheel_velocity);


% else

% Determine leader index
for i = 1:N
    if(order(i) == 1)
        leaderindex = i;
        break;
    end
end

% LEADER MODE
[URleader, ULleader] = commandLeader(xr(leaderindex), yr(leaderindex), theta(leaderindex), L, waypoints);

% FOLLOWER MODE
robot_spacing = 1; %Keep robots one meter apart
[UR, UL] = commandFollower(xr, yr, theta, order, N, robot_spacing, L); % GIVES ALL UR and UL except leaders
UR(leaderindex) = URleader; %add leaders controls into UR and UL
UL(leaderindex) = ULleader;

% end
end
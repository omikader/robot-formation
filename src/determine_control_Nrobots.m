%% Ben Cannon
function [UR, UL] = determine_control_Nrobots(z, L, waypoints, startingPoints, startingAngle)
% This function orients N robot towards their starting points
% by adjusting their theta then when within a certain tolerance implements
% the pure pursuit procedure to drive to the goal point.   Once within a
% certain distance it then turns to face the starting angle.  
% After that the first robot tracks the path defined by the waypoints using 
% the pure pursuit algorithm and the other robots track the robot in front 
% of them using the pure pursuit algorithm.  They all stop when the leader
% reaches the end of the path and the others are within 1 unit of each
% other.

% This is used to make coding simpler
[N, xr, yr, theta, order] = decomposeState(z);

% Initialize global variables
global xprev yprev prevind xnext ynext nextind finish orientMode; 
if isempty(xprev)
    xprev = waypoints(1,1);
    yprev = waypoints(1,2);
    prevind = 1;
    xnext = waypoints(2,1);
    ynext = waypoints(2,2);
    nextind = 2;
    finish = 0;
    orientMode = 1;
end

% All robots get to their starting positions and angles
if (orientMode)
    ready = [];
    for k = 1:N
        ready(k) = 0;
        keepTurning = 1;
        reachedStart = 0;
        % Turning Parameters
        degree_offset = 90;
        rad_offset = degree_offset*(pi()/180);
        wheel_velocity=5;
        % Determine angle to get to starting point
        goal_angle = findGoalAngle(xr(k), yr(k), startingPoints(k,1), startingPoints(k,2));
        % Determine turning direction
        direction = findTurnDirection(theta(k),goal_angle);
        %Turn to starting point
        [keepTurning, UL(k), UR(k)] = turn2GoalAngle(theta(k), goal_angle, direction, rad_offset, wheel_velocity);
        if(~keepTurning)
            [goalpoint, reachedStart] = findGoalPoint(xr(k), yr(k), xr(k), yr(k), startingPoints(k,1), startingPoints(k,2));
            if(reachedStart)
                %Turn to Starting Angle
                direction = findTurnDirection(theta(k),startingAngle);
                [keepTurning, UL(k), UR(k)] = turn2GoalAngle(theta(k), startingAngle, direction, rad_offset, wheel_velocity);
                if(~keepTurning)
                    ready(k) = 1;
                end
            else
                [UR(k), UL(k)] = pure_pursuit(xr(k), yr(k), theta(k), goalpoint(1), goalpoint(2) , L);
            end
        end
    end
    if(~any(~ready)) %This says if all are ready we can move on
        orientMode = 0;
    end   
else
    
    % Determine leader index
    for k = 1:N
        if(order(k) == 1)
            leaderindex = k;
            break;
        end
    end
    
    % LEADER MODE
    % Leader follows the path
    [URleader, ULleader] = commandLeader(xr(leaderindex), yr(leaderindex), theta(leaderindex), L, waypoints);
    
    % FOLLOWER MODE
    % Followers follow the robot in front of them
    if(N>1)
        robot_spacing = 1; %Keep robots one meter apart
        [UR, UL] = commandFollower(xr, yr, theta, order, N, robot_spacing, L); % GIVES ALL UR and UL except leaders
    end
    UR(leaderindex) = URleader; %add leaders controls into UR and UL
    UL(leaderindex) = ULleader;
end
end
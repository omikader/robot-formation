%% Ben Cannon
function [UR, UL] = determine_control_Nrobots(z, L, waypoints)
[N, xr, yr, theta, order] = decomposeState(z);

% Initialize global variables
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

% for i = 1:N
%     % find ith robot's leader
%     if(order(i)==1)
%         continue;
%     end
%     for j=1:N
%         if(order(j)==order(i)-1)
%             ileaderindex = j;
%             break;
%         end
%     end
%     % Am I too close to the leader? if so halt
%     
%     iD = sqrt((xr(i)-xr(ileaderindex))^2 + (yr(i)- yr(ileaderindex))^2);
%     istop = 0;
%     if(iD<robot_spacing)
%         istop = 1;
%     end
%     if(istop) % robot is too close to leader
%         UR(i) = 0;
%         UL(i) = 0;
%     else % Follow the leader
%         %[igoalpoint, ~] = findGoalPoint(xr(i), yr(i), xr(i), yr(i), xr(ileaderindex), yr(ileaderindex)); % Goal point is on path to leader
%         igoalpoint = [xr(ileaderindex); yr(ileaderindex)]; % Leader is the goal point
%     % Using pure pursuit to get to goal point on way to leader bot
%         [UR(i), UL(i)] = pure_pursuit(xr(i), yr(i), theta(i), igoalpoint(1), igoalpoint(2) , L);
%     end
% end

% end
end
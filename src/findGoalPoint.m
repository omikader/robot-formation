function [goalpoint, NextFlag] = findGoalPoint(xr, yr, xprev, yprev, xnext, ynext)
% This function implements finds a goal point for the robot to travel to on
% the path it is following one lookahead distance away.  
% If the robot is a distance away from the path this lookahead is adjusted
% based on its distance from the path (LAheadErr).  If the goal point
% surpasses the next waypoint (xnext, ynext) then that is set as the goal
% point and if the robot is within one fixed lookahead distance of the goal 
% the NextFlag is set to 1 so that the robot knows to move on to the next
% leg of the journey

%Fixed Lookahead distance
LAhead=0.1;
%Uses adaptive lookahead to find next goal point

% Adaptive lookahead distance (fig. 6 canadian paper)
w = [xr-xprev, yr-yprev]; % vector from previous waypoint to robot
v = [xnext-xprev, ynext-yprev]; % vector from previous waypoint to next waypoint
b = dot(w,v)/dot(v,v)*v; %the projection of w onto v
bx = xprev+b(1);
by = yprev+b(2);
LAheadErr = sqrt((xr-bx)^2+(yr-by)^2);
LAheadAdapt = LAhead+LAheadErr;
% Find goal point
normal = w-b;
vg = (abs(b(1)+i*b(2))+LAheadAdapt*sin(acos(abs(normal(1)+i*normal(2))/LAheadAdapt)))*(v/(abs(v(1)+i*v(2)))); 
%Vector from prev_wp to goalpoint
if(abs(vg(1)+i*vg(2))>=abs(v(1)+i*v(2)))
    tmpPoint = [xnext, ynext];
else
    tmpPoint = [xprev+vg(1), yprev+vg(2)];
end
goalpoint = tmpPoint;
g = [xnext-xr, ynext-yr]; %vector from robot to next way point
if(abs(g(1)+i*g(2)) < LAhead)
    NextFlag = 1;
else
    NextFlag = 0;
end
end

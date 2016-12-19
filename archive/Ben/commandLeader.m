function [URlead, ULlead] = commandLeader(xr, yr, theta, L, waypoints)
global xprev yprev prevind xnext ynext nextind finish; 
% Find goal point to travel to
[goalpoint, NextFlag] = findGoalPoint(xr, yr, xprev, yprev, xnext, ynext);
if(NextFlag)
    while(NextFlag&&~finish)
        prevind=prevind+1;
        if(prevind >= length(waypoints(:,1)))
            %Go to finish mode
            finish = 1;
        else
            xprev = waypoints(prevind,1);
            yprev = waypoints(prevind,2);
            nextind = nextind+1;
            xnext = waypoints(nextind,1);
            ynext = waypoints(nextind,2);
            [goalpoint, NextFlag] = findGoalPoint(xr, yr, xprev, yprev, xnext, ynext);
        end
    end
end
if(finish) % Case when robot is at the end or needs to wait
    URlead = 0;
    ULlead = 0;
else
    % Using pure pursuit to get to goal point
    [URlead, ULlead] = pure_pursuit(xr, yr, theta, goalpoint(1), goalpoint(2) , L);
end

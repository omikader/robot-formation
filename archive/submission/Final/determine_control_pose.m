function [UR, UL] = determine_control_pose(z, L, waypoints, theta_final)
    % define current state
    xr = z(1); yr = z(2); theta = z(3);

    % ensure theta is within [0, 2pi]
    while ((theta>2*pi())||(theta<0)) 
        if (theta>2*pi())
            theta=theta-2*pi();
        else
            theta = theta+2*pi();
        end
    end

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

    if (orientMode)
        % Turning Parameters
        degree_offset = 45;
        rad_offset = degree_offset*(pi()/180);
        wheel_velocity=5;
        % Determine goal angle
        goal_angle = findGoalAngle(xr, yr, xnext, ynext);
        % Determine turning direction
        direction = findTurnDirection(theta,goal_angle);
        [orientMode UL UR] = turn2GoalAngle(theta, goal_angle, direction, rad_offset, wheel_velocity);    

    else
        % Find the goalpoint to travel to
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

        % Case when robot is at the end or needs to wait
        if (finish)
            degree_offset = 2;
            rad_offset = degree_offset*(pi()/180);
            wheel_velocity = 3;
            direction = findTurnDirection(theta,theta_final);
            [orientMode UL UR] = turn2GoalAngle(theta, theta_final, direction, rad_offset, wheel_velocity);    
        else
            % Using pure pursuit to get to goal point
            [UR, UL] = pure_pursuit(xr, yr, theta, goalpoint(1), goalpoint(2) , L);
        end
    end
end
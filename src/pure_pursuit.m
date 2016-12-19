%% Ben Cannon
% Pure Pursuit
function [UR, UL] = pure_pursuit(xr, yr, theta, xg, yg, L)
% This function finds the finds the radius of an arc that a vehicle 
% must follow to bring it from its current position to the goal position 
% using findChordRadius. 
% It then finds the radius of the near and far wheels along that radius and 
% Sets UR and UL appropriately so the robot will follow the arc on a left
% turn or a right turn.
velocity = 5;

% Get the radius of chord we need to trace
r = findChordRadius(xr, yr, theta, xg, yg);

%Radii for near and far wheel
rFar = r+L/2;
rNear = r-L/2;


% Determine goal angle to find if turning left or right
goal_angle = findGoalAngle(xr, yr, xg, yg);
direction = findTurnDirection(theta,goal_angle);
% Determine UL and UR
if(isinf(r))
    if(theta==goal_angle) %case where goal is right infront r is infinite
        UL = velocity;
        UR = UL;
    else    %Case where goal is directly behind r is also infinite
        UL = velocity;
        UR = -UL;
    end
else
    if(strcmp(direction, 'left')) % Turn Left
        UR = velocity;
        UL = (rNear/rFar)*UR;
    elseif(strcmp(direction, 'right')) % Turn Right
        UL = velocity;
        UR = (rNear/rFar)*UL;        
    end
end
end

%% Ben Cannon
% Pure Pursuit
function [UR, UL] = pure_pursuit(xr, yr, theta, xg, yg, L)

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
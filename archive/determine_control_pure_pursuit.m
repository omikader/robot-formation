%% Ben Cannon
% Pure Pursuit
function [UR, UL] = determine_control_pure_pursuit(z, xg, yg, L)

velocity = 5;
% Name robot coordinates just so its easier to write
xr = z(1); yr = z(2); theta = z(3);

% Get the radius of chord we need to trace
r = findChordRadius(z, xg, yg);

%Radii for near and far wheel
rFar = r+L/2;
rNear = r-L/2;

% Determine UL and UR
UL = velocity;
% Determine goal angle to find if turning left or right
if(xg-xr==0)
    if(yg > yr)
        goal_angle = pi()/2;
    elseif(yg < yr)
        goal_angle = -pi()/2;
    end
else
    goal_angle = atan((yg-yr)/(xg-xr));
end
if(theta<goal_angle)
    UR = (rFar/rNear)*UL;
else
    UR = velocity;
    UL = (rFar/rNear)*UR;
end
end

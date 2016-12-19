%% Ben Cannon
% Calculates the radius for the circle used in purepursuit 
function r = findChordRadius(xr, yr, theta, xg, yg)
% This function finds the finds the radius of an arc that a vehicle 
% must follow to bring it from its current position to the goal position 

% Convert to vehicle frame coordinates 
% (for theta measured from x axis)
xgv = (xg - xr)*sin(theta) - (yg-yr)*cos(theta);
ygv = (xg - xr)*cos(theta) + (yg-yr)*sin(theta);

% Distance from vehicle 
D = sqrt(xgv^2 + ygv^2);

%gamma equals 1/radius and is the curvature of the circle;
gamma = 2*(abs(xgv))/(D^2);
r = 1/gamma;
end

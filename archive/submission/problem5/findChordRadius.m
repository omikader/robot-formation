%% Ben Cannon
% Calculates the radius for the circle used in purepursuit 
function r = findChordRadius(xr, yr, theta, xg, yg)
% Convert to vehicle frame coordinates (Different from paper I've found for
% theta from x axis)
xgv = (xg - xr)*sin(theta) - (yg-yr)*cos(theta);
ygv = (xg - xr)*cos(theta) + (yg-yr)*sin(theta);

% Distance from vehicle 
D = sqrt(xgv^2 + ygv^2);

%gamma equals 1/radius and is the curvature of the circle;
gamma = 2*(abs(xgv))/(D^2);
r = 1/gamma;
end

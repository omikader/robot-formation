function starting_points = findStartingPoints(waypoints, N, spacing)
% Function finds the starting points for N robots based on the first two
% waypoints so that the N robots form an equally spaced line pointing along
% the line connecting said waypoints.

%Assumes waypoints >=2
v = waypoints(2,:)-waypoints(1,:);
starting_vector = spacing*(-v/abs(v(1)+i*v(2)));
for k=1:N
starting_points(k,:) = waypoints(1,:)+starting_vector*(k-1);
end
end


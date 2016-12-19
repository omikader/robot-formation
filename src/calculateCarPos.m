function [ordered_startingPoints,startingAngle,order] = calculateCarPos(carStates,waypoints,numRobots)
% Function determines the order of the cars based on their distances from
% the first way point and each cars starting points and starting angles to
% line up at.
spacing=1;
starting_points = findStartingPoints(waypoints, numRobots, spacing);

for l=1:numRobots
    myDistance(l) = sqrt((carStates(l, 1)-waypoints(1,1))^2 + (carStates(l,2) - waypoints(1,2))^2);
end

B = sort(myDistance);
for k = 1:numRobots
    for p=1:numRobots
        if (B(p) == myDistance(k))
            order(k) = p;
            ordered_startingpointx(k)=starting_points(p,1);
            ordered_startingpointy(k)=starting_points(p,2);
        end
    end
end
goal_angle = findGoalAngle(waypoints(1,1),waypoints(1,2),waypoints(2,1),waypoints(2,2)); 
startingAngle = goal_angle;
for k = 1:length(ordered_startingpointx)
    ordered_startingPoints(k,:) = [ordered_startingpointx(k),ordered_startingpointy(k)];
end

end


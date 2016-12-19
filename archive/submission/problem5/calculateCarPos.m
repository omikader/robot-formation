function [ordered_startingPoints,startingAngle,order] = calculateCarPos(carStates,waypoints,numRobots)

spacing=1;
starting_points = findStartingPoints(waypoints, numRobots, spacing);

for l=1:numRobots
    myDistance(l) = sqrt((carStates(l, 1)-waypoints(1,1))^2 + (carStates(l,2) - waypoints(1,2))^2);
end

%myDistance = distances(carLetter); %Unnecessary
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
goal_angle = findGoalAngle(waypoints(1,1),waypoints(1,2),waypoints(2,1),waypoints(2,2)); % I MADE A CHANGE
% goal_angle =
% findGoalAngle(waypoints(1),waypoints(2),waypoints(3),waypoints(4)); % ORIGINAL I DONT THINK IS CORRECT

startingAngle = goal_angle;
for k = 1:length(ordered_startingpointx)
    ordered_startingPoints(k,:) = [ordered_startingpointx(k),ordered_startingpointy(k)];
end

end


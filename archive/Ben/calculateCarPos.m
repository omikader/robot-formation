function [x,y,theta] = calculateCarPos(carStates,goalX,goalY,goalTheta,carLetter,numRobots)

for i=1:numRobots
    distances(i) = sqrt((carStates((i-1)*3 + 1)-goalX)^2 + (carStates((i-1)*3 +2) - goalY)^2);
end



myDistance = distances(carLetter);

B = sort(distances);

for i=1:numRobots
    if (B(i) == myDistance)
        myPos=i-1;
    end
end

x = goalX;
y = goalY - myPos;
theta = goalTheta;


%cars={1,2,3,4,5};


% mapObj= containers.Map(cars,distances);



%  x=values(Mapobj)((carLetter-1)*3 +1)
% y=values(Mapobj)((carLetter-1)*3 +2)
%  theta=1;
end

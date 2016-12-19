%% Ben Cannon
function [t,z] = main_part2

prompt = 'Enter Number of Robots';
numRobots = input(prompt);

% Car states hold x,y and theta for all the robots. Its in order 
% Car1X, Car1Y, Car1Theta, Car2X, Car2Y, Car2Theta...
carStates=zeros(1,numRobots*3);

% Initialize robots coordinates
prompt = 'Enter CUSTOM or RANDOM for the initial coordinates';
x = input(prompt,'s');

if strcmp(x,'CUSTOM')
	prompt='Enter the x,y,theta for all five cars one at a time';
	for i=1:(numRobots*3)
		carStates(i)=input(prompt);
	end
else
    for i=1:(numRobots*3)
        carStates(i) = 5*rand(1);
    end
end

%Print states to command window
carStates

% MEET with have the robots converge and line up at some point,
% where path follows the waypoint
prompt = 'Enter MEET to meet in a line, or enter PATH to meet and follow a path';
x = input(prompt)

if strcmp(x,'MEET')
    prompt = 'Enter minTotalDistance or minTime';
    x = input(prompt)

    %minTime selected, calculate the smallest enclosing circle location
    if strcmp(x,'minTime')
        myX = [];
        myY = [];
        for i=1:numRobots
            myX = [myX carStates((i-1)*3 +1)];
            myY = [myY carStates((i-1)*3 +2)];
        end
        [center,radius] = minboundcircle(myX,myY,false);
        target_pose = [center(0) center(1) 0];
   
    % Mean location set, calculate mean X and Y	
    else  
        tempX = 0;
        tempY = 0;
        for i=1:numRobots
            tempX = tempX + carStates((i-1)*3 +1);
            tempY = tempY + carStates((i-1)*3 +2);
        end
        target_pose = [(tempX/numRobots) (tempY/Robots) 0];
    end

% Follow waypoint selected
else  
    prompt = 'Enter CUSTOM or RANDOM for the target pose';
    x = input(prompt,'s')
    if strcmp(x,'CUSTOM')
        prompt = 'Enter the X,Y,Theta for the Target Pose';
        for i=1:3
            target_pose(i)=input(prompt);
        end
    else
        target_pose = [3; 6; pi()/2]; %make this random 
    end

    
    target_pose

    %goalPos will hold the initial target pose for every robots
    goalPos = [];
    for i=1:(numRobots)
        [x,y,theta] = calculateCarPos(carStates,target_pose(1),target_pose(2),target_pose(3),i,numRobots)
        goalPos = [goalPos x y theta];
    end
end

tend=20;
tspan = [0 tend];

figure
xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k'); 
ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k'); 
title('Robot Pose Versus Time','FontSize',16,'FontWeight','bold','Color','k');

for i=1:numRobots
    ic = [carStates((i-1)*3 +1) carStates((i-1)*3 +2) carStates((i-1)*3 +3)]
    target_pose = [goalPos((i-1)*3 +1) goalPos((i-1)*3 +2) goalPos((i-1)*3 +3)]
    opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
    [t,z] = ode45(@(t,z) diffdrive_part2(t,z,target_pose), tspan, ic, opts); % plot(z(:,1),z(:,2));grid
    hold on
    plot(z(:,1),z(:,2));grid
end
end

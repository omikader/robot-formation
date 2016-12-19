function direction = findTurnDirection(theta,goal_angle)
% Function looks to see which which turning direction will result in a
% smaller difference between angles for the robot to traverse.
if(goal_angle>theta)
    if(abs(goal_angle-theta)>pi())
        direction = 'right';
    else
        direction = 'left';
    end
else
    if(abs(goal_angle-theta)>pi())
        direction = 'left';
    else
        direction = 'right';
    end
end
end

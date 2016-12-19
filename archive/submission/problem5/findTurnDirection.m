function direction = findTurnDirection(theta,goal_angle)
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

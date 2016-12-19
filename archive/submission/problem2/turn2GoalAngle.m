function [orientMode UL UR]= turn2GoalAngle(theta, goal_angle, direction, rad_offset, wheel_velocity)
if((theta<=goal_angle+rad_offset&&theta>=goal_angle-rad_offset)) %Close Enough
    orientMode = 0;
    UR = 0;
    UL = 0;
else %Turn
    orientMode = 1;
    if(theta<=goal_angle+rad_offset*2&&theta>=goal_angle-rad_offset*2)
        if(strcmp(direction, 'left')) %turn left
            UR = wheel_velocity/4;
        elseif(strcmp(direction, 'right')) %turn right
            UR = -wheel_velocity/4;
        end
        UL = -UR;
    elseif(theta<=goal_angle+rad_offset*4&&theta>=goal_angle-rad_offset*4)
        if(strcmp(direction, 'left')) %turn left
            UR = wheel_velocity/2;
        elseif(strcmp(direction, 'right')) %turn right
            UR = -wheel_velocity/2;
        end
        UL = -UR;
    else
        if(strcmp(direction, 'left')) %turn left
            UR = wheel_velocity;
        elseif(strcmp(direction, 'right')) %turn right
            UR = -wheel_velocity;
        end
        UL = -UR;
    end
end
end
function [orientMode, UL, UR]= turn2GoalAngle(theta, goal_angle, direction, rad_offset, wheel_velocity)
% Function returns controls UL and UR so that the robot will turn torwards
% it's goal_angle.  As it gets closer the speed of the turn is lowed down.  
% If it is within the rad_offset passed to the function it will send the
% controls back as 0 and set orient mode = 0 (the robot is ready to move
% towards goal).
rvec = [(1/sqrt(2))*cos(theta), (1/sqrt(2))*sin(theta)];
gvec = [(1/sqrt(2))*cos(goal_angle), (1/sqrt(2))*sin(goal_angle)];

a = [rvec, 0]; b = [gvec, 0]; %add a third dimension so that cross below works

%See discussion on determining angles accurately https://www.mathworks.com/matlabcentral/newsreader/view_thread/151925
angle_between =  atan2(norm(cross(a,b)),dot(a,b));

if(angle_between<rad_offset) %Close Enough
    orientMode = 0;
    UR = 0;
    UL = 0;
else %Turn
    orientMode = 1;
    if(angle_between<rad_offset*2)
        if(strcmp(direction, 'left')) %turn left
            UR = wheel_velocity/4;
        elseif(strcmp(direction, 'right')) %turn right
            UR = -wheel_velocity/4;
        end
        UL = -UR;
    elseif(angle_between<rad_offset*4)
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
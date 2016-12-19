function [UR, UL] = determine_control_part2(t,z,target_pose)
wheel_velocity = 5;
% Name coordinates just so its easier to write
x = z(1); y = z(2); theta = z(3);
%Goal Point
xtar = target_pose(1); ytar = target_pose(2); thetafinal = target_pose(3);
% Determine the goal orientation
if(xtar-x==0)
    theta_goal = pi()/2;
else
    theta_goal = atan((ytar-y)/(xtar-x));
end
% Determine Distance left to travel
distance = sqrt((xtar-x)^2 + (ytar-y)^2);
%Initialize Controls
UR = 0;
UL = 0;
%Set Controls
%how many degrees off it can be
degree_offset = 8;
rad_offset = degree_offset*(pi()/180);
%How many meters off it can be
dis_offset = 1;
if((theta<=theta_goal+rad_offset&&theta>=theta_goal-rad_offset))
    if(abs(distance-dis_offset)>0)
    UR = wheel_velocity;
    UL = UR;
    else
        if(theta~=thetafinal)
            UR = wheel_velocity;
            UL = -UR;
        else
            UR = 0;
            UL = 0;
            fprintf('Success');
        end
    end
elseif(theta<=theta_goal+rad_offset*2&&theta>=theta_goal-rad_offset*2)
    UR = wheel_velocity/4;
    UL = -UR;
elseif(theta<=theta_goal+rad_offset*4&&theta>=theta_goal-rad_offset*4)
    UR = wheel_velocity/2;
    UL = -UR;    
else
    UR = wheel_velocity;
    UL = -UR;
    

end

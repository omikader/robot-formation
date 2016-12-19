function [N, xr, yr, theta, order] = decomposeState(z)
% Returns all the different robots pose and order information as well as
% the number of robots.
N = length(z)/4; % Number of robots
for i = 1:N
    if(i ==1)
        xr = z(1); yr = z(2); theta = z(3); order = z(4);
    else
        xr = [xr;z(1+(i-1)*4)]; yr = [yr; z(2+(i-1)*4)]; theta = ...
            [theta;z(3+(i-1)*4)];order = [order;z(4+(i-1)*4)];
    end
    while((theta(i)>2*pi())||(theta(i)<0)) %Ensure theta is in the bounds between [0, 2pi]
        if(theta(i)>2*pi())
            theta(i)=theta(i)-2*pi();
        else
            theta(i) = theta(i)+2*pi();
        end
    end
end
end
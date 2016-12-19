function [UR, UL] = commandFollower(xr, yr, theta, order, N, robot_spacing, L)
for i = 1:N
    % find ith robot's leader
    if(order(i)==1)
        continue;
    end
    for j=1:N
        if(order(j)==order(i)-1)
            ileaderindex = j;
            break;
        end
    end
    % Am I too close to the leader? if so halt
    iD = sqrt((xr(i)-xr(ileaderindex))^2 + (yr(i)- yr(ileaderindex))^2);
    istop = 0;
    if(iD<robot_spacing)
        istop = 1;
    end
    if(istop) % robot is too close to leader
        UR(i) = 0;
        UL(i) = 0;
    else % Follow the leader
        %[igoalpoint, ~] = findGoalPoint(xr(i), yr(i), xr(i), yr(i), xr(ileaderindex), yr(ileaderindex)); % Goal point is on path to leader
        igoalpoint = [xr(ileaderindex); yr(ileaderindex)]; % Leader is the goal point
        % Using pure pursuit to get to goal point on way to leader bot
        [UR(i), UL(i)] = pure_pursuit(xr(i), yr(i), theta(i), igoalpoint(1), igoalpoint(2) , L);
    end
end
end
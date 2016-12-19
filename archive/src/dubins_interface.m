%[ path ] = dubins(q0, q1, r, stepSize) 
%   dubins calculates an interpolated dubins cureve between two points q0 and
%   q1 with circles of radius r at the inputed stepSize.
%
%   q0 = [x1 (1x1), y1 (1x1), theta1 (1x1)];
%   q1 = [x2 (1x1), y2 (1x1), theta2 (1x1)];
%   r  = (1x1);
%   stepSize = (1x1);
%
%   path = [x;y;theta] (3xn) :  n is deteremined within the code but is a
%                               minimum of 1
%
%   The original code is from https://github.com/AndrewWalker/Dubins-Curves

mex dubins_mex 
q0=[0,0,pi/2]; 
q1=[0.001,0,-pi/2]; 
path=dubins_mex(q0,q1,1,0.001); 
plot(path(1,:),path(2,:)); 
grid on;xlabel('x');ylabel('y')
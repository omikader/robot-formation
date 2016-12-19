function plot_Z_pointbypoint(t,z)
% plot Point by Point
iterations = 1;
pausetime = 0.05;
Nrobots = round(length(z(1,:))/4);
figure
xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k');
ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k');    
hold on
for i = 1 : length(z(:,1))
    for k = 1:Nrobots
        plot(z(iterations,1+(k-1)*4),z(iterations,2+(k-1)*4),'.','color',[(k-1)/Nrobots; (k-1)/Nrobots; (k-1)/Nrobots],'markersize',14,'MarkerFaceColor','b');
    end
    title(['Robot Pose Versus Time t = ' num2str(t(iterations))],'FontSize',16,'FontWeight','bold','Color','k');
%   axis([min(z(:,1)) max(z(:,1)) min(z(:,2)) max(z(:,2))]) % NEED BETTER WAY TO FIND AXIS WITH N ROBOTS
    iterations  = iterations + 1;
    pause(pausetime)
end
hold off

end
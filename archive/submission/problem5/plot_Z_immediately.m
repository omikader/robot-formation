function plot_Z_immediately(t, z)
% Plot immediately
figure
hold on
Nrobots = length(z(1,:))/4;
for k = 1:Nrobots
    plot(z(:,1+(k-1)*4),z(:,2+(k-1)*4));
end
grid;
xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k');
ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k');
title('Robot Pose Versus Time','FontSize',16,'FontWeight','bold','Color','k');
axis square
hold off

end
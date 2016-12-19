function [t,z] = main
    % define time boundaries
    tend = 10;
    tspan = [0 tend];

    % define initial conditions
    ic = [0; 0; 0];

    % solve ode
    opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
    [t,z] = ode45(@(t,z) diffdrive_test(t,z), tspan, ic, opts);

    % plot the resulting car behavior
    figure
    iterations = 1;
    pausetime = 0.1;
    for i = 1 : size(z)
        plot(z(iterations,1),z(iterations,2),'.','color',[0; 0; 0],'markersize',14,'MarkerFaceColor','b');
        hold on
        xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k');
        ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k');
        title(['Robot Pose Versus Time t = ' num2str(t(iterations))],'FontSize',16,'FontWeight','bold','Color','k');
        axis([min(z(:,1)) max(z(:,1)) min(z(:,2)) max(z(:,2))])
        iterations  = iterations + 1;
        pause(pausetime)
    end
%     figure
%     plot(z(:,1),z(:,2)); grid
%     axis([0 4.5 -0.2 2.0])
%     xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k'); 
%     ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k'); 
%     title('Robot Pose Versus Time','FontSize',16,'FontWeight','bold','Color','k');
end


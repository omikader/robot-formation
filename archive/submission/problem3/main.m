function [t,z] = main
    clearvars -global
    
    % define time boundaries
    tend = 100;
    tspan = [0 tend];
    
    % define initial conditions
    ic = [0; 0; pi/4];

    % define waypoints/path
    waypoints = [2.00    1.00;
                1.25    1.75;
                5.25    8.25;
                7.25    8.75;
                11.75   10.75;
                12.00   10.00];

    waypoints = [ic(1) ic(2); waypoints];
    
    % solve ode
    opts = odeset('RelTol',1e-2,'AbsTol',1e-4);
    [t,z] = ode45(@(t,z) diffdrive_test(z,waypoints), tspan, ic, opts);
    
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
%     plot(z(:,1),z(:,2));grid
%     xlabel('X Position','FontSize',14,'FontWeight','bold','Color','k');
%     ylabel('Y Position','FontSize',14,'FontWeight','bold','Color','k');
%     title('Robot Pose Versus Time','FontSize',16,'FontWeight','bold','Color','k');
%     axis square
end
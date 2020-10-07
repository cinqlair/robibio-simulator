function nPlots = plot_motor_optim_residual(motors)

    subplot (5,1,1); hold on; grid on;
    plot (motors.power.left(5,:), 'r');
    plot (motors.power.right(5,:), 'b');
    title ('Hip power [W]');
        
    subplot (5,1,2); hold on; grid on;
    plot (motors.power.left(3,:), 'r');
    plot (motors.power.right(3,:), 'b');
    title ('Knee power [W]');
    
    subplot (5,1,3); hold on; grid on;
    plot (motors.power.left(1,:), 'r');
    plot (motors.power.right(1,:), 'b');
    title ('Ankle power [W]');

    subplot (5,1,4); hold on; grid on;
    plot (motors.power.left(4,:), 'r');
    plot (motors.power.right(4,:), 'b');
    title ('Hip-knee power [W]');
    
    subplot (5,1,5); hold on; grid on;
    plot (motors.power.left(2,:), 'r');
    plot (motors.power.right(2,:), 'b');
    title ('Knee-ankle power [W]');


end

